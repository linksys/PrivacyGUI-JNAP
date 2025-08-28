import 'package:jnap/src/utilties/unit.dart';
import 'package:test/test.dart';

void main() {
  group('UnitUtils', () {
    group('formatBytes', () {
      test('should format bytes correctly for B', () {
        expect(UnitUtils.formatBytes(0), '0 B');
        expect(UnitUtils.formatBytes(100), '100 B');
      });

      test('should format bytes correctly for Kb', () {
        expect(UnitUtils.formatBytes(1024), '1 Kb');
        expect(UnitUtils.formatBytes(1536, decimals: 1), '1.5 Kb');
      });

      test('should format bytes correctly for Mb', () {
        expect(UnitUtils.formatBytes(1024 * 1024), '1 Mb');
        expect(UnitUtils.formatBytes(1024 * 1024 * 2, decimals: 2), '2.00 Mb');
      });

      test('should handle large numbers', () {
        expect(UnitUtils.formatBytes(1024 * 1024 * 1024 * 1024 * 1024), '1 Pb');
      });
    });

    group('formatBytesWithUnit', () {
      test('should return correct value and unit for B', () {
        expect(UnitUtils.formatBytesWithUnit(0), (value: '0', unit: 'B'));
        expect(UnitUtils.formatBytesWithUnit(500), (value: '500', unit: 'B'));
      });

      test('should return correct value and unit for Kb', () {
        expect(UnitUtils.formatBytesWithUnit(1024), (value: '1', unit: 'Kb'));
        expect(UnitUtils.formatBytesWithUnit(2048, decimals: 0),
            (value: '2', unit: 'Kb'));
        expect(UnitUtils.formatBytesWithUnit(1536, decimals: 1),
            (value: '1.5', unit: 'Kb'));
      });

      test('should return correct value and unit for Mb', () {
        expect(UnitUtils.formatBytesWithUnit(1024 * 1024),
            (value: '1', unit: 'Mb'));
      });
    });
  });
}
