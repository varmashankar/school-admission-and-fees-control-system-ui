(function (window, $) {
    'use strict';

    // Initializes a DataTable for the given selector.
    // selector - jQuery selector for the table (e.g. '#tblStudents' or '.my-table')
    // userOptions - DataTables options object (optional)
    window.initDataTable = function (selector, userOptions) {
        userOptions = userOptions || {};
        var $table = $(selector);
        if (!$table.length) return null;

        // If a DataTable is already initialized on this table, destroy it first
        if ($.fn.DataTable.isDataTable($table)) {
            try {
                $table.DataTable().destroy();
            } catch (e) {
                // ignore destroy errors
            }
            // unbind any bound filter events
            $table.find('thead .filters input').off('.dtfilter');
        }

        var defaults = {
            pageLength: 10,
            ordering: true
        };

        var options = $.extend({}, defaults, userOptions);

        // If caller provided their own initComplete, call it in addition to the built-in column filter hookup.
        var userInitComplete = options.initComplete;

        options.initComplete = function () {
            var api = this.api();

            // For each column, try to find a corresponding input in a header row with class 'filters'.
            api.columns().every(function (colIdx) {
                var column = this;

                // Prefer the filters row if present: match by index
                var $filtersRow = $table.find('thead tr.filters');
                var $input = $();
                if ($filtersRow.length) {
                    $input = $filtersRow.find('th').eq(colIdx).find('input');
                }

                // Fallback: look for an input inside the column header cell
                if (!$input.length) {
                    $input = $(column.header()).find('input');
                }

                if ($input.length) {
                    $input.on('keyup.dtfilter change.dtfilter clear.dtfilter', function () {
                        var val = this.value;
                        if (column.search() !== val) {
                            column.search(val).draw();
                        }
                    });
                }
            });

            // call user provided initComplete if any
            if (typeof userInitComplete === 'function') {
                try { userInitComplete.call(this); } catch (e) { /* ignore */ }
            }
        };

        var dt = $table.DataTable(options);
        return dt;
    };
    
})(window, jQuery);
window.activateDataTable = function (selector, options) {
    selector = selector || '#tblStudents' || '#gvAcademicYears';
    return window.initDataTable(selector, options);
};
