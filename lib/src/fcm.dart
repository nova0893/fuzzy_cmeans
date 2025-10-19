import 'math_utils.dart';
import 'init.dart';
import 'types.dart';
import 'metrics.dart';
import 'dart:math';

class FuzzyCMeans {
  final int c;
  final double m;
  final int maxIter;
  final double epsilon;
  final int? seed;
  final InitMethod init;

  FuzzyCMeans({
    required this.c,
    this.m = 2.0,
    this.maxIter = 300,
    this.epsilon = 1e-4,
    this.seed,
    this.init = InitMethod.kmeanspp,
  }) : assert(c >= 2),
       assert(m > 1.0),
       assert(maxIter > 0),
       assert(epsilon > 0);

  FCMResult fit(List<List<double>> X) {
    final n = X.length;
    if (n == 0) {
      throw ArgumentError('X is empty');
    }
    final rng = makeRng(seed);

    List<List<double>> U;
    List<List<double>> centers;

    if (init == InitMethod.random) {
      U = initMembershipRandom(n: n, c: c, rng: rng);
      centers = _updateCenters(X, U);
    } else {
      centers = initCentersKMeansPP(X: X, c: c, rng: rng);
      U = _updateMembership(X, centers);
    }

    final objHist = <double>[];
    double J = _objective(X, U, centers);
    objHist.add(J);
    int it = 0;

    while (it < maxIter) {
      it++;
      final centersNew = _updateCenters(X, U);
      final Unew = _updateMembership(X, centersNew);
      final Jnew = _objective(X, Unew, centersNew);
      objHist.add(Jnew);

      if ((J - Jnew).abs() < epsilon) {
        final labels = _hardLabels(Unew);
        final metrics = FCMMetrics(
          objective: Jnew,
          partitionCoefficient: partitionCoefficient(Unew),
          partitionEntropy: partitionEntropy(Unew),
          xieBeni: xieBeni(X: X, centers: centersNew, U: Unew, m: m),
          silhouette: labels == null ? null : silhouetteScore(X, labels),
        );
        return FCMResult(
          centers: centersNew,
          membership: Unew,
          iterations: it,
          objectiveHistory: objHist,
          metrics: metrics,
        );
      }

      centers = centersNew;
      U = Unew;
      J = Jnew;
    }

    final labels = _hardLabels(U);
    final metrics = FCMMetrics(
      objective: J,
      partitionCoefficient: partitionCoefficient(U),
      partitionEntropy: partitionEntropy(U),
      xieBeni: xieBeni(X: X, centers: centers, U: U, m: m),
      silhouette: labels == null ? null : silhouetteScore(X, labels),
    );

    return FCMResult(
      centers: centers,
      membership: U,
      iterations: it,
      objectiveHistory: objHist,
      metrics: metrics,
    );
  }

  List<int>? _hardLabels(List<List<double>> U) {
    if (U.isEmpty) return null;
    return U
        .map((row) => row.indexOf(row.reduce((a, b) => a > b ? a : b)))
        .toList();
  }

  List<List<double>> _updateCenters(
    List<List<double>> X,
    List<List<double>> U,
  ) {
    final n = X.length;
    final dim = X.first.length;
    final centers = zeros2(c, dim);
    final um = List<double>.filled(c, 0.0);

    for (var k = 0; k < c; k++) {
      for (var i = 0; i < n; i++) {
        final uk = pow(U[i][k], m).toDouble();
        um[k] += uk;
        for (var d = 0; d < dim; d++) {
          centers[k][d] += uk * X[i][d];
        }
      }
      final denom = clampEps(um[k]);
      for (var d = 0; d < dim; d++) {
        centers[k][d] /= denom;
      }
    }
    return centers;
  }

  List<List<double>> _updateMembership(
    List<List<double>> X,
    List<List<double>> centers,
  ) {
    final n = X.length;
    final U = zeros2(n, c);
    final exponent = 2.0 / (m - 1.0);

    for (var i = 0; i < n; i++) {
      final dist = List<double>.generate(
        c,
        (k) => clampEps(squaredDistance(X[i], centers[k])),
      );
      final zeroAt = dist.indexWhere((d) => d <= 1e-18);
      if (zeroAt != -1) {
        for (var k = 0; k < c; k++) {
          U[i][k] = (k == zeroAt) ? 1.0 : 0.0;
        }
        continue;
      }
      for (var k = 0; k < c; k++) {
        double denomSum = 0.0;
        for (var j = 0; j < c; j++) {
          denomSum += pow(dist[k] / dist[j], exponent).toDouble();
        }
        U[i][k] = 1.0 / denomSum;
      }
    }
    return U;
  }

  double _objective(
    List<List<double>> X,
    List<List<double>> U,
    List<List<double>> centers,
  ) {
    double J = 0.0;
    for (var i = 0; i < X.length; i++) {
      for (var k = 0; k < c; k++) {
        J += pow(U[i][k], m).toDouble() * squaredDistance(X[i], centers[k]);
      }
    }
    return J;
  }
}
