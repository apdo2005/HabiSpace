# HabiSpace Project Instructions

## Architecture & Framework
- **Framework:** Flutter
- **Architecture:** Feature-based structure (`lib/features`) with a centralized core (`lib/core`).
- **State Management:** BLoC (`flutter_bloc`).
- **Navigation:** GoRouter (`go_router`).
- **Dependency Injection:** GetIt (`get_it`).
- **Networking:** Dio (`dio`).
- **Localization:** Easy Localization (`easy_localization`).

## Conventions
- **Feature Structure:** Each feature in `lib/features` should ideally follow a Clean Architecture-like structure (data, domain, presentation) where applicable.
- **Routing:** All routes must be defined in `lib/core/router/app_router.dart` and `app_routes.dart`.
- **Dependency Injection:** Register all services and blocs in `lib/core/di/get_it.dart`.
- **Styling:** Follow the project's theme defined in `lib/core/theme/`.

## Development Workflows
- **Localization:** Add new strings to `assets/translations/en.json` and `assets/translations/ar.json`.
- **Assets:** Register all new assets in `pubspec.yaml`.
- **Testing:** Add widget and unit tests in the `test/` directory following the feature structure.
