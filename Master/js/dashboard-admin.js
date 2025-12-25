(function (window) {
  'use strict';

  function renderAdmissionsChart(canvasId, labels, values) {
    var el = document.getElementById(canvasId);
    if (!el || !window.Chart) return;

    var ctx = el.getContext('2d');

    // destroy existing instance if any
    if (el._chartInstance) {
      try { el._chartInstance.destroy(); } catch (e) { }
      el._chartInstance = null;
    }

    el._chartInstance = new window.Chart(ctx, {
      type: 'line',
      data: {
        labels: labels || [],
        datasets: [{
          label: 'Admissions',
          data: values || [],
          borderColor: 'rgba(13, 110, 253, 1)',
          backgroundColor: 'rgba(13, 110, 253, 0.10)',
          fill: true,
          tension: 0.35,
          pointBackgroundColor: 'rgba(13, 110, 253, 1)',
          pointBorderColor: '#fff',
          pointHoverRadius: 6,
          pointHoverBackgroundColor: 'rgba(13, 110, 253, 1)',
          pointRadius: 4
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { display: false },
          tooltip: { intersect: false, mode: 'index' }
        },
        scales: {
          y: {
            beginAtZero: true,
            grid: { color: 'rgba(0,0,0,.05)' },
            ticks: { precision: 0 }
          },
          x: {
            grid: { display: false }
          }
        }
      }
    });
  }

  // exposes global for page usage
  window.DashboardAdmin = window.DashboardAdmin || {};
  window.DashboardAdmin.renderAdmissionsChart = renderAdmissionsChart;
})(window);
