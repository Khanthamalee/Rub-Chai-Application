import 'package:flutter/material.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: ([AppColors.bglevel1, AppColors.bglevel2]),
        ),
      ),
      width: double.infinity,
      height: Hscreen * H450,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: <SplineSeries<variablemoney, String>>[
          SplineSeries<variablemoney, String>(
            width: 3,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            color: AppColors.textblue,
            dataSource: <variablemoney>[
              variablemoney("Sun", 100),
              variablemoney("Mon", 20),
              variablemoney("Tue", 50),
              variablemoney("Wed", 10),
              variablemoney("Thu", 30),
              variablemoney("Fri", 90),
              variablemoney("Sat", 28)
            ],
            xValueMapper: (variablemoney sales, _) => sales.week,
            yValueMapper: (variablemoney sales, _) => sales.sales,
          )
        ],
      ),
    );
  }
}

class variablemoney {
  variablemoney(this.week, this.sales);
  final String week;
  final double sales;
}
