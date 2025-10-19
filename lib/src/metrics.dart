import 'dart:math';
import 'math_utils.dart';

double partitionCoefficient(List<List<double>> U) {
  final n = U.length;
  double s = 0;
  for (var i = 0; i < n; i++) {
    for (var k = 0; k < U[i].length; k++) {
      s += U[i][k] * U[i][k];
    }
  }
  return s / n;
}

double partitionEntropy(List<List<double>> U, {double eps = 1e-12}) {
  final n = U.length, c = U.first.length;
  double s = 0;
  for (var i = 0; i < n; i++) {
    for (var k = 0; k < c; k++) {
      final u = clampEps(U[i][k], eps);
      s += u * log(u);
    }
  }
  return -s / n / log(c);
}

/// Xie–Beni Index (lebih kecil lebih baik)
double xieBeni({
  required List<List<double>> X,
  required List<List<double>> centers,
  required List<List<double>> U,
  required double m,
  double eps = 1e-12,
}) {
  double num = 0.0;
  for (var i = 0; i < X.length; i++) {
    for (var k = 0; k < centers.length; k++) {
      num += pow(U[i][k], m).toDouble() * squaredDistance(X[i], centers[k]);
    }
  }
  double minD2 = double.infinity;
  for (var a = 0; a < centers.length; a++) {
    for (var b = a + 1; b < centers.length; b++) {
      minD2 = min(minD2, squaredDistance(centers[a], centers[b]));
    }
  }
  minD2 = max(minD2, eps);
  return num / (X.length * minD2);
}

/// Silhouette score (pakai hard labels), O(N^2)
double silhouetteScore(List<List<double>> X, List<int> labels) {
  final n = X.length;
  final c = labels.toSet().length;

  final d = List.generate(n, (_) => List<double>.filled(n, 0));
  for (var i = 0; i < n; i++) {
    for (var j = i + 1; j < n; j++) {
      final dd = sqrt(squaredDistance(X[i], X[j]));
      d[i][j] = dd;
      d[j][i] = dd;
    }
  }

  double mean(List<double> v) =>
      v.isEmpty ? 0 : v.reduce((a, b) => a + b) / v.length;

  double sSum = 0.0;
  for (var i = 0; i < n; i++) {
    final li = labels[i];
    final a = mean([
      for (var j = 0; j < n; j++)
        if (j != i && labels[j] == li) d[i][j],
    ]);
    double b = double.infinity;
    for (var k = 0; k < c; k++) {
      if (k == li) continue;
      final m = [
        for (var j = 0; j < n; j++)
          if (labels[j] == k) d[i][j],
      ];
      if (m.isNotEmpty) b = min(b, mean(m));
    }
    final s =
        (b - a) /
        (b > a
            ? b
            : a == 0
            ? 1.0
            : a);
    sSum += s;
  }
  return sSum / n;
}
