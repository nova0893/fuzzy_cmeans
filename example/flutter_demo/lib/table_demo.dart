import 'package:flutter/material.dart';
import 'package:fuzzy_cmeans/fuzzy_cmeans.dart';

class FCMTabel extends StatelessWidget {
  final List<List<double>> data;
  final FCMResult res;

  const FCMTabel({super.key, required this.data, required this.res});

  @override
  Widget build(BuildContext context) {
    final cols = <DataColumn>[
      const DataColumn(label: Text('#')),
      const DataColumn(label: Text('X1')),
      const DataColumn(label: Text('X2')),
      for (var k = 0; k < res.centers.length; k++)
        DataColumn(label: Text('u_$k')),
      const DataColumn(label: Text('Label')),
    ];

    final rows = List.generate(data.length, (i) {
      return DataRow(
        cells: [
          DataCell(Text('${i + 1}')),
          DataCell(Text(data[i][0].toStringAsFixed(3))),
          DataCell(Text(data[i][1].toStringAsFixed(3))),
          for (var k = 0; k < res.centers.length; k++)
            DataCell(Text(res.membership[i][k].toStringAsFixed(3))),
          DataCell(Text('${res.hardLabels[i]}')),
        ],
      );
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(columns: cols, rows: rows),
    );
  }
}
