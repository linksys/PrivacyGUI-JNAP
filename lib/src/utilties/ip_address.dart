import 'dart:math';

import 'package:collection/collection.dart';

class IpAddressUtils {
  static bool isValidIpAddress(String ipAddress) {
    final octets = ipAddress.split('.');
    if (octets.length != 4) return false;
    final octet1 = int.tryParse(octets[0]);
    if (octet1 == null || octet1 > 255 || octet1 < 0) return false;
    final octet2 = int.tryParse(octets[1]);
    if (octet2 == null || octet2 > 255 || octet2 < 0) return false;
    final octet3 = int.tryParse(octets[2]);
    if (octet3 == null || octet3 > 255 || octet3 < 0) return false;
    final octet4 = int.tryParse(octets[3]);
    if (octet4 == null || octet4 > 255 || octet4 < 0) return false;

    return true;
  }

  static int ipToNum(String ipAddress) {
    final octets = ipAddress.split('.');
    if (octets.length != 4 || !isValidIpAddress(ipAddress)) {
      return 0; // Or throw an exception for invalid input
    }

    final a = int.parse(octets[0]);
    final b = int.parse(octets[1]);
    final c = int.parse(octets[2]);
    final d = int.parse(octets[3]);

    // Use bit shifting to combine the octets into a 32-bit integer
    return (a << 24) + (b << 16) + (c << 8) + d;
  }

  static String numToIp(int num) {
    if (num < 0 || num > 4294967295) return '0.0.0.0';

    // Use bit shifting and AND operations to extract each octet
    final a = (num >> 24) & 0xFF;
    final b = (num >> 16) & 0xFF;
    final c = (num >> 8) & 0xFF;
    final d = num & 0xFF;

    return '$a.$b.$c.$d';
  }

  static bool ipInRange(ipAddress, ipAddressMin, ipAddressMax) {
    if (isValidIpAddress(ipAddress) == false ||
        isValidIpAddress(ipAddressMin) == false ||
        isValidIpAddress(ipAddressMax) == false) {
      throw ArgumentError();
    }
    if (ipToNum(ipAddressMin) > ipToNum(ipAddressMax)) {
      throw ArgumentError('Range error');
    }
    return ipToNum(ipAddress) >= ipToNum(ipAddressMin) &&
        ipToNum(ipAddress) <= ipToNum(ipAddressMax);
  }

  static bool _isSyntacticallyValidSubnetMask(String subnetMask) {
    if (isValidIpAddress(subnetMask) == false) {
      return false;
    }
    var subnetMaskBits = ipToNum(subnetMask).toRadixString(2).padLeft(32, '0');
    var firstZero = subnetMaskBits.indexOf('0');

    if (firstZero == -1) {
      // All ones, e.g., 255.255.255.255, which is a valid subnet mask
      return true;
    }

    // Check if there's any '1' after the first '0'
    var firstOneAfterZero = subnetMaskBits.indexOf('1', firstZero);
    return firstOneAfterZero == -1;
  }

  static bool isValidSubnetMask(String subnetMask,
      {int minNetworkPrefixLength = 8, int maxNetworkPrefixLength = 30}) {
    if (!_isSyntacticallyValidSubnetMask(subnetMask)) {
      return false;
    }

    if (minNetworkPrefixLength < 1 || minNetworkPrefixLength > 31) {
      throw const FormatException(
        'Invalid minNetworkPrefixLength passed, must be between 1 and 31',
      );
    }
    if (maxNetworkPrefixLength < 1 || maxNetworkPrefixLength > 31) {
      throw const FormatException(
        'Invalid maxNetworkPrefixLength passed, must be between 1 and 31',
      );
    }
    if (maxNetworkPrefixLength < minNetworkPrefixLength) {
      throw const FormatException(
        'maxNetworkPrefixLength cannot be less than minNetworkPrefixLength',
      );
    }

    var subnetMaskBits = ipToNum(subnetMask).toRadixString(2).padLeft(32, '0');
    var prefixLength = subnetMaskBits.indexOf('0');
    if (prefixLength == -1) { // All ones (255.255.255.255)
      prefixLength = 32;
    } else if (prefixLength == 0 && subnetMaskBits.contains('1')) { // All zeros (0.0.0.0)
      prefixLength = 0;
    }

    if (prefixLength < minNetworkPrefixLength ||
        prefixLength > maxNetworkPrefixLength) {
      return false; // Return false if prefix length is out of range
    }
    return true;
  }

  static String getIpPrefix(String ipAddress, String subnetMask) {
    if (!isValidIpAddress(ipAddress) || !isValidSubnetMask(subnetMask)) {
      throw ArgumentError();
    }
    final subnetMaskToken = subnetMask.split('.');
    return ipAddress
        .split('.')
        .mapIndexed(
            (index, e) => int.parse(e) & int.parse(subnetMaskToken[index]))
        .join('.');
  }

  static String prefixLengthToSubnetMask(int prefixLength) {
    final subnetMaskTestBits =
        List.filled(prefixLength, '1').join().padRight(32, '0');
    return RegExp(r'.{1,8}')
        .allMatches(subnetMaskTestBits)
        .map((e) => int.parse(e.group(0)!, radix: 2))
        .toList()
        .join('.');
  }

  static int subnetMaskToPrefixLength(String subnetMask) {
    if (!_isSyntacticallyValidSubnetMask(subnetMask)) {
      throw Exception('Invalid subnet mask passed');
    }
    final prefixLength = ipToNum(subnetMask).toRadixString(2).indexOf('0');
    return prefixLength == -1 ? 32 : prefixLength;
  }

