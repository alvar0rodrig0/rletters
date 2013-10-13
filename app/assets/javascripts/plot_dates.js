// ---------------------------------------------------------------------------
// Graph support for the PlotDates results page
google.load('visualization', '1.0', {'packages':['corechart','table']});

function createPlotDatesGraph() {
  // Get the elements we need
  var dataContainer = $.mobile.activePage.find('div.plot_dates_data');
  var percentContainer = $.mobile.activePage.find('div.plot_dates_percent');
  var graphContainer = $.mobile.activePage.find('div.plot_dates_graph');
  var tableContainer = $.mobile.activePage.find('div.plot_dates_table');
  if (graphContainer.length === 0 || dataContainer.length === 0 ||
      percentContainer.length === 0 || tableContainer.length === 0)
    return;

  // Make a DataTable object
  var data = new google.visualization.DataTable();
  var rows = $.parseJSON(dataContainer.html());
  var percent = percentContainer.html() == 'true';

  data.addColumn('number', 'Year');
  if (percent) {
    data.addColumn('number', 'Fraction of Documents');
  } else {
    data.addColumn('number', 'Number of Documents');
  }
  data.addRows(rows);

  // Make the line chart object
  var w = $(window).width();
  if (w > 750) {
    w = 750;
  }

  var h;
  if (w > 480) {
    h = 480;
  } else {
    h = w;
  }

  var options = { width: w, height: h,
                  legend: { position: 'none' },
                  hAxis: { format: '####',
                           title: 'Year of publication' },
                  vAxis: { title: 'Number of documents' },
                  pointSize: 3 };
  if (percent) {
    options.vAxis.format = '###%';
    options.vAxis.title = 'Percentage of documents';
  }

  var chart = new google.visualization.LineChart(graphContainer[0]);
  chart.draw(data, options);

  graphContainer.trigger('updatelayout');

  // Make a pretty table object
  var table = new google.visualization.Table(tableContainer[0]);
  table.draw(data, { page: true, pageSize: 20, sortColumn: 0, width: '20em' });
}

$(document).on('ready', function() { createPlotDatesGraph(); });
