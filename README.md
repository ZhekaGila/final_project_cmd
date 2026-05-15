# Flutter Marketplace - Final Project

A cross-platform e-commerce marketplace app built with Flutter, demonstrating Clean Architecture, Riverpod state management, local and cloud persistence, and complex UI layouts.

---

## Features

- **Product Catalog** — Browse products fetched from a real REST API, displayed in a responsive 2-column GridView with pull-to-refresh
- **Product Details** — Full product detail screen with image, description, category, price, and add to cart / favorite actions
- **Cart** — Add and remove products, view total, and place orders (saved to Firestore)
- **Favorites** — Persist liked products locally using Drift (SQLite)
- **Order History** — Real time order feed from Firestore with detailed order view
- **Settings** — Light/Dark theme toggle persisted via Shared Preferences

---

## Architecture

```
lib/
├── core/
│   ├── router/         # go_router navigation
│   └── theme/          # Light & dark MaterialTheme definitions
├── data/
│   ├── models/         # JSON-serializable Dart models (json_annotation)
│   ├── repositories/   # Data access layer
│   └── services/
│       ├── api/        # Chopper HTTP client (FakeStore API)
│       ├── firebase/   # Firestore 
│       └── local/      # Drift SQLite database (favorites)
└── ui/
    ├── providers/      # Riverpod state providers
    ├── screens/        # Feature screens (home, cart, favorites, orders, settings)
    └── widgets/        # Reusable UI components
```

---

## Tech Stack

| Layer | Technology |
|---|---|
| UI Framework | Flutter |
| State Management | Riverpod (`flutter_riverpod ^2.5.1`) |
| Navigation | go_router (`^14.2.0`) |
| Networking | Chopper (`^8.0.0`) + JSON serialization |
| Local DB | Drift / SQLite (`^2.18.0`) |
| Lightweight Storage | Shared Preferences (`^2.2.3`) |
| Cloud / Backend | Firebase Firestore (`cloud_firestore ^5.2.1`) |
| Code Generation | build_runner, json_serializable, chopper_generator, drift_dev |

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.11.4`
- Dart SDK `^3.11.4`
- Firebase project with Firestore enabled
- `flutterfire_cli` (for Firebase configuration)

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/ZhekaGila/final_project_cmd.git
   cd final_project_cmd
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   The project already includes a generated `lib/firebase_options.dart`. If you are setting up a new Firebase project:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

4. **Run code generation** (required after clean or first clone)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

---

## Key Implementation Details

### Networking - Chopper
Products are fetched from  FakeStore API: https://fakestoreapi.com using a Chopper:

```dart
// lib/data/services/api/product_service.dart
@ChopperApi()
abstract class ProductService extends ChopperService {
  @GET(path: '/products')
  Future<Response> getProducts();
}
```

### Local Persistence — Drift
Favorite products are stored in a local SQLite database managed by Drift:

```dart
// lib/data/services/local/app_database.dart
@DriftDatabase(tables: [Favorites])
class AppDatabase extends _$AppDatabase { ... }
```

### Cloud Persistence — Firestore
Orders are saved and streamed from Firebase Firestore:

```dart
// lib/data/services/firebase/firestore_service.dart
await _firestore.collection('orders').add({ ... });
Stream<QuerySnapshot> getOrders() => _firestore.collection('orders').snapshots();
```

### State Management — Riverpod
All state (products, cart, favorites, theme) is managed through Riverpod providers:

```dart
// Theme persisted via SharedPreferences
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(...);
```

### Navigation — go_router
Declarative navigation with typed route parameters:

```dart
GoRoute(
  path: '/product',
  builder: (context, state) {
    final product = state.extra as ProductModel;
    return ProductDetailsScreen(product: product);
  },
),
```

---

## Screens & Routes

| Route | Screen | Description |
|---|---|---|
| `/` | HomeScreen | Product grid with pull-to-refresh |
| `/product` | ProductDetailsScreen | Single product detail |
| `/cart` | CartScreen | Cart items and checkout |
| `/favorites` | FavoritesScreen | Locally saved favorites (Drift) |
| `/orders` | OrdersScreen | Live order history (Firestore) |
| `/settings` | SettingsScreen |  Dark/light theme toggle |

---

## Author

Zhandos Gilazhev