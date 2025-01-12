import 'package:flutter/material.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/database/financedata.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  List<Finance>? financeInTopic;
  int index_color;
  Graph({super.key, required this.financeInTopic, required this.index_color});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  List<Finance>? _financeInTopic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _financeInTopic = widget.financeInTopic;
  }

  void DateTimeSort(
    List<Finance> Graph,
    List<variablemoney> Graphsort,
    List<DateTime> Timesort,
  ) {
    //Graph = [];
    // Timesort.reversed;
    // print(Timesort.reversed);
    double allamount = 0.0;
    print(Graph);
    for (var t in Timesort.reversed) {
      for (var g in Graph) {
        if (DateFormat("yyyy-MM-dd HH:mm:ss").parse(g.date.toString()) == t) {
          print(g.date);
          DateTime timeDateTime =
              DateFormat("yyyy-MM-dd HH:mm:ss").parse(g.date.toString());
          if (g.income != "0") {
            allamount = allamount + double.parse(g.income.toString());
            print("$timeDateTime and  ${allamount}");
          } else if (g.income == "0") {
            allamount = allamount - double.parse(g.expense.toString());
            print("$timeDateTime and  ${allamount}");
          }
          //print("$timeDateTime and  ${allamount}");
          Graphsort.add(variablemoney(timeDateTime, allamount));
        }
      }
    }
  }

  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    List<variablemoney> graphsort = [];
    List<DateTime> timesort = [];
    List<Finance> graph = [];
    int _index_color = widget.index_color;
    print("เข้ามาหน้า กราฟ โหลด Graph ");
    print("_financeInTopic :$_financeInTopic ");
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: ([AppColors.bglevel1, AppColors.bglevel2]),
        ),
      ),
      width: double.infinity,
      height: Hscreen * H450,
      child: Builder(builder: (Context) {
        if (_index_color == 0) {
          for (var data in _financeInTopic!) {
            var datetimeInDB = "${data.date.toString().substring(0, 10)}";
            //"${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}-${data.datetime.day.toString().padLeft(2, "0")}";
            var datetimeDay =
                "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}-${DateTime.now().day.toString().padLeft(2, "0")}";

            if (datetimeInDB == datetimeDay) {
              timesort.add(DateFormat("yyyy-MM-dd HH:mm:ss").parse(data.date!));
              //print(timesort);
              graph.add(data);
              print(graph);
            }
          }
          DateTimeSort(graph, graphsort, timesort);
          //print("graph : ${graph}");
        } else if (_index_color == 1) {
          for (var data in _financeInTopic!) {
            List dayinweek = [];
            for (var i = 0; i <= 6; i++) {
              var dodayEnd = int.parse(DateTime.now().day.toString()) - i;
              DateTime day =
                  DateTime(DateTime.now().year, DateTime.now().month, dodayEnd);
              dayinweek.add(day);
            }

            var datetimeInDB = "${data.date.toString().substring(0, 10)}";
            //"${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}-${data.datetime.day.toString().padLeft(2, "0")}";
            for (var day in dayinweek) {
              var dayweekstring =
                  "${day.year}-${day.month.toString().padLeft(2, "0")}-${day.day.toString().padLeft(2, "0")}";

              if (datetimeInDB == dayweekstring) {
                timesort.add(DateFormat("yyyy-MM-dd HH:mm:ss")
                    .parse(data.date.toString()));
                graph.add(data);
              }
            }
          }
          DateTimeSort(graph, graphsort, timesort);
        } else if (_index_color == 2) {
          for (var data in _financeInTopic!) {
            var datetimeInDB = "${data.date.toString().substring(0, 7)}";
            //"${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}";
            var datetimeMonth =
                "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}";
            if (datetimeInDB == datetimeMonth) {
              timesort.add(DateFormat("yyyy-MM-dd HH:mm:ss")
                  .parse(data.date.toString()));
              graph.add(data);
            }
          }
          DateTimeSort(graph, graphsort, timesort);
        } else if (_index_color == 3) {
          for (var data in _financeInTopic!) {
            var datetimeInDB = "${data.date.toString().substring(0, 4)}";
            var datetimeMonth = "${DateTime.now().year}";
            if (datetimeInDB == datetimeMonth) {
              timesort.add(DateFormat("yyyy-MM-dd HH:mm:ss")
                  .parse(data.date.toString()));
              graph.add(data);
            }
          }
          DateTimeSort(graph, graphsort, timesort);
        }

        return SfCartesianChart(
          primaryXAxis: _index_color == 0
              ? const DateTimeAxis(
                  intervalType: DateTimeIntervalType.hours, interval: 0.8)
              : _index_color == 1
                  ? const DateTimeAxis(
                      intervalType: DateTimeIntervalType.days, interval: 0.5)
                  : _index_color == 2
                      ? const DateTimeAxis(
                          intervalType: DateTimeIntervalType.days,
                          interval: 0.2)
                      : const DateTimeAxis(
                          intervalType: DateTimeIntervalType.months,
                          interval: 0.2),
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
