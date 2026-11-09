J'Donuts: Technical Overview & Architectural Documentation

J'Donuts is a production-grade Flutter application developed as a technical evaluation project for Madivizion Code Test. Designed with a robust Clean Architecture approach and state-of-the-art offline-first capabilities, the application functions seamlessly in full airplane mode using a bundled SQLite database powered by Drift.

The application adheres to strict platform standards, featuring rigorous BLoC state management, dependency injection via get_it, declarative routing with go_router, and comprehensive internationalization (English and Myanmar).

1. Technical Stack & Environment
Framework: Flutter (v3.41.9)

Language: Dart (v3.11.5)

SDK Constraint: sdk: ^3.11.5

Local Database: Drift (SQLite engine; incompatible with Chrome/Web targets)

State Management: flutter_bloc (Event/State pattern)

Dependency Injection: get_it

Routing: go_router

Localization: Built-in Flutter l10n (lib/l10n), supporting English and Myanmar (Burmese)

Execution & Testing Commands
Bash
# Install dependencies and launch the application
flutter pub get
flutter run

# Run code analysis and test suites
flutter analyze
flutter test

# Run device-dependent integration tests
flutter test integration_test/register_home_product_test.dart -d <device>
2. Project Architecture & Directory Structure
The codebase is strictly organized into decoupled layers following Clean Architecture principles. Domain logic remains entirely pure and isolated from framework dependencies, while repositories abstract data persistence.

Plaintext
lib/
├── app/                  # Application-wide configurations (theme, motion, router, shell, locale, connectivity)
├── core/                 # Shared core utilities (Result types, custom failures, deep link monitoring)
├── features/             # Feature-driven modules (auth, welcome, home, catalog, product, rewards)
└── l10n/                 # Localization bundles (English & Myanmar)

assets/
├── seed/                 # Initial database seed document (catalog.json)
├── catalog/              # Product, banner, shop, and member imagery
├── rewards/              # Challenge artwork and membership tier badges
└── nav/                  # Bottom-navigation iconography

test/                     # Unit and widget test suites
integration_test/         # End-to-end integration flows (Registration -> Home -> Product Detail)
tool/                     # Optional standalone mock server for API synchronization
.github/workflows/        # CI/CD pipeline configurations (analyze & test)
3. Core Architectural Strategies
State Management
Implemented exclusively using BLoC (Business Logic Component) with distinct Event and State contracts rather than Cubits.

UI components react strictly to defined states (Loading, Ready, Failure), facilitating high testability without requiring full app-driver integration.

Application settings (such as locale selection) utilize a lightweight ChangeNotifier pattern.

Offline-First Data Strategy
Initialization: On first launch, the app seeds its local Drift database (jdonuts.sqlite) using the embedded asset document (assets/seed/catalog.json).

Resilience: Core views (Home, Product Detail, Rewards) interface directly with the local database, guaranteeing complete offline functionality.

Connectivity Handling: A subtle status bar indicates network state ("You're offline") without blocking user interactions. Upon reconnection, background synchronization updates the local Drift cache from the catalog source.

Image Caching: Remote assets are routed through an optimized disk-caching layer equipped with graceful fallback placeholders and error states.

Motion & Design System
Declarative Animations: Standardized durations and curves are centrally managed in lib/app/motion/app_motion.dart.

Accessibility: Fully respects system-level Reduce Motion preferences by automatically normalizing animation durations to zero.

Visual Highlights: Features coordinated Hero transitions for product imagery, dynamic SVG/raster rewards ring sweeps, staggered section loading skeletons, and interactive feedback states.

4. Authentication & Security Logic
OTP Verification: The hardcoded verification code for authentication flows is 123456.

Validation Rules:

Unregistered numbers prompt registration workflows.

Incorrect OTP entries maintain the current state; three consecutive failures lock the input field and enforce a progressive cool-down timer starting at 5 minutes (5:00).

New account registration validates Myanmar mobile number formats, strictly alphabetic names with spaces, and a valid date of birth confirming the user is at least 13 years of age.

5. Development Tooling & CI/CD
Optional Mock Server
A lightweight Dart-based mock server is provided for development and testing purposes. It runs independently of offline app capabilities:

Bash
dart run tool/mock_server.dart
Endpoint Base: [http://127.0.0.1:8080](http://127.0.0.1:8080)

Exposed Routes: GET /v1/products, GET /v1/banners, GET /v1/shops

Response Structure: Standardized JSON payload containing { data, error, meta } (with meta providing version: v1 and record count). Unmatched paths return HTTP 404.

Continuous Integration
The repository includes a GitHub Actions workflow (.github/workflows/flutter.yml) configured to execute flutter analyze and flutter test automatically on every push and pull request against target branches, utilizing Flutter SDK v3.41.9.
