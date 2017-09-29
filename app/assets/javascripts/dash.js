function drawGauge(data) {
    var a = new Array(['label','value']);
    console.log(a)
    a.push.apply(a,data);
    var data = google.visualization.arrayToDataTable(a);
    var options = {
        width: 400, height: 120,
        minorTicks: 5,
        redColor: '#E33440',
        yellowColor: '#F7B245',
    };
    options.max = a.slice(1).reduce(function(x,y) {
        return Math.max(x,y[1]);
    }, 0);
    options.redTo = options.max;
    options.redFrom = options.max*9/10;
    options.yellowTo = options.redFrom;
    options.yellowFrom = options.max*3/4;
    var chart = new google.visualization.Gauge(document.getElementById("chart_div"));
    chart.draw(data, options);
};