
## [1.0.10] - 2025-09-05

### Added
- Firmware Update: Added `FirmwareUpdateNotifier` provider and `FirmwareUpdateService`, with initial unit tests.
- Tests: Expanded provider tests to cover `fetchNodeFirmwareStatus`, `updateFirmware`, and `manualFirmwareUpdate` flows.
- Tests: Added a dedicated test suite for `FirmwareUpdateState`.

### Changed
- Firmware Update: Migrated `FirmwareUpdateProvider` and its dependencies to the new module structure.
- Firmware Update: Improved `manualFirmwareUpdate` for testability by allowing an optional `HttpClient` injection; enhanced base64/JSON decoding robustness and error handling.
- Provider build: Hardened parsing in `build()` to safely handle empty/missing outputs for settings and status lists.
- Tests: Strengthened `setFirmwareUpdatePolicy` test using a `Completer` to ensure state updates only after the service resolves, and verified payload sent to the service.

## [1.0.9] - 2025-09-04

### Changed
- Enhanced JNAP client with improved testing and caching.
- Implemented and refactored polling module.
- Refactored polling mechanism and updated tests.
- Added more robust test cases for HttpClient.
- Removed mockito library and used mocktail instead.

### Fixed
- [Polling] Fixed testing fail.

## [1.0.8] - 2025-09-03

### Added
- **JNAP Data Models**:
  - Added new data models for various JNAP services, including `AdvancedRoutingRule`, `ALGSettings`, `AutoConfigurationSettings`, `BackHaulInfo`, `DDNSSettings`, `Device`, `DeviceInfo`, `DhcpLease`, `DMZSettings`, `DynDNSSettings`, `RouterEthernetPortConnections`, `ExpressForwardingSettings`, `FirewallSettings`, `FirmwareUpdateSettings`, `FirmwareUpdateStatus`, `NodesFirmwareUpdateStatus`, `GetPortConnectionStatus`, `GetRoutingSettings`, `GuestRadioSettings`, `HealthCheckResult`, `IPv6AutomaticSettings`, `IPv6FirewallRule`, `GetIPv6Settings`, `RouterLANSettings`, `Layer2Connection`, `MACAddressCloneSettings`, `MACFilterSettings`, `ManagementSettings`, `NoIPSettings`, `NodeLightSettings`, `NodeWirelessConnections`, `PingStatus`, `PortRangeForwardingRule`, `PortRangeTriggeringRule`, `PowerTableSettings`, `GetRadioInfo`, `RemoteSetting`, `SendSysinfoEmail`, `SetRouterLANSettings`, `SetRadioSettings`, `SetRoutingSettings`, `SimpleWiFiSettings`, `SinglePortForwardingRule`, `SoftSKUSettings`, `SupportedTimezone`, `TracerouteStatus`, `TZOSettings`, `BTDiscoveryData`, `UPnPSettings`, `WanExternal`, `WANPort`, `RouterWANSettings`, `RouterWANStatus`, `WirelessConnection`.
- **Testing**:
  - Added comprehensive unit tests for `IpAddressUtils` (`ip_address_test.dart`).
  - Added comprehensive unit tests for `WiFiCredential` (`wifi_credential_test.dart`).

### Fixed
- **Utilities**:
  - Fixed `UnitUtils.formatBytes` to correctly apply decimal places for whole numbers.
  - Fixed `IpAddressUtils`:
    - Corrected `isValidSubnetMask` to handle `0.0.0.0` and `255.255.255.255` within prefix length constraints.
    - Introduced `_isSyntacticallyValidSubnetMask` helper for robust subnet mask validation.
    - Fixed off-by-one error in `getMaxUserAllowedInDHCPRange`.
    - Corrected logic in `getEndingIpAddress`.
    - Adjusted `getMaxUserLimit` calculation.
  - Fixed `WiFiCredential.parse` to correctly parse `SecurityType` (case-insensitivity).

## [1.0.7] - 2025-08-28

