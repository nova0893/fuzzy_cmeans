import 'package:flutter/material.dart';
import 'package:fuzzy_cmeans/fuzzy_cmeans.dart';
import 'scatter_demo.dart';
import 'table_demo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FCM Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int c = 3;
  double m = 2.0;
  int maxIter = 100;
  double epsilon = 1e-4;
  late List<List<double>> data;
  FCMResult? res;

  @override
  void initState() {
    super.initState();
    data = _sampleData();
    _run();
  }

  List<List<double>> _sampleData() => [
        [1.0, 1.1],
        [0.9, 1.2],
        [1.2, 0.8],
        [5.0, 5.1],
        [4.9, 5.2],
        [5.2, 4.8],
        [9.0, 1.0],
        [9.2, 1.2],
        [8.8, 0.9],
      ];

  void _run() {
    final fcm = FuzzyCMeans(
      c: c,
      m: m,
      maxIter: maxIter,
      epsilon: epsilon,
      seed: 7,
    );
    setState(() => res = fcm.fit(data));
  }

  @override
  Widget build(BuildContext context) {
    final r = res;
    return Scaffold(
      appBar: AppBar(title: const Text('Fuzzy C-Means Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _intField(
                'Clusters',
                c,
                (v) => setState(() => c = v),
                min: 2,
                max: 10,
              ),
              _doubleField(
                'm (fuzziness)',
                m,
                (v) => setState(() => m = v),
                min: 1.1,
                max: 5,
              ),
              _intField(
                'Max Iterasi',
                maxIter,
                (v) => setState(() => maxIter = v),
                min: 10,
                max: 1000,
              ),
              _doubleField(
                'Epsilon',
                epsilon,
                (v) => setState(() => epsilon = v),
                min: 1e-8,
                max: 1e-1,
                step: 1e-5,
              ),
              FilledButton.icon(
                onPressed: _run,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Jalankan'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (r != null) ...[
            Text(
              'Centers: ${r.centers.map((e) => e.map((x) => x.toStringAsFixed(3)).toList()).toList()}',
            ),
            const SizedBox(height: 6),
            Text(
              'Iterasi: ${r.iterations}  | Objective: ${r.metrics.objective.toStringAsExponential(4)}',
            ),
            Text(
              'PC: ${r.metrics.partitionCoefficient.toStringAsFixed(4)}  '
              'PE: ${r.metrics.partitionEntropy.toStringAsFixed(4)}  '
              'XB: ${r.metrics.xieBeni.toStringAsFixed(4)}  '
              'Sil: ${r.metrics.silhouette?.toStringAsFixed(3) ?? "-"}',
            ),
            const SizedBox(height: 12),
            FCMDemoScatter(data: data, res: r),
            const SizedBox(height: 12),
            FCMTabel(data: data, res: r),
          ] else ...[
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }

  Widget _intField(
    String label,
    int value,
    void Function(int) onChanged, {
    int min = 0,
    int max = 100,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: $value'),
        const SizedBox(width: 8),
        SizedBox(
          width: 160,
          child: Slider(
            value: value.toDouble(),
            min: min.toDouble(),
            max: max.toDouble(),
            divisions: max - min,
            onChanged: (v) => onChanged(v.round()),
          ),
        ),
      ],
    );
  }

  Widget _doubleField(
    String label,
    double value,
    void Function(double) onChanged, {
    double min = 0,
    double max = 10,
    double step = 0.1,
  }) {
    final div = ((max - min) / step).round();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: ${value.toStringAsFixed(3)}'),
        const SizedBox(width: 8),
        SizedBox(
          width: 200,
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: div,
            onChanged: (v) => onChanged(v),
          ),
        ),
      ],
    );
  }
}
