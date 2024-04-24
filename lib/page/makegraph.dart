import 'package:flutter/material.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  List result;
  int index_color;
  Graph({super.key, required this.result, required this.index_color});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
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
    List<variablemoney> graph = [];
    List<variablemoney> graphsort = [];
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
        double sumAmount = 0.0;
        if (_index_color == 0) {
          for (var data in _result) {
            var datetimeInDB =
                "${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}-${data.datetime.day.toString().padLeft(2, "0")}";
            var datetimeDay =
                "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}-${DateTime.now().day.toString().padLeft(2, "0")}";
            if (datetimeInDB == datetimeDay) {
              DateTime time = data.datetime;
              timesort.add(data.datetime);
              if (data.type == "รายรับ") {
                sumAmount = sumAmount + data.amount;
              } else if (data.type == "รายจ่าย") {
                sumAmount = sumAmount - data.amount;
              }

              graph.add(variablemoney(time, sumAmount));
            }
          }
          DateTimeSort(graph, graphsort, timesort);
        } else if (_index_color == 1) {
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
                  sumAmount = sumAmount + data.amount;
                  print("sumAmount in รายรับ : $sumAmount");
                } else if (data.type == "รายจ่าย") {
                  sumAmount = sumAmount - data.amount;
                  print("sumAmount in รายจ่าย : $sumAmount");
                }
                graph.add(variablemoney(time, sumAmount));
              }
            }
          }
          DateTimeSort(graph, graphsort, timesort);
        } else if (_index_color == 2) {
          for (var data in _result) {
            var datetimeInDB =
                "${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}";
            var datetimeMonth =
                "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}";
            if (datetimeInDB == datetimeMonth) {
              DateTime time = data.datetime;
              timesort.add(data.datetime);
              if (data.type == "รายรับ") {
                sumAmount = sumAmount + data.amount;
              } else if (data.type == "รายจ่าย") {
                sumAmount = sumAmount - data.amount;
              }
              graph.add(variablemoney(time, sumAmount));
            }
          }
          DateTimeSort(graph, graphsort, timesort);
        } else if (_index_color == 3) {
          for (var data in _result) {
            var datetimeInDB = "${data.datetime.year}";
            var datetimeMonth = "${DateTime.now().year}";
            if (datetimeInDB == datetimeMonth) {
              DateTime time = data.datetime;
              timesort.add(time);
              if (data.type == "รายรับ") {
                sumAmount = sumAmount + data.amount;
              } else if (data.type == "รายจ่าย") {
                sumAmount = sumAmount - data.amount;
              }
              graph.add(variablemoney(time, sumAmount));
            }
          }
          DateTimeSort(graph, graphsort, timesort);
        }

        return SfCartesianChart(
          primaryXAxis: _index_color == 0
              ? const DateTimeAxis(
                  intervalType: DateTimeIntervalType.hours, interval: 0.5)
              : _index_color == 1
                  ? const DateTimeAxis(
                      intervalType: DateTimeIntervalType.days, interval: 0.5)
                  : _index_color == 2
                      ? const DateTimeAxis(
                          intervalType: DateTimeIntervalType.days,
                          interval: 0.5)
                      : const DateTimeAxis(
                          intervalType: DateTimeIntervalType.months,
                          interval: 0.5),
          series: <CartesianSeries<variablemoney, DateTime>>[
            LineSeries<variablemoney, DateTime>(
              width: 2,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              color: AppColors.textblue,
              dataSource: graphsort,
              xValueMapper: (variablemoney data, _) => data.datetime,
              yValueMapper: (variablemoney data, _) => data.Allamount,
            )
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
