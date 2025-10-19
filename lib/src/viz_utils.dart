import 'package:flutter/material.dart';

/// Palet warna untuk jumlah cluster c
List<Color> clusterColors(int c, {Color? seedColor}) {
  final List<Color> out = [];
  final baseHue = seedColor == null ? 0.0 : HSVColor.fromColor(seedColor).hue;
  final step = 360.0 / c;
  for (var i = 0; i < c; i++) {
    final hue = (baseHue + i * step) % 360.0;
    out.add(HSVColor.fromAHSV(1, hue, 0.65, 0.95).toColor());
  }
  return out;
}

/// Konversi membership ke opacity
double membershipAlpha(double u, {double minA = 0.25, double maxA = 1.0}) {
  final clamped = u.clamp(0.0, 1.0);
  return minA + (maxA - minA) * clamped;
}
