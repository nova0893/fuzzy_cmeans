# 🧠 fuzzy_cmeans  
*A Dart/Flutter library for Fuzzy C-Means clustering with visualization support.*

[![Pub Package](https://img.shields.io/pub/v/fuzzy_cmeans)](https://pub.dev/packages/fuzzy_cmeans)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/nova0893/fuzzy_cmeans/blob/Main/LICENSE.md)
[![Build](https://github.com/nova0893/fuzzy_cmeans/actions/workflows/ci.yml/badge.svg)](https://github.com/nova0893/fuzzy_cmeans/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/nova0893/fuzzy_cmeans/branch/main/graph/badge.svg)](https://codecov.io/gh/nova0893/fuzzy_cmeans)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.17388944.svg)](https://doi.org/10.5281/zenodo.17388944)

---

## 📘 Overview
`fuzzy_cmeans` is a **pure Dart implementation** of the Fuzzy C-Means (FCM) clustering algorithm,  
with optional **Flutter visualization widgets** for interactive analysis.

This library enables mobile, web, and desktop applications to perform **soft clustering** directly on-device —  
ideal for teaching, prototyping, and embedded analytics.

---

## 🚀 Features
- ✅ FCM algorithm with **k-means++** and random initialization  
- ✅ Configurable parameters:
  - `c` (number of clusters)
  - `m` (fuzziness)
  - `maxIter`, `epsilon`, `seed`, `init`
- ✅ Built-in validity metrics:
  - Partition Coefficient (PC)
  - Partition Entropy (PE)
  - Xie–Beni Index (XB)
  - Silhouette Score
- ✅ Modular architecture:
  - `math_utils.dart`, `init.dart`, `metrics.dart`, `viz_utils.dart`
- ✅ Flutter visualization:
  - `FCMDemoScatter` – scatter chart (fl_chart)
  - `FCMTabel` – membership matrix table
- ✅ Fully open-source (MIT License)

---

## 📦 Installation
Add dependency to your `pubspec.yaml`:

```yaml
dependencies:
  fuzzy_cmeans: ^0.1.0
```

or install directly:

```bash
dart pub add fuzzy_cmeans
```

Then import:

```dart
import 'package:fuzzy_cmeans/fuzzy_cmeans.dart';
```

---

## 🧩 Example (Dart)
```dart
import 'package:fuzzy_cmeans/fuzzy_cmeans.dart';

void main() {
  final data = [
    [1.0, 1.1],
    [0.9, 1.2],
    [5.0, 5.1],
    [5.2, 4.8],
    [9.0, 1.0],
  ];

  final fcm = FuzzyCMeans(c: 3, seed: 7);
  final result = fcm.fit(data);

  print('Centers: ${result.centers}');
  print('Iterations: ${result.iterations}');
  print('Objective: ${result.metrics.objective}');
}
```

---

## 🧠 Example (Flutter Demo)

A live demo is included under `example/flutter_demo/`.

Run it using:

```bash
flutter run example/flutter_demo
```

### Key files
- `main.dart` – entry point  
- `scatter_demo.dart` – cluster visualization using **fl_chart**  
- `table_demo.dart` – DataTable of membership values

### Output
- Interactive clustering with sliders for parameters  
- Real-time updates on scatter plot & table  
- Metrics displayed (PC, PE, XB, Silhouette)

---

## 📊 Project Structure
```
lib/
 ├── fuzzy_cmeans.dart        # public API
 └── src/
     ├── fcm.dart             # core FCM algorithm
     ├── init.dart            # initialization
     ├── metrics.dart         # validity metrics
     ├── math_utils.dart      # matrix helpers
     ├── types.dart           # FCMResult, FCMMetrics
     └── viz_utils.dart       # colors & alpha utilities
example/
 ├── main.dart                # Flutter app entry
 ├── scatter_demo.dart
 └── table_demo.dart
```

---

## 📈 Metrics Reference
| Metric | Meaning | Ideal Value |
|:-------|:---------|:-------------|
| **PC** | Partition Coefficient | → 1 (higher = better) |
| **PE** | Partition Entropy | → 0 (lower = better) |
| **XB** | Xie–Beni Index | → 0 (lower = better) |
| **Sil** | Silhouette | → 1 (higher = better) |

---

## 📗 Citation
If you use this software in your research, please cite it as:

```bibtex
@software{fuzzy_cmeans_2025,
  author       = {Nova Agustina},
  title        = {fuzzy_cmeans: A Dart/Flutter library for Fuzzy C-Means clustering and visualization},
  year         = {2025},
  publisher    = {Zenodo},
  doi          = {10.5281/zenodo.17388944},
  url          = {https://github.com/nova0893/fuzzy_cmeans}
}
```

---

## 🧾 License
This project is licensed under the [MIT License](LICENSE).  
© 2025 Nova Agustina — Universitas Teknologi Bandung.

---

## 💡 Next Milestones
- [ ] Adaptive fuzziness `m` (dynamic adjustment)
- [ ] GPU/FFI optimization
- [ ] Flutter Web live visualization
- [ ] Integration with Firebase for data storage
- [ ] Publish on pub.dev 🎯

---

## 🧩 Maintainer
**Nova Agustina**  
📧 nova@utb-univ.ac.id  
🌐 [GitHub: nova0893](https://github.com/nova0893)

----

> _Developed as part of a research initiative on mobile machine learning and interactive visualization._
