import 'package:flutter/material.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  List result;
  int index_color;
  PieChart({super.key, required this.result, required this.index_color});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  late List<PiedataChart> dataPieChart;
  late TooltipBehavior _tooltip;

  void sum() {}

  @override
  void initState() {
    dataPieChart = [];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  void DateTimeSort(
    List<variablemoney> Graph,
    List<variablemoney> Graphsort,
    List<DateTime> Timesort,
  ) {
    //Graph = [];
    Timesort.sort();
    for (var t in Timesort) {
      for (var g in Graph) {
        if (g.datetime == t) {
          DateTime timeDateTime = g.datetime;
          Graphsort.add(variablemoney(timeDateTime, g.Allamount));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    List<DateTime> timesort = [];
    List _result = widget.result;
    int _index_color = widget.index_color;
    print("เข้ามาหน้า กราฟ โหลด Graph ");
    print("_result :$_result ");
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: ([AppColors.bglevel1, AppColors.bglevel2]),
        ),
      ),
      width: double.infinity,
      height: Hscreen * H450,
      child: Builder(builder: (Context) {
        double sumIncometochart = 0.0;
        double sumexpensestochart = 0.0;
        if (_index_color == 0) {
          dataPieChart = [];
          for (var data in _result) {
            var datetimeInDB =
                "${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}-${data.datetime.day.toString().padLeft(2, "0")}";
            var datetimeDay =
                "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}-${DateTime.now().day.toString().padLeft(2, "0")}";
            if (datetimeInDB == datetimeDay) {
              DateTime time = data.datetime;
              timesort.add(data.datetime);
              if (data.type == "รายรับ") {
                sumIncometochart = sumIncometochart + data.amount;
              } else if (data.type == "รายจ่าย") {
                sumexpensestochart = sumexpensestochart - data.amount;
              }
            }
          }

          dataPieChart = [
            PiedataChart('รายรับ', sumIncometochart),
            PiedataChart('รายจ่าย', sumexpensestochart)
          ];
        } else if (_index_color == 1) {
          dataPieChart = [];
          for (var data in _result) {
            List dayinweek = [];
            for (var i = 0; i <= 6; i++) {
              var dodayEnd = int.parse(DateTime.now().day.toString()) - i;
              DateTime day =
                  DateTime(DateTime.now().year, DateTime.now().month, dodayEnd);
              dayinweek.add(day);
            }

            var datetimeInDB =
                "${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}-${data.datetime.day.toString().padLeft(2, "0")}";
            for (var day in dayinweek) {
              var dayweekstring =
                  "${day.year}-${day.month.toString().padLeft(2, "0")}-${day.day.toString().padLeft(2, "0")}";
              if (datetimeInDB == dayweekstring) {
                //print("day in var day in dayinweek: $day");
                DateTime time = data.datetime;
                print("time in var day in dayinweek: $time");
                timesort.add(data.datetime);
                print("timesort in var day in dayinweek: $timesort");
                if (data.type == "รายรับ") {
                  sumIncometochart = sumIncometochart + data.amount;
                  print("sumIncometochart in รายรับ : $sumIncometochart");
                } else if (data.type == "รายจ่าย") {
                  sumexpensestochart = sumexpensestochart - data.amount;
                  print("sumexpensestochart in รายจ่าย : $sumexpensestochart");
                }
              }
            }
          }
          dataPieChart = [
            PiedataChart('รายรับ', sumIncometochart),
            PiedataChart('รายจ่าย', sumexpensestochart)
          ];
        } else if (_index_color == 2) {
          dataPieChart = [];
          for (var data in _result) {
            var datetimeInDB =
                "${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}";
            var datetimeMonth =
                "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}";
            if (datetimeInDB == datetimeMonth) {
              DateTime time = data.datetime;
              timesort.add(data.datetime);
              if (data.type == "รายรับ") {
                sumIncometochart = sumIncometochart + data.amount;
              } else if (data.type == "รายจ่าย") {
                sumexpensestochart = sumexpensestochart - data.amount;
              }
            }
          }
          dataPieChart = [
            PiedataChart('รายรับ', sumIncometochart),
            PiedataChart('รายจ่าย', sumexpensestochart)
          ];
        } else if (_index_color == 3) {
          dataPieChart = [];
          for (var data in _result) {
            var datetimeInDB = "${data.datetime.year}";
            var datetimeMonth = "${DateTime.now().year}";
            if (datetimeInDB == datetimeMonth) {
              DateTime time = data.datetime;
              timesort.add(time);
              if (data.type == "รายรับ") {
                sumIncometochart = sumIncometochart + data.amount;
              } else if (data.type == "รายจ่าย") {
                sumexpensestochart = sumexpensestochart - data.amount;
              }
            }
          }
          dataPieChart = [
            PiedataChart('รายรับ', sumIncometochart),
            PiedataChart('รายจ่าย', sumexpensestochart)
          ];
        }

        return SfCircularChart(
          enableMultiSelection: true,
          tooltipBehavior: _tooltip,
          series: <CircularSeries<PiedataChart, String>>[
            DoughnutSeries<PiedataChart, String>(
                explode: true,
                explodeAll: true,
                dataSource: dataPieChart,
                dataLabelMapper: (PiedataChart data, _) => data.x,
                xValueMapper: (PiedataChart data, _) => data.x,
                yValueMapper: (PiedataChart data, _) => data.y,
                name: 'Gold')
          ],
        );
      }),
    );
  }
}

class variablemoney {
  variablemoney(this.datetime, this.Allamount);
  final DateTime datetime;
  final double Allamount;
}

class PiedataChart {
  PiedataChart(this.x, this.y);

  final String x;
  final double y;
}
