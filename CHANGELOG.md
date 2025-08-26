## [1.0.5] - 2025-08-25

### Added
- **Caching Mechanism:** Implemented a caching layer for JNAP responses to improve performance and reduce network traffic.
  - Caches data based on device serial number.
  - Supports both mobile and web platforms with specific implementations.
  - Configurable cache expiration.
- **Command Queue:** Introduced a command queue to process JNAP requests sequentially, preventing race conditions and simplifying asynchronous operations.
- **Unit Tests:** Added comprehensive unit tests for the new caching and command queue functionalities.

### Changed
- **JNAP Execution:** Refactored the core JNAP request handling to use the new command queue and `JNAPCommand` objects.
- **Retry Strategy:** Enhanced the `RetryStrategy` with an `onComplete` callback to provide better feedback on the final status of a retryable operation.

## [1.0.4] - 2025-08-21

### Added
- New scripts for test coverage generation (`generate_coverage.sh`) and comprehensive test reporting (`run_tests_and_report.sh`).
- Extensive unit tests for various modules and utilities, including:
    - `Config` class
    - `Jnap` initialization and URL/auth updates
    - `ErrorResponse` and `ErrorMfaRequired` models
    - `JNAPTransactionBuilder`
    - `AirtimeFairnessAction`, `AutoOnboardingAction`, `BluetoothAction`, `DFSSAction`, `WebJNAPAction`
    - `Base64Utils`, `UrlUtils`
    - `HttpClient` (with retry logic), `CustomMultipartRequest`, `MobileClient`
    - `LoggerHooks`, `AppLogger`
- Added `mockito` as a dev dependency.
- Added `@visibleForTesting` annotations to logger hooks for improved testability.

### Changed
- Improved error handling in `Jnap` for invalid base URL and path combinations.
- Modified `JNAPTransactionBuilder` to ensure `_commands` is a mutable copy.
- Broadened the type of HTTP client that can be used in `HttpClient` from `IOClient` to `BaseClient`.
- Updated `jnap_test.dart` to include new unit tests and mark existing group definitions with `tags: 'manual'`.
- Updated `core_test.dart` to include versioning tests for JNAP actions.
- Updated `encrypt_test.dart` with more robust AES encryption/decryption tests.

### Removed
- Deprecated legacy JNAP action and service files (`better_action.dart`, `jnap_action.dart`, `jnap_action_value.dart`, `jnap_service_supported.dart`).

# Changelog

## [1.0.3] - 2025-08-20

### Changed
- Reworked the internal retry mechanism to be stream-based for polling operations using a new `executeStream` method. This allows for observing each attempt of a scheduled/polling JNAP call.
- Refactored the `Jnap.scheulded` method to use the new stream-based retry logic, making it more robust and idiomatic. The `onCompleted` callback has been removed in favor of using standard `onDone`/`onError` listeners on the returned stream.

### Fixed
- Fixed a bug in `Jnap.scheulded` where it would not correctly return a stream of results.
- Fixed an issue where `Jnap.scheulded` did not pass request parameters (`data`, `headers`, `overrides`) to the underlying network call.

## [1.0.2] - 2025-07-02

### Fixed
- Fixed transaction response handling

## [1.0.1] - 2025-07-02

### Added
- Added support for `SetAdminPassword2` action in Core service
- Added `isSupport` utility method to JNAPServiceList for easier service capability checking
- Added missing service support declarations for various services (TopologyOptimization, Router, RouterLEDs, Setup, WirelessAP)

### Changed
- Updated service support naming conventions (removed 'isSupport' prefix from service names)
- Improved JNAPService constructor with better default handling of supported services
- Removed hardcoded supported services in favor of dynamic discovery
- Updated version handling for various services

### Fixed
- Fixed service support checking logic in JNAPService
- Corrected version numbers for service capabilities
- Fixed transaction response handling

## [1.0.0] - 2025-06-26

### Initial Release
- Core services (Core1-Core9)
- Network configuration (WAN, LAN, WiFi)
- Device management and monitoring
- Security features (Firewall, Parental Controls)
- System utilities (Firmware, Diagnostics, Logs)
- Advanced features (Port Forwarding, QoS, VPN)
- Support for JNAP protocol versioning and service discovery
- Built-in error handling and response validation
- Comprehensive test coverage for all major components

### Architecture
- Modular service-based architecture
- Type-safe JNAP action definitions
- Asynchronous API with proper error handling
- Support for both synchronous and batch operations
- Extensible service registration system

### Dependencies
- Built with Dart 3.0.0+
- Uses modern packages: http, equatable, async, logger
- Follows null safety best practices

## [1.0.0] - Initial Release

Initial release of the JNAP plugin with basic functionality.

### Added
- Core JNAP protocol implementation
- Basic service registration system
- Initial set of JNAP actions and services
- Basic error handling and response parsing
