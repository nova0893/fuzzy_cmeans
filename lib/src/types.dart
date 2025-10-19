class FCMMetrics {
  final double objective; // nilai objektif terakhir
  final double partitionCoefficient; // PC
  final double partitionEntropy; // PE (dinormalisasi 0..1)
  final double xieBeni; // XB (lebih kecil lebih baik)
  final double? silhouette; // opsional (hard label)

  const FCMMetrics({
    required this.objective,
    required this.partitionCoefficient,
    required this.partitionEntropy,
    required this.xieBeni,
    this.silhouette,
  });
}

class FCMResult {
  final List<List<double>> centers; // c x dim
  final List<List<double>> membership; // N x c
  final int iterations;
  final List<double> objectiveHistory; // nilai objektif per iterasi
  final FCMMetrics metrics;

  const FCMResult({
    required this.centers,
    required this.membership,
    required this.iterations,
    required this.objectiveHistory,
    required this.metrics,
  });

  List<int> get hardLabels => membership
      .map((row) => row.indexOf(row.reduce((a, b) => a > b ? a : b)))
      .toList();
}

enum InitMethod { random, kmeanspp }