### Added
- **JNAP Data Models**:
  - Added new data models for various JNAP services, including `AdvancedRoutingRule`, `ALGSettings`, `AutoConfigurationSettings`, `BackHaulInfo`, `DDNSSettings`, `Device`, `DeviceInfo`, `DhcpLease`, `DMZSettings`, `DynDNSSettings`, `RouterEthernetPortConnections`, `ExpressForwardingSettings`, `FirewallSettings`, `FirmwareUpdateSettings`, `FirmwareUpdateStatus`, `NodesFirmwareUpdateStatus`, `GetPortConnectionStatus`, `GetRoutingSettings`, `GuestRadioSettings`, `HealthCheckResult`, `IPv6AutomaticSettings`, `IPv6FirewallRule`, `GetIPv6Settings`, `RouterLANSettings`, `Layer2Connection`, `MACAddressCloneSettings`, `MACFilterSettings`, `ManagementSettings`, `NoIPSettings`, `NodeLightSettings`, `NodeWirelessConnections`, `PingStatus`, `PortRangeForwardingRule`, `PortRangeTriggeringRule`, `PowerTableSettings`, `GetRadioInfo`, `RemoteSetting`, `SendSysinfoEmail`, `SetRouterLANSettings`, `SetRadioSettings`, `SetRoutingSettings`, `SimpleWiFiSettings`, `SinglePortForwardingRule`, `SoftSKUSettings`, `SupportedTimezone`, `TracerouteStatus`, `TZOSettings`, `BTDiscoveryData`, `UPnPSettings`, `WanExternal`, `WANPort`, `RouterWANSettings`, `RouterWANStatus`, `WirelessConnection`.
- **Testing**:
  - Added comprehensive unit tests for `IpAddressUtils` (`ip_address_test.dart`).
  - Added comprehensive unit tests for `WiFiCredential` (`wifi_credential_test.dart`).

### Fixed
- **Utilities**:
  - Fixed `UnitUtils.formatBytes` to correctly apply decimal places for whole numbers.
  - Fixed `IpAddressUtils`:
    - Corrected `isValidSubnetMask` to handle `0.0.0.0` and `255.255.255.255` within prefix length constraints.
    - Introduced `_isSyntacticallyValidSubnetMask` helper for robust subnet mask validation.
    - Fixed off-by-one error in `getMaxUserAllowedInDHCPRange`.
    - Corrected logic in `getEndingIpAddress`.
    - Adjusted `getMaxUserLimit` calculation.
  - Fixed `WiFiCredential.parse` to correctly parse `SecurityType` (case-insensitivity).


## [1.0.6] - 2025-08-26

### Added
- **Utilities**:
  - `BenchMarkLogger` for performance monitoring.
  - `StringExt` and `MapExt` extensions for various data manipulations, including `isBase64`, `capitalize`, `kebab`, `getValueByPath`, etc.
- **Device Icon Logic**:
  - Comprehensive rules and helpers (`node_icon_rules`, `node_icon_rules_helper`) to determine device icons from model information.
  - `IconDeviceCategory` enum to standardize device categories.
- **Node Model Logic**:
  - `node_model` and `node_model_map` to identify device characteristics like `isMeshRouter`, `isCognitiveMesh`, etc.
- **WiFi Utility**:
  - `getWifiSignalLevel` function to determine signal strength level (e.g., excellent, good, poor).
- **Testing**:
  - Added extensive unit tests for all new utilities and logic (`bench_mark_test.dart`, `crypto_test.dart`, `extension_test.dart`, `node_icon_rules_test.dart`, `node_model_test.dart`, `wifi_test.dart`).

### Changed
- **Build Scripts**: Updated `run_generate_coverage.sh` and `run_tests_and_report.sh` to output results to a standardized `build/results` directory.

### Fixed
- **JNAP**:
  - Corrected a typo in `Jnap.dart` from `scheulded` to `scheduled`.
- **Utilities**:
  - Fixed bugs in `getValueByPath` and `isBase64` extension methods to handle edge cases correctly.
  - Corrected logic in `node_icon_rules_helper` and `wifi` utilities based on new test findings.
- **Tests**:
  - Corrected invalid hash values in `crypto_test.dart`.

### Removed
- **`Base64Utils`**: Removed the standalone `Base64Utils` class in favor of the `isBase64` string extension.

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
