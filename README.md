# J'Donuts: Technical Overview

## Executive Summary

J'Donuts is a Flutter application built as a technical evaluation for Madivizion Code Test. It uses Clean Architecture and an offline-first data path. Home, product detail, and Rewards render from a local SQLite database through Drift, including their images, so the app still works in airplane mode.

The UI uses BLoC events and states, `get_it` for composition, `go_router` for navigation, and Flutter localization for English and Myanmar.

## 1. Technical Stack and Environment

| Area | Choice |
| --- | --- |
| Framework | Flutter 3.41.9 |
| Language | Dart 3.11.5 |
| SDK constraint | `sdk: ^3.11.5` |
| Local database | Drift on SQLite. The app does not run on Chrome. |
| State management | `flutter_bloc`, event and state, not Cubit |
| Dependency injection | `get_it` |
| Routing | `go_router` |
| Localization | `lib/l10n`, English and Myanmar |

### Commands

```bash
flutter pub get
flutter run

flutter analyze
flutter test

flutter test integration_test/register_home_product_test.dart -d <device>
```

`flutter pub get` and `flutter run` regenerate the localization files. Settings stores the chosen language on the device. Design screenshots and screen recordings belong to the client and are not in this repository. The files under `assets/` are the bundled catalog, rewards, navigation, and splash art.

## 2. Project Architecture and Directory Structure

Domain code is plain Dart and does not import Flutter. Repositories hide Drift. Widgets read repositories and do not paint a network response. Failures are a `Result` (`Success` or `Failure`).

```text
lib/
├── app/                  # Theme, motion, router, shell, locale, connectivity
├── core/                 # Result, typed failures, network-link watch
├── features/             # auth, welcome, home, catalog, product, rewards
└── l10n/                 # English and Myanmar strings

assets/
├── seed/                 # catalog.json, the seed document
├── catalog/              # Product, banner, shop, and member images
├── rewards/              # Challenge art and tier badges
└── nav/                  # Bottom-navigation icons

test/                     # Unit and widget tests
integration_test/         # Register, then Home, then a product
tool/                     # Optional mock server
.github/workflows/        # Analyze and test
```

`get_it` builds the graph in `lib/app/di/injector.dart`. `go_router` owns the routes. `/product/:id` sits outside the bottom-nav shell.

## 3. Core Architectural Strategies

### State management

Screen flows use BLoC events and states, not Cubits. A load or a tap is an event such as `HomeStarted` or `HomeRefreshed`. The BLoC emits loading, ready, or failure, and the widget only builds that state. The language setting uses a `ChangeNotifier` because it is not a screen flow.

### Offline-first data

The first launch copies `assets/seed/catalog.json` into Drift (`jdonuts.sqlite`). That document holds the member, tiers, banners, products, shops, and reward challenges. Seed photos are asset files, so a first launch with no network still shows them.

Home, product detail, and Rewards read Drift only. One member row is shared: Hania, Silver, 680,000 points, and 500 points left to become Gold. After sign-in, Home and Settings show the account name. The tier and the points stay on that shared row.

A slim bar says "You're offline" while the link is down. Rows already on screen stay. Pull-to-refresh, and a background refresh when the link returns, write the catalog source back into Drift, then the screen reads the database again. That source is the bundled JSON. A remote image, if one is added later, goes through a disk cache with a placeholder and an error picture.

### Motion and the design system

Durations and curves live in `lib/app/motion/app_motion.dart`. System Reduce Motion sets those durations to zero.

- Onboarding and Welcome enter on a shared controller. Registration draws a progress ring and shakes a wrong code.
- Home sweeps a skeleton for every section while Drift is reading, then staggers the sections in. The banner carousel advances every 4 seconds. Scrolling carries the header and the banner off the top. The notification bell stays floating.
- A product photo moves with a Hero into the detail page.
- Rewards sweeps the points ring from 0 to 680,000 with `CustomPainter`, brings Silver, Gold, and Platinum in order, and fills the line toward Gold. Challenge cards enter in a stagger. The donut colours in by quarters and the coffee arc fills to 9/12. The Rewards count pops in. The bottom-nav pill slides between Home and Reward.
- The blue Earn button presses in, bursts fireworks, and shows a congratulations card. A grey Earn button does not respond.
- Nearby and Wallet run a pastel sweep across "Coming Soon".

## 4. Authentication

The one-time code is **123456**.

An unknown number stays on sign-in and offers Register. A wrong code stays on sign-in. Three wrong codes lock the field until the code is resent, and that wait starts at 5:00. A new account needs a Myanmar mobile number, a name of letters and spaces (including Myanmar letters), and a real birth date for someone at least 13.

## 5. Development Tooling and CI

### Optional mock server

`tool/mock_server.dart` serves the public catalog. Airplane mode does not need it, and the app does not call it. From the repository root:

```bash
dart run tool/mock_server.dart
```

Wait until the terminal prints `Mock catalog on http://127.0.0.1:8080`. The process stays open while it listens. Stop it with Ctrl+C.

- `GET /v1/products`
- `GET /v1/banners`
- `GET /v1/shops`

Each body is `{ "data", "error", "meta" }`. `meta` carries `version: v1` and `count`. An unknown path returns HTTP 404, `data: null`, and an `error` object.

### Continuous integration

`.github/workflows/flutter.yml` runs `flutter analyze` and `flutter test` on every push and pull request, using Flutter 3.41.9. It does not run the device integration test. Pushing that workflow file requires a GitHub token with permission to update Actions workflows.

## 6. Known Gaps

- Nearby and Wallet are Coming Soon.
- Explore now and Order online are labels. They do not open a shop.
- Add to cart, and the blue Earn button, give feedback only. They do not change a cart or the points.
- The Gift tab is empty until a gift challenge is stored.
- Birth month names stay in English so the date parser can read them.
- Refresh still reads the bundled JSON. It does not fetch the mock server.

## 7. Time Spent

The commits run from 8 November 2026 through 9 November 2026.
