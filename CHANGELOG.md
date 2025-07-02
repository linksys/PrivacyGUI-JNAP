# Changelog

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
