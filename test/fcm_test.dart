import 'package:flutter_test/flutter_test.dart';
import 'package:fuzzy_cmeans/fuzzy_cmeans.dart';

void main() {
  test('FCM converges & memberships sum to 1', () {
    final data = [
      [0.0, 0.0],
      [0.2, 0.1],
      [5.0, 5.0],
      [5.2, 5.1],
    ];

    final fcm = FuzzyCMeans(c: 2, seed: 1);
    final res = fcm.fit(data);

    for (final row in res.membership) {
      final s = row.reduce((a, b) => a + b);
      expect((s - 1.0).abs() < 1e-6, true);
    }

    expect(res.iterations > 0, true);
    expect(res.centers.length, 2);
    expect(res.metrics.partitionCoefficient > 0, true);
  });
}
