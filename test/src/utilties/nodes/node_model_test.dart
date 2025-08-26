import 'package:test/test.dart';
import 'package:jnap/src/utilties/nodes/node_model.dart';

void main() {
  group('Node Model', () {
    group('treatAsModes', () {
      test('should return "WHW03" for "whw03"', () {
        expect(
            treatAsModes(modelNumber: 'whw03', hardwareVersion: '1'), 'WHW03');
      });
      test('should return null for "ea6350"', () {
        expect(treatAsModes(modelNumber: 'ea6350', hardwareVersion: '4'), null);
      });
    });

    group('baseModel', () {
      test('should return "WHW01" for "whw01b"', () {
        expect(baseModel(modelNumber: 'whw01b', hardwareVersion: '1'), 'WHW01');
      });
      test('should return "MR7350" for "mr7350"', () {
        expect(
            baseModel(modelNumber: 'mr7350', hardwareVersion: '1'), 'MR7350');
      });
    });

    group('seriesModel', () {
      test('should return "MR7300" for model starting with "mr73"', () {
        expect(
            seriesModel(modelNumber: 'mr7399', hardwareVersion: '1'), 'MR7300');
      });
      test('should return empty string when no series model is defined', () {
        expect(seriesModel(modelNumber: 'whw03', hardwareVersion: '1'), '');
      });
    });

    group('isNodeModel', () {
      test('should return true for "whw03"', () {
        expect(isNodeModel(modelNumber: 'whw03', hardwareVersion: '1'), isTrue);
      });
      test('should return false for "ea6350"', () {
        expect(
            isNodeModel(modelNumber: 'ea6350', hardwareVersion: '4'), isFalse);
      });
    });

    group('isMeshRouter', () {
      test('should return true for "mr7350"', () {
        expect(
            isMeshRouter(modelNumber: 'mr7350', hardwareVersion: '1'), isTrue);
      });
      test('should return false for "whw03"', () {
        expect(
            isMeshRouter(modelNumber: 'whw03', hardwareVersion: '1'), isFalse);
      });
    });

    group('isCognitiveMeshRouter', () {
      test('should return true for "mx6200"', () {
        expect(
            isCognitiveMeshRouter(modelNumber: 'mx6200', hardwareVersion: '1'),
            isTrue);
      });
      test('should return false for "whw03"', () {
        expect(isCognitiveMeshRouter(modelNumber: 'whw03', hardwareVersion: '1'),
            isFalse);
      });
    });

    group('isHorizontalPorts', () {
      test('should return true for "ln11"', () {
        expect(isHorizontalPorts(modelNumber: 'ln11', hardwareVersion: '1'),
            isTrue);
      });
      test('should return false for "whw03"', () {
        expect(isHorizontalPorts(modelNumber: 'whw03', hardwareVersion: '1'),
            isFalse);
      });
    });

    group('isHidingRipRouting', () {
      test('should return true for "spnm60"', () {
        expect(isHidingRipRouting(modelNumber: 'spnm60', hardwareVersion: '1'),
            isTrue);
      });
      test('should return false for "whw03"', () {
        expect(isHidingRipRouting(modelNumber: 'whw03', hardwareVersion: '1'),
            isFalse);
      });
    });
  });
}