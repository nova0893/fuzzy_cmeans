import 'dart:math';

double squaredDistance(List<double> a, List<double> b) {
  double s = 0;
  for (var i = 0; i < a.length; i++) {
    final d = a[i] - b[i];
    s += d * d;
  }
  return s;
}

List<double> zeros(int n) => List<double>.filled(n, 0.0);
List<List<double>> zeros2(int r, int c) =>
    List.generate(r, (_) => List<double>.filled(c, 0.0));

int argmax(List<double> v) {
  var idx = 0;
  var best = v[0];
  for (var i = 1; i < v.length; i++) {
    if (v[i] > best) {
      best = v[i];
      idx = i;
    }
  }
  return idx;
}

double clampEps(double x, [double eps = 1e-12]) => x.abs() < eps ? eps : x;

Random makeRng(int? seed) => seed == null ? Random() : Random(seed);
