import 'dart:math';

class UnitUtils {
  static String formatBytes(int bytes, {int decimals = 0}) {
    final result = formatBytesWithUnit(bytes, decimals: decimals);
    return '${result.value} ${result.unit}';
  }

  static ({String value, String unit}) formatBytesWithUnit(int bytes,
      {int decimals = 0}) {
    if (bytes <= 0) return (value: '0', unit: "B");
    const suffixes = ["B", "Kb", "Mb", "Gb", "Tb", "Pb"];
    var i = (log(bytes) / log(1024)).floor();
    var number = (bytes / pow(1024, i));
    return (
      value: number.toStringAsFixed(decimals),
      unit: suffixes[i]
    );
  }
}