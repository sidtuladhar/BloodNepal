import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:blood_nepal/api.dart';
import 'package:hive/hive.dart';

class BloodPressure extends StatefulWidget {
  const BloodPressure({super.key});

  @override
  State<BloodPressure> createState() => _BloodPressureState();
}

class _BloodPressureState extends State<BloodPressure> {
  ApiService apiService = ApiService();
  final Box _boxLogin = Hive.box("login");

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('JAN\n2023', style: style);
        break;
      case 5:
        text = const Text('MAY\n2023', style: style);
        break;
      case 8:
        text = const Text('AUG\n2023', style: style);
        break;
      case 12:
        text = const Text('DEC\n2023', style: style);
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
    String phoneNumber = _boxLogin.get("phoneNumber");
    return FutureBuilder(
        future: apiService.getDonations(phoneNumber, "donations"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final jsonData = snapshot.data as List<dynamic>;
            List<FlSpot> upperSpots = [];
            List<FlSpot> lowerSpots = [];

            int maxYearInteger =
                int.parse(jsonData[0]["donationDate"].substring(0, 4));
            int minYearInteger = int.parse(
                jsonData[jsonData.length - 1]["donationDate"].substring(0, 4));

            for (var bloodPressure in jsonData) {
              String donationDate = bloodPressure["donationDate"];
              int year = int.parse(donationDate.substring(0, 4));
              int month = int.parse(donationDate.substring(5, 7));
              int yearMonthInteger = (year - minYearInteger) * 12 + month;
              int upperBP = bloodPressure["upperBP"];
              int lowerBP = bloodPressure["lowerBP"];

              upperSpots
                  .add(FlSpot(yearMonthInteger.toDouble(), upperBP.toDouble()));
              lowerSpots
                  .add(FlSpot(yearMonthInteger.toDouble(), lowerBP.toDouble()));
            }

            LineChartBarData upperLineChartBarData = LineChartBarData(
              //isCurved: true,
              color: Colors.blueAccent,
              barWidth: 6,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
              spots: upperSpots,
            );

            LineChartBarData lowerLineChartBarData = LineChartBarData(
              //isCurved: true,
              color: Colors.redAccent,
              barWidth: 6,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
              spots: lowerSpots,
            );
            List<LineChartBarData> lineChartBarDataList = [
              upperLineChartBarData,
              lowerLineChartBarData,
            ];

            Widget bottomTitleWidgets(double value, TitleMeta meta) {
              const style = TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );

              int oldestYear = minYearInteger;
              int year = oldestYear + value.toInt() ~/ 12;
              int month = value.toInt() % 12;
              String monthText = '';

              switch (month) {
                case 1:
                  monthText = 'JAN';
                  break;
                case 7:
                  monthText = 'JUL';
                  break;
              }

              String labelText = monthText != '' ? '$monthText\n$year' : "";

              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 10,
                child: Text(labelText, style: style),
              );
            }

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  right: 30,
                  left: 6,
                  bottom: 50,
                ),
                child: LineChart(LineChartData(
                  lineTouchData: LineTouchData(
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    ),
                  ),
                  minX: 0,
                  maxX: (maxYearInteger.toDouble() - minYearInteger) * 12 + 12,
                  minY: 50,
                  maxY: 135,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
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
            );
          } else {
            return const Text('No data available');
          }
        });
  }
}
