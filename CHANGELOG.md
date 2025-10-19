# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]
### Planned
- Support for adaptive fuzziness parameter `m` based on cluster variance.
- GPU/FFI acceleration for large datasets.
- Web demo using Flutter Web.
- Extended documentation on pub.dev with example gallery.

---

## [0.1.0] - 2025-10-19
### Added
- Initial release of **`fuzzy_cmeans`**, a Dart/Flutter library for Fuzzy C-Means clustering.
- Implemented core algorithm class `FuzzyCMeans` with configurable parameters:
  - `c`, `m`, `maxIter`, `epsilon`, `seed`, `init (random/kmeanspp)`.
- Modular design with supporting modules:
  - `math_utils.dart` → numeric helpers (`zeros`, `clampEps`, `squaredDistance`).
  - `init.dart` → initialization strategies (random & k-means++).
  - `metrics.dart` → clustering validity metrics (PC, PE, XB, Silhouette).
  - `viz_utils.dart` → Flutter visual helpers (`clusterColors`, `membershipAlpha`).
- Output classes:
  - `FCMResult` (centers, membership, metrics, iterations).
  - `FCMMetrics` (objective, PC, PE, XB, Silhouette).
- Added **example Flutter demo** (`example/`) with:
  - Interactive parameter sliders for `c`, `m`, `maxIter`, `epsilon`.
  - Real-time clustering scatter visualization (via `fl_chart`).
  - Membership matrix table (`FCMTabel`) for inspection.

### Improved
- Stable numerical updates for membership and centers (ε-clamped distances).
- Early stopping based on objective function convergence threshold.
- Clear API naming and strong typing for all results.

### Documentation
- Added `README.md` with setup guide and usage example.
- Added `LICENSE` (MIT) and `CITATION.cff` template for academic citation.
- Added UML diagrams for architecture overview.
- Published initial version on **pub.dev** (planned).

---

## [0.0.1] - 2025-09-30 (Internal Prototype)
### Added
- Basic proof-of-concept implementation of FCM in Dart.
- Manual test harness for sample data.
