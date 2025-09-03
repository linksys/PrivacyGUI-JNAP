## Project Overview

This project is a Dart client for interacting with JNAP (Juniper Network Access Protocol) enabled devices. It provides a high-level API for device discovery, service management, and real-time monitoring of network devices. The library is designed for use in Dart and Flutter applications and includes a JavaScript interoperability layer for web-based applications.

**Key Technologies:**

*   **Language:** Dart
*   **Framework:** Flutter (implied by dependencies and test commands)
*   **Key Libraries:** `http` for network requests, `logger` for logging, `encrypt` for data encryption.

**Architecture:**

The library is structured into modules that correspond to different JNAP services. Key directories include:

*   `lib/`: Contains the main source code.
*   `lib/src/models/`: Defines data models and Data Transfer Objects (DTOs).
*   `lib/src/modules/`: Contains the various JNAP service modules (e.g., Core, Network, Security).
*   `test/`: Contains unit and integration tests.

## Building and Running

### Running Tests

To run the tests and generate a coverage report, use the following script:

```bash
./run_tests_and_report.sh
```

This script will:

1.  Run `flutter test` to execute the tests.
2.  Generate a JSON test report.
3.  Convert the JSON report to JUnit XML format.
4.  Convert the JUnit XML report to an HTML report.

The final HTML report will be available at `build/results/test_report.html`.

### Building for JavaScript

For web applications, the project can be compiled to JavaScript. Refer to `README_JS.md` for more details on the JavaScript interop. The `bin/build_js.sh` script is likely used for this purpose.

## Development Conventions

### Adding New JNAP Actions

To add a new JNAP action:

1.  Create a new action class within the appropriate module in `lib/src/modules/`.
2.  Define the request and response models for the action in `lib/src/models/`.
3.  Register the action with the corresponding service.

### Coding Style

The project uses the `lints` package to enforce coding standards. It is recommended to run the linter to ensure code quality.

### Authentication

The client supports Basic Authentication. Credentials must be Base64 encoded in the format `username:password` and passed to the `Jnap.init()` method.
