import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_cmeans/fuzzy_cmeans.dart';

class FCMDemoScatter extends StatelessWidget {
  final List<List<double>> data;
  final FCMResult res;

  const FCMDemoScatter({super.key, required this.data, required this.res});

  @override
  Widget build(BuildContext context) {
    final colors = clusterColors(res.centers.length);
    final labels = res.hardLabels;

    final spots = <ScatterSpot>[];
    for (var i = 0; i < data.length; i++) {
      final x = data[i][0], y = data[i][1];
      final k = labels[i];
      final u = res.membership[i][k];
      spots.add(
        ScatterSpot(
          x,
          y,
          dotPainter: FlDotCirclePainter(
            radius: 6,
            color: colors[k].withOpacity(membershipAlpha(u)),
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.2,
      child: ScatterChart(
        ScatterChartData(
          scatterSpots: spots,
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: true),
          titlesData: const FlTitlesData(show: true),
        ),
      ),
    );
  }
}
