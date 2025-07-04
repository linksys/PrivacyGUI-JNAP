
const testServiceList = [
  "http://linksys.com/jnap/bornon/BornOn",
  "http://linksys.com/jnap/core/Core",
  "http://linksys.com/jnap/core/Core2",
  "http://linksys.com/jnap/core/Core3",
  "http://linksys.com/jnap/core/Core4",
  "http://linksys.com/jnap/core/Core5",
  "http://linksys.com/jnap/core/Core6",
  "http://linksys.com/jnap/core/Core7",
  "http://linksys.com/jnap/core/Core8",
  "http://linksys.com/jnap/core/Core9",
  "http://linksys.com/jnap/ddns/DDNS",
  "http://linksys.com/jnap/ddns/DDNS2",
  "http://linksys.com/jnap/ddns/DDNS3",
  "http://linksys.com/jnap/ddns/DDNS4",
  "http://linksys.com/jnap/debug/Debug",
  "http://linksys.com/jnap/debug/Debug2",
  "http://linksys.com/jnap/devicelist/DeviceList",
  "http://linksys.com/jnap/devicelist/DeviceList2",
  "http://linksys.com/jnap/devicelist/DeviceList4",
  "http://linksys.com/jnap/devicelist/DeviceList5",
  "http://linksys.com/jnap/devicelist/DeviceList6",
  "http://linksys.com/jnap/devicelist/DeviceList7",
  "http://linksys.com/jnap/devicepreauthorization/DevicePreauthorization",
  "http://linksys.com/jnap/diagnostics/Diagnostics",
  "http://linksys.com/jnap/diagnostics/Diagnostics10",
  "http://linksys.com/jnap/diagnostics/Diagnostics2",
  "http://linksys.com/jnap/diagnostics/Diagnostics3",
  "http://linksys.com/jnap/diagnostics/Diagnostics6",
  "http://linksys.com/jnap/diagnostics/Diagnostics7",
  "http://linksys.com/jnap/diagnostics/Diagnostics8",
  "http://linksys.com/jnap/diagnostics/Diagnostics9",
  "http://linksys.com/jnap/diagnostics/Reliability",
  "http://linksys.com/jnap/dynamicportforwarding/DynamicPortForwarding",
  "http://linksys.com/jnap/dynamicportforwarding/DynamicPortForwarding2",
  "http://linksys.com/jnap/dynamicsession/DynamicSession",
  "http://linksys.com/jnap/dynamicsession/DynamicSession2",
  "http://linksys.com/jnap/firewall/Firewall",
  "http://linksys.com/jnap/firewall/Firewall2",
  "http://linksys.com/jnap/firmwareupdate/FirmwareUpdate",
  "http://linksys.com/jnap/firmwareupdate/FirmwareUpdate2",
  "http://linksys.com/jnap/guestnetwork/GuestNetwork",
  "http://linksys.com/jnap/guestnetwork/GuestNetwork2",
  "http://linksys.com/jnap/guestnetwork/GuestNetwork3",
  "http://linksys.com/jnap/guestnetwork/GuestNetwork4",
  "http://linksys.com/jnap/guestnetwork/GuestNetwork5",
  "http://linksys.com/jnap/guestnetwork/GuestNetworkAuthentication",
  "http://linksys.com/jnap/httpproxy/HttpProxy",
  "http://linksys.com/jnap/httpproxy/HttpProxy2",
  "http://linksys.com/jnap/locale/Locale",
  "http://linksys.com/jnap/locale/Locale2",
  "http://linksys.com/jnap/locale/Locale3",
  "http://linksys.com/jnap/macfilter/MACFilter",
  "http://linksys.com/jnap/macfilter/MACFilter2",
  "http://linksys.com/jnap/networkconnections/NetworkConnections",
  "http://linksys.com/jnap/networkconnections/NetworkConnections2",
  "http://linksys.com/jnap/networkconnections/NetworkConnections3",
  "http://linksys.com/jnap/nodes/autoonboarding/AutoOnboarding",
  "http://linksys.com/jnap/nodes/autoonboarding/AutoOnboarding2",
  "http://linksys.com/jnap/nodes/autoonboarding/AutoOnboarding3",
  "http://linksys.com/jnap/nodes/bluetooth/Bluetooth",
  "http://linksys.com/jnap/nodes/bluetooth/Bluetooth2",
  "http://linksys.com/jnap/nodes/bluetooth/Bluetooth3",
  "http://linksys.com/jnap/nodes/btsmartconnect/BTSmartConnect",
  "http://linksys.com/jnap/nodes/btsmartconnect/BTSmartConnect2",
  "http://linksys.com/jnap/nodes/btsmartconnect/BTSmartConnect3",
  "http://linksys.com/jnap/nodes/diagnostics/Diagnostics",
  "http://linksys.com/jnap/nodes/diagnostics/Diagnostics2",
  "http://linksys.com/jnap/nodes/diagnostics/Diagnostics3",
  "http://linksys.com/jnap/nodes/diagnostics/Diagnostics5",
  "http://linksys.com/jnap/nodes/diagnostics/Diagnostics6",
  "http://linksys.com/jnap/nodes/firmwareupdate/FirmwareUpdate",
  "http://linksys.com/jnap/nodes/networkconnections/NodesNetworkConnections",
  "http://linksys.com/jnap/nodes/networkconnections/NodesNetworkConnections2",
  "http://linksys.com/jnap/nodes/notification/Notification",
  "http://linksys.com/jnap/nodes/setup/Setup",
  "http://linksys.com/jnap/nodes/setup/Setup10",
  "http://linksys.com/jnap/nodes/setup/Setup11",
  "http://linksys.com/jnap/nodes/setup/Setup2",
  "http://linksys.com/jnap/nodes/setup/Setup3",
  "http://linksys.com/jnap/nodes/setup/Setup4",
  "http://linksys.com/jnap/nodes/setup/Setup5",
  "http://linksys.com/jnap/nodes/setup/Setup6",
  "http://linksys.com/jnap/nodes/setup/Setup7",
  "http://linksys.com/jnap/nodes/setup/Setup8",
  "http://linksys.com/jnap/nodes/setup/Setup9",
  "http://linksys.com/jnap/nodes/smartconnect/SmartConnect",
  "http://linksys.com/jnap/nodes/smartconnect/SmartConnect2",
  "http://linksys.com/jnap/nodes/smartconnect/SmartConnect3",
  "http://linksys.com/jnap/nodes/smartconnect/SmartConnect4",
  "http://linksys.com/jnap/nodes/smartmode/SmartMode",
  "http://linksys.com/jnap/nodes/smartmode/SmartMode2",
  "http://linksys.com/jnap/nodes/topologyoptimization/TopologyOptimization",
  "http://linksys.com/jnap/nodes/topologyoptimization/TopologyOptimization2",
  "http://linksys.com/jnap/ownednetwork/OwnedNetwork",
  "http://linksys.com/jnap/ownednetwork/OwnedNetwork2",
  "http://linksys.com/jnap/ownednetwork/OwnedNetwork3",
  "http://linksys.com/jnap/parentalcontrol/ParentalControl",
  "http://linksys.com/jnap/parentalcontrol/ParentalControl2",
  "http://linksys.com/jnap/pgui/PGUI",
  "http://linksys.com/jnap/powertable/PowerTable",
  "http://linksys.com/jnap/product/Product",
  "http://linksys.com/jnap/qos/QoS",
  "http://linksys.com/jnap/qos/QoS2",
  "http://linksys.com/jnap/qos/QoS3",
  "http://linksys.com/jnap/qos/calibration/Calibration",
  "http://linksys.com/jnap/router/Router",
  "http://linksys.com/jnap/router/Router10",
  "http://linksys.com/jnap/router/Router11",
  "http://linksys.com/jnap/router/Router12",
  "http://linksys.com/jnap/router/Router13",
  "http://linksys.com/jnap/router/Router3",
  "http://linksys.com/jnap/router/Router4",
  "http://linksys.com/jnap/router/Router5",
  "http://linksys.com/jnap/router/Router6",
  "http://linksys.com/jnap/router/Router7",
  "http://linksys.com/jnap/router/Router8",
  "http://linksys.com/jnap/router/Router9",
  "http://linksys.com/jnap/routerleds/RouterLEDs",
  "http://linksys.com/jnap/routerleds/RouterLEDs2",
  "http://linksys.com/jnap/routerleds/RouterLEDs3",
  "http://linksys.com/jnap/routerleds/RouterLEDs4",
  "http://linksys.com/jnap/routerlog/RouterLog",
  "http://linksys.com/jnap/routerlog/RouterLog2",
  "http://linksys.com/jnap/routermanagement/RouterManagement",
  "http://linksys.com/jnap/routermanagement/RouterManagement2",
  "http://linksys.com/jnap/routermanagement/RouterManagement3",
  "http://linksys.com/jnap/routerstatus/RouterStatus",
  "http://linksys.com/jnap/routerstatus/RouterStatus2",
  "http://linksys.com/jnap/routerupnp/RouterUPnP",
  "http://linksys.com/jnap/routerupnp/RouterUPnP2",
  "http://linksys.com/jnap/smartconnect/SmartConnectClient",
  "http://linksys.com/jnap/smartconnect/SmartConnectClient2",
  "http://linksys.com/jnap/ui/Settings",
  "http://linksys.com/jnap/ui/Settings2",
  "http://linksys.com/jnap/ui/Settings3",
  "http://linksys.com/jnap/wirelessap/AdvancedWirelessAP",
  "http://linksys.com/jnap/wirelessap/AdvancedWirelessAP2",
  "http://linksys.com/jnap/wirelessap/AirtimeFairness",
  "http://linksys.com/jnap/wirelessap/DynamicFrequencySelection",
  "http://linksys.com/jnap/wirelessap/MultiLinkOperation",
  "http://linksys.com/jnap/wirelessap/WPSServer",
  "http://linksys.com/jnap/wirelessap/WPSServer2",
  "http://linksys.com/jnap/wirelessap/WPSServer3",
  "http://linksys.com/jnap/wirelessap/WPSServer4",
  "http://linksys.com/jnap/wirelessap/WPSServer5",
  "http://linksys.com/jnap/wirelessap/WirelessAP",
  "http://linksys.com/jnap/wirelessap/WirelessAP2",
  "http://linksys.com/jnap/wirelessap/WirelessAP4",
  "http://linksys.com/jnap/wirelessap/WirelessAP5",
  "http://linksys.com/jnap/wirelessap/qualcomm/AdvancedQualcomm",
  "http://linksys.com/jnap/wirelessap/ssidprioritization/SSIDPrioritization",
  "http://linksys.com/jnap/wirelessscheduler/WirelessScheduler",
  "http://linksys.com/jnap/wirelessscheduler/WirelessScheduler2",
  "http://linksys.com/jnap/xconnect/XConnect",
];