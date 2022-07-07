# Flutter Issue Tracker

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]


Flutter Issue Tracker

---

## Getting Started 🚀

Flutter Issue Tracker is a hybrid application which lists the "issues" from the "Flutter" repository in Github.com. 
The application is capable of: 

* see a list of all issues of a Flutter GitHub repository (https://github.com/flutter/flutter)
* be able to navigate to a detail screen of an issue that features relevant information
* see the already visited issues distinguished at the list of all issues
* be able to switch between dark and light modes
* be able to sort and filter the list of issues

The core features of the app includes:

* Issues list page
 * Pagination with an infinitely scrolling list
 * Filtering and sorting issues
 * Tapping on an issue should navigate to the detail page 
 * Visited issues are distinguished from others
* Issue detail page
 * Display title,author,description,creation date and other relevant information.
* Other
 * error handling

Technical features and implementation includes:|

* The project uses CLEAN architecture with BloC as the State management tool.
* The code is hence made as scalable and maintainable
* 80%+ coverage with unit and widget tests (An example golden test)
* Leverages GitHub’s GraphQL API
* A CI on GitHub Actions on deploying Android Production level Application.
* Deploy app to Firebase App Distribution - https://appdistribution.firebase.dev/i/e3c84871fd066b1c


## The Code elements 🔡

The application is capable of running in Android and iOS devices and built using Flutter. The code uses BLoC as the state management tool. It uses CLEAN architecture which divides the entire code into PRESENTATION, DOMAIN and DATA layer, making the system scalable and maintainable. The following packages are used in the development:

* animated_text_kit: ^4.2.2
* bloc: ^8.0.3
* cached_network_image: ^3.2.1
* dartz: ^0.10.1
* data_connection_checker_nulls: ^0.0.2
* equatable: ^2.0.3
* flutter_bloc: ^8.0.1
* flutter_dotenv: ^5.0.2
* flutter_native_splash: ^2.2.4
* flutter_screenutil: ^5.5.3+2
* fluttertoast: ^8.0.9
* get_it: ^7.2.0
* graphql_flutter: ^5.1.0
* intl: ^0.17.0
* modal_bottom_sheet: ^2.1.0
* network_image_mock: ^2.1.1
* pull_to_refresh: ^2.0.0
* shared_preferences: ^2.0.15
* stacked_themes: ^0.3.8+1
* stream_transform: ^2.0.0
* timeago: ^3.2.2
* webview_flutter: ^3.0.4

dev_dependencies:
* bloc_test: ^9.0.3
* flutter_launcher_icons: ^0.9.3
* flutter_test:
* sdk: flutter
* mocktail: ^0.3.0
* very_good_analysis: ^3.0.0

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Flutter Issue Tracker works on iOS, Android, Web, and Windows._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---


[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli