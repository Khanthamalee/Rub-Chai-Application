import 'package:flutter/material.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/database/financedata.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  List<Finance>? financeInTopic;
  int index_color;
  PieChart(
      {super.key, required this.financeInTopic, required this.index_color});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  late List<PiedataChart> dataPieChart;
  late TooltipBehavior _tooltip;
  List<Finance>? _financeInTopic;

  void sum() {}

  @override
  void initState() {
    dataPieChart = [];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
    _financeInTopic = widget.financeInTopic;
  }

  void DateTimeSort(
    List<variablemoney> Graph,
    List<variablemoney> Graphsort,
    List<DateTime> Timesort,
  ) {
    //Graph = [];
    Timesort.reversed;
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
    List<Finance> _financeInTopic = widget.financeInTopic!;
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
        double sumIncometochart = 0.0;
        double sumexpensestochart = 0.0;
        if (_index_color == 0) {
          dataPieChart = [];
          for (var data in _financeInTopic) {
            var datetimeInDB = "${data.date.toString().substring(0, 10)}";
            //"${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}-${data.datetime.day.toString().padLeft(2, "0")}";
            var datetimeDay =
                "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}-${DateTime.now().day.toString().padLeft(2, "0")}";
            if (datetimeInDB == datetimeDay) {
              DateTime time =
                  DateFormat("yyyy-MM-dd HH:mm:ss").parse(data.date.toString());
              timesort.add(time);
              if (data.income != "0") {
                sumIncometochart =
                    sumIncometochart + double.parse(data.income.toString());
              } else if (data.income == "0") {
                sumexpensestochart =
                    sumexpensestochart - double.parse(data.expense.toString());
              }
            }
          }

          dataPieChart = [
            PiedataChart('รายรับ', sumIncometochart),
            PiedataChart('รายจ่าย', sumexpensestochart)
          ];
        } else if (_index_color == 1) {
          dataPieChart = [];
          for (var data in _financeInTopic) {
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
                //print("day in var day in dayinweek: $day");
                DateTime time = DateFormat("yyyy-MM-dd HH:mm:ss")
                    .parse(data.date.toString());
                //print("time in var day in dayinweek: $time");
                timesort.add(time);
                //print("timesort in var day in dayinweek: $timesort");
                if (data.income != "0") {
                  sumIncometochart =
                      sumIncometochart + double.parse(data.income.toString());
                  //print("sumIncometochart in รายรับ : $sumIncometochart");
                } else if (data.income == "0") {
                  sumexpensestochart = sumexpensestochart -
                      double.parse(data.expense.toString());
                  //print("sumexpensestochart in รายจ่าย : $sumexpensestochart");
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
          //print("month");

          for (var data in _financeInTopic) {
            var datetimeInDB = "${data.date.toString().substring(0, 7)}";
            //"${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}";
            var datetimeMonth =
                "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}";
            // print(datetimeMonth);
            // print(datetimeInDB);
            if (datetimeInDB == datetimeMonth) {
              DateTime time =
                  DateFormat("yyyy-MM-dd HH:mm:ss").parse(data.date.toString());
              timesort.add(time);
              if (data.income != "0") {
                sumIncometochart =
                    sumIncometochart + double.parse(data.income.toString());
               // print("sumIncometochart in รายรับ : $sumIncometochart");
              } else if (data.income == "0") {
                sumexpensestochart =
                    sumexpensestochart - double.parse(data.expense.toString());
               // print("sumexpensestochart in รายจ่าย : $sumexpensestochart");
              }
            }
          }
          dataPieChart = [
            PiedataChart('รายรับ', sumIncometochart),
            PiedataChart('รายจ่าย', sumexpensestochart)
          ];
        } else if (_index_color == 3) {
          dataPieChart = [];
          for (var data in _financeInTopic) {
            var datetimeInDB = "${data.date.toString().substring(0, 4)}";
            var datetimeMonth = "${DateTime.now().year}";
            if (datetimeInDB == datetimeMonth) {
              DateTime time =
                  DateFormat("yyyy-MM-dd HH:mm:ss").parse(data.date.toString());
              timesort.add(time);
              if (data.income != "0") {
                sumIncometochart =
                    sumIncometochart + double.parse(data.income.toString());
               // print("sumIncometochart in รายรับ : $sumIncometochart");
              } else if (data.income == "0") {
                sumexpensestochart =
                    sumexpensestochart - double.parse(data.expense.toString());
               // print("sumexpensestochart in รายจ่าย : $sumexpensestochart");
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
