define(["jquery", "highcharts", "socketio"], function($, Highcharts, io) {
  $(document).ready(function() {
    var chart = new Highcharts.Chart({
      chart: {
        zoomType: "xy",
        margin: [80, 80, 80, 80],
        renderTo: "container"
      },
      title: {
        text: "CPU Load Average & Memory Usage"
      },
      subtitle: {
        text: "Plotting CPU Load and Memory Info in real-time using websockets."
      },
      xAxis: {
        gridLineWidth: 5,
        maxZoom: 60
      },
      yAxis: [
        {
          title: {
            text: "Memory %age"
          },
          min: 0,
          max: 100,
          plotLines: [
            {
              value: 0,
              width: 1,
              colour: "#808800"
            }
          ],
          opposite: true
        },
        {
          title: {
            text: "LoadAvg"
          },
          min: 0,
          plotLines: [
            {
              value: 0,
              width: 1,
              colour: "#008888",
              zIndex: 0
            }
          ]
        }
      ],
      plotOptions: {
        column: {
          pointPadding: 0,
          groupPadding: 0
        }
      },
      series: [
        {
          name: "MemInfo",
          type: "column",
          color: "#008800",
          grouping: false,
          yAxis: 0,
          data: []
        },
        {
          name: "CpuLoad",
          type: "spline",
          yAxis: 1,
          data: []
        }
      ]
    });

    var socket = io.connect(
      window.location.protocol + "//" + window.location.hostname
    );

    socket.on("loadavg", data => {
      var series = chart.series[1];
      series.addPoint([data.onemin], true, series.data.length > 100);
    });
    socket.on("memory", data => {
      var series = chart.series[0];
      series.addPoint([data.used], true, series.data.length > 100);
    });
  });
});
