import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/themes/pallete.dart';

class UserExpensesChart extends StatelessWidget {
  final GroupData groupData;
  const UserExpensesChart({super.key, required this.groupData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Group Share - Chart',
          style: TextStyle(
            color: Pallete.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipMargin: 0,
                  tooltipPadding: EdgeInsets.all(0),
                  tooltipHorizontalOffset: 5,
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, metadata) {
                      if (value == 0) {
                        return Text('You');
                      } else {
                        return Text(groupData
                            .memberData[(value - 1).toInt()].memberName);
                      }
                    },
                  ),
                ),
              ),
              barGroups: [
                BarChartGroupData(
                  showingTooltipIndicators: [0, 2],
                  x: 0,
                  barsSpace: 2,
                  barRods: [
                    BarChartRodData(
                      toY: groupData.amountLent,
                      color: Colors.green,
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                    BarChartRodData(
                      toY: 0,
                      color: Colors.transparent,
                      width: 10,
                    ),
                    BarChartRodData(
                      toY: groupData.amountBorrowed,
                      color: Colors.red,
                      width: 20,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                ),
                for (int i = 0; i < groupData.memberData.length; i++)
                  BarChartGroupData(
                    x: i + 1,
                    barsSpace: 2,
                    showingTooltipIndicators: [0, 2],
                    barRods: [
                      BarChartRodData(
                        toY: groupData.memberData[i].amountLentInGroup,
                        color: Colors.green,
                        width: 20,
                        borderRadius: BorderRadius.zero,
                      ),
                      BarChartRodData(
                        toY: 0,
                        color: Colors.transparent,
                        width: 10,
                      ),
                      BarChartRodData(
                        toY: groupData.memberData[i].amountOwedInGroup,
                        color: Colors.red,
                        width: 20,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
