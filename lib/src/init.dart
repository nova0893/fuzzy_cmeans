import 'dart:math';
import 'math_utils.dart';

List<List<double>> initMembershipRandom({
  required int n,
  required int c,
  required Random rng,
}) {
  final U = List.generate(n, (_) {
    final row = List<double>.generate(c, (_) => rng.nextDouble());
    final s = row.reduce((a, b) => a + b);
    return row.map((x) => x / s).toList();
  });
  return U;
}

List<List<double>> initCentersKMeansPP({
  required List<List<double>> X,
  required int c,
  required Random rng,
}) {
  final n = X.length;
  final centers = <List<double>>[];

  centers.add(List<double>.from(X[rng.nextInt(n)]));

  while (centers.length < c) {
    final d2 = List<double>.filled(n, 0.0);
    double sum = 0;
    for (var i = 0; i < n; i++) {
      double best = double.infinity;
      for (final c0 in centers) {
        best = min(best, squaredDistance(X[i], c0));
      }
      d2[i] = best;
      sum += best;
    }
    double r = rng.nextDouble() * sum;
    for (var i = 0; i < n; i++) {
      r -= d2[i];
      if (r <= 0) {
        centers.add(List<double>.from(X[i]));
        break;
      }
    }
  }

  return centers;
}
