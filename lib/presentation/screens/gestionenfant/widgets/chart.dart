import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:toleka/theme.dart';


class ChartCircular extends StatefulWidget {
  @override
  State<ChartCircular> createState() => _ChartCircularState();
}

class _ChartCircularState extends State<ChartCircular> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 0,
        sections: [
          PieChartSectionData(
            color: kelasiColorIcon,
            value: 25,
            title: '',
            radius: 40,
            titleStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kelasiColorIcon,
            ),
          ),
          PieChartSectionData(
            color: kelasiColor,
            value: 50,
            title: '',
            radius: 40,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          ),
          PieChartSectionData(
            color: const Color.fromARGB(255, 13, 99, 170),
            value: 25,
            title: '',
            radius: 40,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
          ),
        ],
      ),
    );
  }
}
