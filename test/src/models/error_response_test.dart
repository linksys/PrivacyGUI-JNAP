import 'dart:async';
import 'dart:convert';

import 'package:test/test.dart';
import 'package:jnap/src/models/error_response.dart';

void main() {
  group('ErrorResponse', () {
    test('constructor creates an instance with given values', () {
      const errorResponse = ErrorResponse(status: 200, code: 'SUCCESS', errorMessage: 'Operation successful', parameters: []);
      expect(errorResponse.status, 200);
      expect(errorResponse.code, 'SUCCESS');
      expect(errorResponse.errorMessage, 'Operation successful');
      expect(errorResponse.parameters, []);
    });

    group('convert factory', () {
      test('converts TimeoutException to REQUEST_TIMEOUT error', () {
        final errorResponse = ErrorResponse.convert(TimeoutException('Request timed out'));
        expect(errorResponse.status, 1000);
        expect(errorResponse.code, 'REQUEST_TIMEOUT');
        expect(errorResponse.errorMessage, isNull);
        expect(errorResponse.parameters, isNull);
      });

      test('converts other exceptions to UNKNOWN_ERROR', () {
        final errorResponse = ErrorResponse.convert(Exception('Some other error'));
        expect(errorResponse.status, -1);
        expect(errorResponse.code, 'UNKNOWN_ERROR');
        expect(errorResponse.errorMessage, isNull);
        expect(errorResponse.parameters, isNull);
      });
    });

    group('fromJson factory', () {
      test('parses JSON with errors array correctly', () {
        final json = {
          'errors': [
            {
              'error': {
                'code': 'INVALID_INPUT',
                'message': 'Invalid data provided',
                'parameters': [{'field': 'name'}]
              }
            }
          ]
        };
        final errorResponse = ErrorResponse.fromJson(400, json);
        expect(errorResponse.status, 400);
        expect(errorResponse.code, 'INVALID_INPUT');
        expect(errorResponse.errorMessage, 'Invalid data provided');
        expect(errorResponse.parameters, [{'field': 'name'}]);
      });

      test('parses JSON with code and errorMessage directly correctly', () {
        final json = {'code': 'AUTH_FAILED', 'errorMessage': 'Authentication failed'};
        final errorResponse = ErrorResponse.fromJson(401, json);
        expect(errorResponse.status, 401);
        expect(errorResponse.code, 'AUTH_FAILED');
        expect(errorResponse.errorMessage, 'Authentication failed');
        expect(errorResponse.parameters, isNull);
      });

      test('parses JSON with error and error_description correctly', () {
        final json = {'error': 'SERVER_ERROR', 'error_description': 'Internal server error', 'parameters': []};
        final errorResponse = ErrorResponse.fromJson(500, json);
        expect(errorResponse.status, 500);
        expect(errorResponse.code, 'SERVER_ERROR');
        expect(errorResponse.errorMessage, 'Internal server error');
        expect(errorResponse.parameters, []);
      });
    });

    test('toJson converts instance to JSON correctly', () {
      const errorResponse = ErrorResponse(status: 200, code: 'SUCCESS', errorMessage: 'Operation successful', parameters: []);
      final json = errorResponse.toJson();
      expect(json, {'code': 'SUCCESS', 'errorMessage': 'Operation successful', 'parameters': []});
    });

    test('props are correct for Equatable', () {
      const error1 = ErrorResponse(status: 200, code: 'CODE1');
      const error2 = ErrorResponse(status: 200, code: 'CODE1');
      const error3 = ErrorResponse(status: 400, code: 'CODE2');

      expect(error1, error2);
      expect(error1.hashCode, error2.hashCode);
      expect(error1, isNot(error3));
      expect(error1.hashCode, isNot(error3.hashCode));
    });
  });

  group('ErrorMfaRequired', () {
    const mfaRequired = ErrorMfaRequired(
      code: 'MFA_REQUIRED',
      errorMessage: 'MFA is required',
      verificationToken: 'some_token',
    );

    test('constructor creates an instance with given values', () {
      expect(mfaRequired.code, 'MFA_REQUIRED');
      expect(mfaRequired.errorMessage, 'MFA is required');
      expect(mfaRequired.verificationToken, 'some_token');
    });

    test('fromMap factory creates instance from map', () {
      final map = {
        'code': 'MFA_REQUIRED',
        'errorMessage': 'MFA is required',
        'verificationToken': 'some_token',
      };
      final instance = ErrorMfaRequired.fromMap(map);
      expect(instance, mfaRequired);
    });

    test('fromJson factory creates instance from JSON string', () {
      final jsonString = '{"code":"MFA_REQUIRED","errorMessage":"MFA is required","verificationToken":"some_token"}';
      final instance = ErrorMfaRequired.fromJson(jsonString);
      expect(instance, mfaRequired);
    });

    test('fromResponse factory creates instance from ErrorResponse', () {
      const errorResponseWithToken = ErrorResponse(
        status: 400,
        code: 'MFA_REQUIRED',
        errorMessage: 'MFA is required',
        parameters: [
          {'parameter': {'name': 'verificationToken', 'value': 'response_token'}}
        ],
      );
      final instance = ErrorMfaRequired.fromResponse(errorResponseWithToken);
      expect(instance.code, 'MFA_REQUIRED');
      expect(instance.errorMessage, 'MFA is required');
      expect(instance.verificationToken, 'response_token');

      const errorResponseWithoutToken = ErrorResponse(
        status: 400,
        code: 'MFA_REQUIRED',
        errorMessage: 'MFA is required',
        parameters: [],
      );
      final instanceWithoutToken = ErrorMfaRequired.fromResponse(errorResponseWithoutToken);
      expect(instanceWithoutToken.verificationToken, '');
    });

    test('toMap converts instance to map', () {
      final map = mfaRequired.toMap();
      expect(map, {
        'code': 'MFA_REQUIRED',
        'errorMessage': 'MFA is required',
        'verificationToken': 'some_token',
      });
    });

    test('toJson converts instance to JSON string', () {
      final jsonString = mfaRequired.toJson();
      expect(jsonString, '{"code":"MFA_REQUIRED","errorMessage":"MFA is required","verificationToken":"some_token"}');
    });

    test('copyWith creates a new instance with updated values', () {
      final updated = mfaRequired.copyWith(errorMessage: 'New message');
      expect(updated.errorMessage, 'New message');
      expect(updated.code, mfaRequired.code);
      expect(updated.verificationToken, mfaRequired.verificationToken);
    });

    test('props are correct for Equatable', () {
      const mfa1 = ErrorMfaRequired(code: 'C1', errorMessage: 'M1', verificationToken: 'T1');
      const mfa2 = ErrorMfaRequired(code: 'C1', errorMessage: 'M1', verificationToken: 'T1');
      const mfa3 = ErrorMfaRequired(code: 'C2', errorMessage: 'M2', verificationToken: 'T2');

      expect(mfa1, mfa2);
      expect(mfa1.hashCode, mfa2.hashCode);
      expect(mfa1, isNot(mfa3));
      expect(mfa1.hashCode, isNot(mfa3.hashCode));
    });
  });
}
