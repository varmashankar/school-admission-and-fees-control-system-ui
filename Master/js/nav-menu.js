document.addEventListener('DOMContentLoaded', function () {
    const body = document.body;
    const sidebar = document.getElementById('sidebar');
    const btnCollapse = document.getElementById('btnCollapse');
    const collapseIcon = document.getElementById('collapseIcon');
    const overlay = document.getElementById('sidebarOverlay');
    const btnMobileOpen = document.getElementById('btnMobileOpen');

    // Desktop Sidebar Collapse
    btnCollapse?.addEventListener('click', function () {
        body.classList.toggle('sidebar-collapsed');
        collapseIcon.classList.toggle('bi-chevron-right');
        collapseIcon.classList.toggle('bi-chevron-left');
    });

    // Mobile Sidebar Toggle
    btnMobileOpen?.addEventListener('click', function () {
        sidebar.classList.add('is-open');
        overlay.classList.remove('hidden');
    });

    overlay?.addEventListener('click', function () {
        sidebar.classList.remove('is-open');
        overlay.classList.add('hidden');
    });

    // Highlight active link
    const currentPage = window.location.pathname.split("/").pop();
    document.querySelectorAll('.sidebar-link').forEach(link => {
        if (link.getAttribute('href') === currentPage) {
            link.classList.add('active');
        }
    });
});

function updateSidebarTooltips() {
    const isCollapsed = document.body.classList.contains("sidebar-collapsed");
    const elements = document.querySelectorAll('[data-bs-toggle="tooltip"]');

    elements.forEach(el => {
        // Dispose existing tooltip if any
        if (el._tooltipInstance) {
            el._tooltipInstance.dispose();
            el._tooltipInstance = null;
        }

        // Recreate tooltip only if collapsed
        if (isCollapsed) {
            el._tooltipInstance = new bootstrap.Tooltip(el);
        }
    });
}


const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
tooltipTriggerList.forEach(el => {
    new bootstrap.Tooltip(el, {
        placement: 'right',
        fallbackPlacements: []   // no fallback, never flip
    });
});

document.addEventListener("DOMContentLoaded", () => {
    const currentPath = window.location.pathname.toLowerCase();

    document.querySelectorAll(".sidebar-link").forEach(link => {
        const href = link.getAttribute("href").toLowerCase();

        if (currentPath === href || currentPath.endsWith(href)) {
            link.classList.add("active");
        }
    });
});
