# JNAP Dart Client

This project provides a Dart client for interacting with JNAP-enabled devices.

## Overview

This library allows developers to easily integrate JNAP communication into their Dart and Flutter applications. It provides a high-level API for device discovery, service management, and real-time monitoring of network devices.

## Features

- **Device Discovery**: Automatically discovers JNAP-enabled devices on the network.
- **Service Management**: Lists and interacts with services provided by discovered devices.
- **Real-time Monitoring**: Provides real-time status and monitoring of network devices.

## Installation

To use this library in your project, add it as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  jnap: 
    git:
      url: https://github.com/linksys/PrivacyGUI-JNAP.git
      ref: main  # or a specific version tag like v1.0.0
```

Then, run `flutter pub get` to install the package.

## Changelog

For a detailed list of changes, please see the [CHANGELOG.md](CHANGELOG.md) file.

## Usage

### Basic Setup

```dart
import 'package:jnap/jnap.dart';

void main() async {
  try {
    // Initialize the JNAP client
    Jnap.init(
      baseUrl: 'http://router.linksys.com',
      path: '/JNAP/',
      extraHeaders: {},
      auth: 'username:password', // Base64 encoded credentials
      authType: AuthType.basic,
    );

    // Access the singleton instance
    final jnap = Jnap.instance;
    
    // Example: Check device connectivity
    // Note: Actual method names may vary based on implementation
    // final response = await jnap.someAction();
    // print('Response: $response');
    
  } catch (e) {
    print('Error: $e');
  }
}
```

### Authentication

The JNAP client supports basic authentication with base64-encoded credentials. The `auth` parameter must be a base64-encoded string in the format `username:password`.

```dart
import 'dart:convert';

// Basic Authentication with base64-encoded credentials
final username = 'admin';
final password = 'password';
final credentials = base64Encode(utf8.encode('$username:$password'));

Jnap.init(
  baseUrl: 'http://router.linksys.com',
  path: '/JNAP/',
  extraHeaders: {},
  auth: credentials, // Must be base64-encoded 'username:password'
  authType: AuthType.basic,
);
```

Note: The `auth` parameter must be pre-encoded in base64 format. The library will validate this and throw an exception if the string is not properly encoded.

### Available Modules

The plugin is organized into functional modules, each corresponding to a JNAP service:

- **Core**: Device information and basic operations
- **Network**: WAN, LAN, and WiFi configuration
- **Device**: Device management and monitoring
- **Security**: Firewall and access control
- **System**: Firmware, diagnostics, and logs
- **Advanced**: Port forwarding, QoS, and VPN

### Making JNAP Calls

```dart
// Get network status
final status = await client.network.getStatus();

// Change WiFi settings
await client.wifi.setSettings(
  WifiSettings(
    ssid: 'MyNetwork',
    security: WifiSecurity.wpa2Personal,
    password: 'securepassword',
  ),
);
```

## JavaScript Interop

For web applications, the plugin can be compiled to JavaScript. See [README_JS.md](README_JS.md) for JavaScript-specific documentation.

## Development

### Project Structure

```
lib/
  jnap.dart                 # Main library export
  src/
    models/               # Data models and DTOs
    modules/              # JNAP service modules
      core/               # Core functionality
      network/            # Network configuration
      device/             # Device management
      security/           # Security features
      system/             # System utilities
    jnap.dart             # Core JNAP implementation
    consts.dart           # Constants and enums
    config.dart           # Configuration
```

### Adding New Actions

1. Create a new action class in the appropriate module
2. Define the request/response models
3. Register the action with the service

Example:

```dart
// In lib/src/modules/network/action.dart
class GetNetworkStatusAction extends JNAPAction<NetworkStatus> {
  @override
  String get name => 'GetNetworkStatus';
  
  @override
  String get path => 'network/status';
}
```

## Testing

Run tests with:

```bash
flutter test
```
