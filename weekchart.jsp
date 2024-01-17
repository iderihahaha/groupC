<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="./css/chart.css" />
<script src="./js/chart.js" type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha256-R4pqcOYV8lt7snxMQO/HSbVCFRPMdrhAFMH+vr9giYI=" crossorigin="anonymous"></script>
<title>週間チャート</title>
<% List<String> weekagegroup = (List<String>)request.getAttribute("weekagegroup");
   List<String> weekgendercount = (List<String>)request.getAttribute("weekgendercount");
%>
<%--<% List<String> countlist = (List<String>)request.getAttribute("count"); --%>
<script type="text/javascript">
    // サーブレットにリクエストを投げる
    function execute() {
        location.href = "/dashboard2/week"
    }
</script>
</head>
<header>
<h1>週間チャート</h1>
</header>
<body>
<div id="d2">&nbsp;</div>
       <div class="button">
        <button onclick="location.href='./monthlychart.jsp'">月別</button>
		 <input type="button" value="週別" onclick="execute()">
 <h1>作品別</h1>
    <div class="chart1">
    	<div style="width: 600px;">
        	<canvas id="chart" width="600" height="300"></canvas>
        </div>
    </div>
    
<h1>年代・性別</h1>
<div class="chart2">
	<div style="width: 300px;">
    	<canvas id="chart_nen" width="150" height="150"></canvas>
</div>

 <div class="chart3">
      <div style="width: 300px;">
           <canvas id="chart_jender" width="150" height="150"></canvas>
        </div>
</div>
        
        
        <SCRIPT>

        setInterval(function() {
        	  document.getElementById("d2").innerHTML = new Date().toLocaleString();
        	}, 1000);


       var weekgenderlist = [<%
            for (int i = 0; i < weekgendercount.size(); i++) {
                out.print("'" + weekgendercount.get(i) + "'");
                if (i < weekgendercount.size() - 1) {
                    out.print(",");
                }
            }
        %>];

        // JavaScriptで配列を表示
        console.log(weekgenderlist); 



        var weekage = [<%
            for (int i = 0; i < weekagegroup.size(); i++) {
                out.print("'" + weekagegroup.get(i) + "'");
                if (i < weekagegroup.size() - 1) {
                    out.print(",");
                }
            }
        %>];

        // JavaScriptで配列を表示
        console.log(weekage);

        var ctx = $('#chart');
        var mychart = new Chart(ctx, {
            type: 'bar',
            data: {
            	labels: [
                    '1日～7日',
                    '2week',
                    '3week',
                    '4week',
                    '5week'
                ],
                datasets: [{
                    label: '映画1',
                    data: weekage,
                    backgroundColor: 'rgba(241, 107, 141, 1)',  //棒グラフの色
                },{
                    label: '映画2',
                    data: [
                        300,1000,1500,5000,3000
                    ],
                    backgroundColor: 'rgba( 31, 167, 165, 1)',  //棒グラフの色
                },{
                    label: '映画3',
                    data: [
                        2000,5000,1000,5000,3000
                    ],
                    backgroundColor: 'rgba(249, 199,  83, 1)',  //棒グラフの色

                }]
            },

            options: {

                //区分わけのコメント
                title: {
                    display: true,
                    text: '上映中の映画（人数別）'
                },

                //棒グラフの文字の調整
                scales: {
                    yAxes: [{
                        ticks: {
                            suggestedMax: 10000,
                            suggestedMin: 0,
                            stepSize: 1000 ,
                            callback: function (value, index, values) {
                                return value + '人';
                            }
                        },
                    }]
                }
            }
        });

        
        var ctx = $('#chart_nen');
        var mychart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: [//data.labels,
                    '10代',
                    '20代',
                    '30代',
                    '40代',
                    '50代',
                    '60代'
                ],
                datasets: [{
                    label: 'サンプルグラフ',
                    data: [
                        10,
                        30,
                        30,
                        10,
                        20,
                        30
                    ],

                    //円グラフの色
                    backgroundColor: [
                        'rgba(241, 107, 141, 1)',
                        'rgba( 31, 167, 165, 1)',
                        'rgba(249, 199,  83, 1)',
                        'rgba(176, 110,  30, 1)',
                        'rgba(124,  91, 164, 1)',
                        'green'
                    ]
                }]
            },
            options: {

                    //円グラフのコメント
                title: {
                        display: true,
                        text: '来場者（年代別）'
                    },

                    //区分わけの位置
                legend: {
                    position: 'bottom',
                },
                scales: {
                    yAxes: [{
                        ticks: {
                            display: false,
                            beginAtZero: true,
                        },
                        gridLines: {
                            display: false
                        }
                    }]
                }
            }
        //}
        //)
        });

        //中央の文字
        Chart.pluginService.register({
        afterDraw: function(chart) {
            if (chart.config.type === 'pie') {
                var width = chart.chart.width,
                    height = chart.chart.height,
                    ctx = chart.chart.ctx;

                ctx.restore();
                var fontSize = (height / 300).toFixed(2);
                ctx.font = fontSize + "em sans-serif";
                ctx.textBaseline = "middle";

                var text = "中央のテキスト",
                    textX = Math.round((width - ctx.measureText(text).width) / 2),
                    textY = height / 4;

                ctx.fillText(text, textX, textY);
                ctx.save();
            }
        }
    });


        var ctx = $('#chart_jender');
        var mychart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: [//data.labels,
                    '男性',
                    '女性'
                ],
                datasets: [{
                    label: 'サンプルグラフ',
                    data: weekgenderlist,

                    //円グラフの色
                    backgroundColor: [
                        'rgba( 31, 167, 165, 1)',
                        'rgba(241, 107, 141, 1)'
                    ],
                }]
            },
            options: {

                    //円グラフのコメント
                title: {
                        display: true,
                        text: '来場者（性別別）'
                    },

                    //区分わけの位置
                legend: {
                    position: 'bottom',
                },
                scales: {
                    yAxes: [{
                        ticks: {
                            display: false,
                            beginAtZero: true,
                        },
                        gridLines: {
                            display: false
                        }
                    }]
                }
            }
        //}
        //)
        });

        //中央の文字
        Chart.pluginService.register({
        afterDraw: function(chart) {
            if (chart.config.type === 'pie') {
                var width = chart.chart.width,
                    height = chart.chart.height,
                    ctx = chart.chart.ctx;

                ctx.restore();
                var fontSize = (height / 300).toFixed(2);
                ctx.font = fontSize + "em sans-serif";
                ctx.textBaseline = "middle";

                var text = "中央のテキスト",
                    textX = Math.round((width - ctx.measureText(text).width) / 2),
                    textY = height / 4;

                ctx.fillText(text, textX, textY);
                ctx.save();
            }
        }
    });

    </SCRIPT>
</body>
</html>