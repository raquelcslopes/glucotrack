import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_app/features/glucose/domain/entities/glucose_reading.dart';

class GlucoseWeeklyChart extends StatelessWidget {
  final List<GlucoseReading> readings;

  const GlucoseWeeklyChart({super.key, required this.readings});

  Color _getColorForValue(int value) {
    if (value > 140) {
      return Colors.red;
    } else if (value < 70) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Weekly History',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View all',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(
                    color: colorScheme.secondary,
                    fontSize: 12,
                  ),
                  axisLine: AxisLine(width: 0),
                  majorGridLines: const MajorGridLines(width: 0),
                  borderColor: Colors.transparent,
                ),
                primaryYAxis: NumericAxis(
                  labelStyle: TextStyle(
                    color: colorScheme.secondary,
                    fontSize: 12,
                  ),
                  axisLine: AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(width: 0),
                  minimum: 70,
                  maximum: 140,
                  interval: 20,
                  borderColor: Colors.transparent,
                ),
                series: <CartesianSeries>[
                  SplineSeries<GlucoseReading, String>(
                    dataSource: readings,
                    xValueMapper: (GlucoseReading reading, _) =>
                        _getWeekDay(reading.date),
                    yValueMapper: (GlucoseReading reading, _) => reading.value,
                    color: colorScheme.primary,
                    width: 3,
                    pointColorMapper: (GlucoseReading reading, _) =>
                        _getColorForValue(reading.value),
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      height: 10,
                      width: 10,
                      borderColor: Colors.white,
                      borderWidth: 2,
                    ),
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  color: Colors.white,
                  borderColor: colorScheme.secondary,
                  borderWidth: 2,
                  textStyle: TextStyle(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  builder:
                      (
                        dynamic data,
                        dynamic point,
                        dynamic series,
                        int pointIndex,
                        int seriesIndex,
                      ) {
                        final reading = readings[pointIndex];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Text(
                            '${_getWeekDay(reading.date)}: ${reading.value} mg/dL',
                          ),
                        );
                      },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegendItem(
                    color: Colors.red,
                    label: 'High (>140)',
                    context: context,
                  ),
                  _buildLegendItem(
                    color: Colors.green,
                    label: 'Normal (70-140)',
                    context: context,
                  ),
                  _buildLegendItem(
                    color: Colors.orange,
                    label: 'Low (<70)',
                    context: context,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  String _getWeekDay(DateTime date) {
    const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekDays[date.weekday % 7];
  }
}
