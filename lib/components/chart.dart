import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:trashure_new/code/max.dart';
import 'package:trashure_new/models/weekly.dart';

class Chart extends StatelessWidget {
  Chart(this.data);

  final Weekly data;

  @override
  Widget build(BuildContext context) {
    int max = 10;
    if (data != null) {
      max = findMax(data);
    }
    return Expanded(
        child: BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (max + (max / 2)).toDouble(),
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: const EdgeInsets.all(0),
            tooltipBottomMargin: 8,
            getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
            ) {
              return BarTooltipItem(
                (rod.y.round() != 0) ? rod.y.round().toString() : "",
                TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                color: Color(0xff7589a2),
                fontWeight: FontWeight.bold,
                fontSize: 14),
            margin: 20,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'Week 1';
                case 1:
                  return 'Week 2';
                case 2:
                  return 'Week 3';
                case 3:
                default:
                  return 'Week 4';
              }
            },
          ),
          leftTitles: SideTitles(
              showTitles: true,
              interval: max / 2.toInt(),
              getTitles: (v) {
                return "${v.toInt()} kg";
              }),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                  y: (data != null) ? data.satu.toDouble() : 0,
                  colors: [
                    Color(0xFFFF5722),
                  ])
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                  y: (data != null) ? data.dua.toDouble() : 0,
                  colors: [
                    Color(0xFFFF5722),
                  ])
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                  y: (data != null) ? data.tiga.toDouble() : 0,
                  colors: [
                    Color(0xFFFF5722),
                  ])
            ],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                  y: (data != null) ? data.empat.toDouble() : 0,
                  colors: [
                    Color(0xFFFF5722),
                  ])
            ],
            showingTooltipIndicators: [0],
          ),
        ],
      ),
    ));
  }
}