  /*
     * @description returns a Boolean for whether the Router's IP Address is within the DHCP Range (explicit or calculated)
     * @params {String} routerIPAddress - A string representing the current IP of the Router
     * @params {String} firstClientIPAddress - A string representing the starting IP of the DHCP Range
     * @params {String} lastClientIPAddress [optional] - A string representing the end IP of the DHCP Range
     * @params {Integer} maxUsers [optional] - An integer containing the current # of users the DHCP Range should allow; used if lastClientIPAddress is not passed in
     * @return {Boolean}
  */
  static bool isRouterIPInDHCPRange(
      String routerIPAddress, String firstClientIPAddress,
      [String? lastClientIPAddress, int? maxUsers]) {
    final ipAddressNum = ipToNum(routerIPAddress);
    final firstClientIPAddressNum = ipToNum(firstClientIPAddress);
    final lastClientIPAddressNum = lastClientIPAddress != null
        ? ipToNum(lastClientIPAddress)
        : firstClientIPAddressNum + maxUsers! - 1;
    return ipAddressNum >= firstClientIPAddressNum &&
        ipAddressNum <= lastClientIPAddressNum;
  }

  /*
     * @description returns an Integer for the max # of users allowed by the current DHCP Range
     * @params {String} routerIPAddress - A string representing the current IP of the Router
     * @params {String} firstClientIPAddress - A string representing the starting IP of the DHCP Range
     * @params {String} lastClientIPAddress - A string representing the end IP of the DHCP Range
     * @return {Integer}
  */
  static int getMaxUserAllowedInDHCPRange(String routerIPAddress,
      String firstClientIPAddress, String lastClientIPAddress) {
    final firstClientIPAddressNum = ipToNum(firstClientIPAddress);
    final lastClientIPAddressNum = ipToNum(lastClientIPAddress);
    var maxUsers = lastClientIPAddressNum - firstClientIPAddressNum + 1;
    return maxUsers;
  }

  /*
     * @description returns a String representing the last IP of the DHCP Range
     * @params {String} firstClientIPAddress - A string representing the starting IP of the DHCP Range
     * @params {Integer} maxUsers - An integer containing the current # of users the DHCP Range should allow
     * @return {String}
  */
  static String getEndDHCPRangeForMaxUsers(
      String firstClientIPAddress, int maxUsers) {
    final firstClientIPAddressNum = ipToNum(firstClientIPAddress);
    final lastClientIPAddressNum = firstClientIPAddressNum + maxUsers - 1;

    return numToIp(lastClientIPAddressNum);
  }

  static String getEndingIpAddress(
    String routerIpAddress,
    String firstClientIpAddress,
    int maxUserAllowed,
  ) {
    final firstClientIpAddressNum = ipToNum(firstClientIpAddress);
    final lastClientIpAddressNum = firstClientIpAddressNum + maxUserAllowed - 1;
    return numToIp(lastClientIpAddressNum);
  }

  /*
     * @description returns an Integer for the max # of users that could be set, based on the 1st DHCP Client IP Address and the SubnetMask of the Router
     * @params {String} routerIPAddress - A string representing the current IP of the Router
     * @params {String} firstClientIPAddress - A string representing the starting IP of the DHCP Range
     * @params {String} subnetMask - A string representing the end IP of the DHCP Range
     * @params {Integer} maxUsers - An integer containing the current # of users the DHCP Range should allow
     * @return {Integer}
  */
  static int getMaxUserLimit(
    String routerIPAddress,
    String firstClientIPAddress,
    String subnetMask,
    int maxUsers,
  ) {
    final currentPrefixLength = subnetMaskToPrefixLength(subnetMask);
    int maxUserLimit = pow(2, 32 - currentPrefixLength).toInt();
    final subnetMaskNum = ipToNum(subnetMask);
    final firstClientIPAddressNum = ipToNum(firstClientIPAddress);
    final firstClientIPAddressBinary = firstClientIPAddressNum.toRadixString(2);

    final startingIPAddress = int.parse(
            subnetMaskNum.toRadixString(2).substring(0, currentPrefixLength) +
                firstClientIPAddressBinary.substring(
                    firstClientIPAddressBinary.length -
                        (32 - currentPrefixLength),
                    firstClientIPAddressBinary.length),
            radix: 2) -
        subnetMaskNum;
    if (isRouterIPInDHCPRange(
        routerIPAddress, firstClientIPAddress, null, maxUsers)) {
      maxUserLimit--;
    }

    return maxUserLimit - startingIPAddress - 1;
  }

  static bool isMtuValid(String wanType, int mtu) {
    return mtu == 0 || (getMinMtu(wanType) <= mtu && mtu <= getMaxMtu(wanType));
  }

  static int getMinMtu(String wanType) {
    return switch (wanType.toLowerCase()) {
      'dhcp' => 576,
      'pppoe' => 576,
      'static' => 576,
      'pptp' => 576,
      'l2tp' => 576,
      _ => 0,
    };
  }

  static int getMaxMtu(String wanType) {
    return switch (wanType.toLowerCase()) {
      'dhcp' => 1500,
      'pppoe' => 1492,
      'static' => 1500,
      'pptp' => 1460,
      'l2tp' => 1460,
      _ => 0,
    };
  }
}
