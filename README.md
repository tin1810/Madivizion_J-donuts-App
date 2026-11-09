# J'Donuts

Flutter app for the Madivizion code test. Sign-in is faked. Home, product detail, and Rewards paint from a local database, images included, so the app still works in airplane mode.

## How to run

Flutter **3.41.9**, Dart **3.11.5**. The package constraint in `pubspec.yaml` is `sdk: ^3.11.5`.

```bash
flutter pub get
flutter run
```

Run on an Android or iOS device or simulator. Drift uses the SQLite engine, so the app does not run on Chrome.

```bash
flutter analyze
flutter test
```

The register-to-product flow needs a device:

```bash
flutter test integration_test/register_home_product_test.dart -d <device>
```

English and Myanmar strings live in `lib/l10n`. Flutter regenerates them on `flutter pub get` and `flutter run`. Settings stores the chosen language on the device.

Design screenshots and screen recordings belong to the client. They are not part of this repository. The images under `assets/` are the bundled catalog, rewards, navigation, and splash art.

## Architecture and folders

Clean Architecture. Each feature is split into `domain`, `data`, and `presentation`. Domain code is plain Dart and does not import Flutter. A repository hides Drift. Widgets read that repository and never paint a network response.

`get_it` builds the graph in `lib/app/di/injector.dart`. `go_router` owns the routes, including `/product/:id` outside the bottom-nav shell. Failures are a `Result` (`Success` or `Failure`), not a swallowed exception.

```text
lib/app            theme, motion, router, shell, locale, connectivity
lib/core           Result, failures, link watch
lib/features       auth, welcome, home, catalog, product, rewards
lib/l10n           English and Myanmar
assets/seed        catalog.json, the seed document
assets/catalog     product, banner, shop, and member images
assets/rewards     challenge art and tier badges
assets/nav         bottom-nav icons
test               widget and unit tests
integration_test   register, Home, then a product
tool               optional mock server
.github/workflows  analyze and test
```

## State management

BLoC events and states, not Cubit. A load or a tap is an event, such as `HomeStarted` or `HomeRefreshed`. The BLoC emits loading, ready, or failure. The widget only builds that state, so the same path can be tested without driving the whole app. The language choice is a `ChangeNotifier` because it is a setting, not a screen flow.

## Offline strategy

The first launch copies `assets/seed/catalog.json` into Drift (`jdonuts.sqlite`). That document holds the member, tiers, banners, products, shops, and reward challenges. Seed photos are asset files, so a first launch with no network still shows them.

Home, product detail, and Rewards read Drift only. One member row is shared: Hania, Silver, 680,000 points, and 500 points left to become Gold. After sign-in, Home and Settings show the account name. The tier and the points stay on the shared row.

A slim bar says "You're offline" while the link is down. Rows already on screen stay. Pull-to-refresh, and a background refresh when the link returns, write the catalog source back into Drift, then the screen reads the database again. That source is the bundled JSON. A remote image, if one is added later, goes through a disk cache with a placeholder and an error picture.

## Animations

Durations and curves are in `lib/app/motion/app_motion.dart`. System Reduce Motion sets those durations to zero.

- Onboarding and Welcome enter on a shared controller.
- Registration draws a progress ring and shakes a wrong code.
- Home sweeps a skeleton while Drift is reading, then staggers the sections in. The banner carousel advances every 4 seconds. Scrolling carries the header and the banner off the top. The notification bell stays floating.
- A product photo moves with a Hero into the detail page.
- Rewards sweeps the points ring from 0 to 680,000, brings Silver, Gold, and Platinum in order, and fills the line toward Gold. Challenge cards enter in a stagger. The donut colours in by quarters and the coffee arc fills to 9/12. The Rewards count pops in. The bottom-nav pill slides between Home and Reward.
- The blue Earn button presses in, bursts fireworks, and shows a congratulations card. A grey Earn button does not respond.
- Nearby and Wallet run a pastel sweep across "Coming Soon".

## Fake OTP

The code is **123456**.

An unknown number stays on sign-in and offers Register. A wrong code stays on sign-in. Three wrong codes lock the field until the code is resent, and that wait starts at 5:00. A new account needs a Myanmar mobile number, a name of letters and spaces, and a real birth date for someone at least 13.

## Known gaps

- Nearby and Wallet are Coming Soon.
- Explore now and Order online are labels. They do not open a shop.
- Add to cart, and the blue Earn button, give feedback only. They do not change a cart or the points.
- The Gift tab is empty until a gift challenge is stored.
- Birth month names stay in English so the date parser can read them.
- The mock server is not called by the app. Refresh still reads the bundled JSON.

## Time spent

The commits run from 8 November 2026 through 9 November 2026.

## Optional mock server and CI

`tool/mock_server.dart` serves the public catalog. Airplane mode does not need it. From the repository root:

```bash
dart run tool/mock_server.dart
```

Wait until the terminal prints `Mock catalog on http://127.0.0.1:8080`. The process stays open while it listens. Stop it with Ctrl+C.

- `GET /v1/products`
- `GET /v1/banners`
- `GET /v1/shops`

Each body is `{ "data", "error", "meta" }`. `meta` carries `version: v1` and `count`. An unknown path returns HTTP 404, `data: null`, and an `error` object.

`.github/workflows/flutter.yml` runs `flutter analyze` and `flutter test` on every push and pull request. It uses Flutter 3.41.9 and does not run the device integration test.
