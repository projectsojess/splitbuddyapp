import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/user_to_member_data.dart';

class UserExpensesChart extends StatelessWidget {
  final List<UserToMemberData> memberData;
  const UserExpensesChart({super.key, required this.memberData});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        barGroups: List.generate(
          memberData.length,
          (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: memberData[index].amountOwedInGroup,
                color: Colors.red,
              ),
              BarChartRodData(
                toY: memberData[index].amountLentInGroup,
                color: Colors.green,
              ),
            ],
            showingTooltipIndicators: [0, 1],
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
          )),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
          )),
        ),
        borderData: FlBorderData(show: true),
        gridData: FlGridData(show: true),
      ),
    );
  }
}
