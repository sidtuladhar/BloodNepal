import 'package:flutter/material.dart';
import 'package:blood_nepal/ui/home/home.dart';
import 'package:fl_chart/fl_chart.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<LineChartBarData> lineChartBarDataList = [
    LineChartBarData(
      isCurved: true,
      color: Colors.blueAccent,
      barWidth: 6,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: const [
        FlSpot(1, 70),
        FlSpot(3, 71),
        FlSpot(5, 75),
        FlSpot(7, 63),
        FlSpot(10, 60),
        FlSpot(12, 80),
        FlSpot(13, 72),
      ],
    ),
    LineChartBarData(
      isCurved: true,
      color: Colors.greenAccent,
      barWidth: 6,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: const [
        FlSpot(1, 110),
        FlSpot(3, 100),
        FlSpot(5, 98),
        FlSpot(7, 93),
        FlSpot(10, 105),
        FlSpot(12, 120),
        FlSpot(13, 129),
      ],
    )
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('JAN', style: style);
        break;
      case 4:
        text = const Text('APR', style: style);
        break;
      case 7:
        text = const Text('JUL', style: style);
        break;
      case 10:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    String text;
    switch (value.toInt()) {
      case 50:
        text = '50';
        break;
      case 60:
        text = '60';
        break;
      case 70:
        text = '70';
        break;
      case 80:
        text = '80';
        break;
      case 90:
        text = '90';
        break;
      case 100:
        text = '100';
        break;
      case 110:
        text = '110';
        break;
      case 120:
        text = '120';
        break;
      case 130:
        text = '130';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Home();
                },
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30),
        ),
        toolbarHeight: 85,
        title: const Text("Donation History",
            style: TextStyle(
                fontSize: 28,
                letterSpacing: 1.2,
                height: 1.2,
                fontFamily: "Rubik"),
            textAlign: TextAlign.left),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 80,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 30, left: 6),
              child: LineChart(LineChartData(
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                  ),
                ),
                minX: 0,
                maxX: 13,
                minY: 45,
                maxY: 135,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      getTitlesWidget: leftTitleWidgets,
                      showTitles: true,
                      interval: 1,
                      reservedSize: 50,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    bottom: BorderSide(color: Colors.pinkAccent, width: 4),
                    left: BorderSide(color: Colors.transparent),
                    right: BorderSide(color: Colors.transparent),
                    top: BorderSide(color: Colors.transparent),
                  ),
                ),
                gridData: const FlGridData(show: false),
                lineBarsData: lineChartBarDataList,
              )),
            ),
          ),
          const SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}
