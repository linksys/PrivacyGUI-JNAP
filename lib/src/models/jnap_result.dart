import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:jnap/src/consts.dart';
import 'package:jnap/jnap.dart';

abstract class JNAPResult extends Equatable {
  final String result;

  const JNAPResult({
    required this.result,
  });

  factory JNAPResult.fromMap(Map<String, dynamic> map) {
    if (map[keyJnapResult] == jnapResultOk) {
      return map.containsKey(keyJnapResponses)
          ? JNAPTransactionSuccess.fromMap(map)
          : JNAPSuccess.fromMap(map);
    }
    return JNAPError.fromMap(map);
  }

  Map<String, dynamic> toMap() {
    return {
      keyJnapResult: result,
    };
  }

  factory JNAPResult.fromJson(String json) {
    return JNAPResult.fromMap(jsonDecode(json));
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  @override
  List<Object?> get props => [result];
}

class JNAPSuccess extends JNAPResult with SideEffectGetter {
  final Map<String, dynamic> output;
  final List<String>? sideEffects;

  const JNAPSuccess({
    required super.result,
    this.output = const {},
    this.sideEffects,
  });

  factory JNAPSuccess.fromMap(Map<String, dynamic> map) {
    return JNAPSuccess(
      result: map[keyJnapResult],
      output: map[keyJnapOutput] ?? {},
      sideEffects: map.containsKey(keyJnapSideEffects)
          ? List.from(map[keyJnapSideEffects])
          : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        keyJnapOutput: output,
        keyJnapSideEffects: sideEffects,
      })
      ..removeWhere((key, value) => value == null);
  }

  factory JNAPSuccess.fromJson(String json) {
    return JNAPSuccess.fromMap(jsonDecode(json));
  }

  @override
  List<Object?> get props => super.props
    ..add(output)
    ..add(sideEffects);
}

class JNAPTransactionSuccess extends JNAPResult with SideEffectGetter {
  final List<JNAPSuccess> responses;
  final List<String>? sideEffects;

  const JNAPTransactionSuccess({
    required super.result,
    required this.responses,
    this.sideEffects,
  });

  factory JNAPTransactionSuccess.fromMap(Map<String, dynamic> map) {
    return JNAPTransactionSuccess(
      result: map[keyJnapResult],
      responses: List.from(map[keyJnapResponses])
          .map((e) => JNAPSuccess.fromMap(e))
          .toList(),
      sideEffects: map.containsKey(keyJnapSideEffects)
          ? List.from(map[keyJnapSideEffects])
          : null,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      keyJnapResult: result,
      keyJnapResponses: responses,
      keyJnapSideEffects: sideEffects
    }..removeWhere((key, value) => value == null);
  }

  factory JNAPTransactionSuccess.fromJson(String json) {
    return JNAPTransactionSuccess.fromMap(jsonDecode(json));
  }

  @override
  List<Object?> get props => super.props
    ..add(responses)
    ..add(sideEffects);
}

class JNAPTransactionSuccessWrap extends JNAPResult with SideEffectGetter {
  final List<String> sideEffects;
  final List<MapEntry<JNAPAction, JNAPResult>> data;

  const JNAPTransactionSuccessWrap({
    required super.result,
    this.data = const [],
    this.sideEffects = const [],
  });

  factory JNAPTransactionSuccessWrap.convert({
    required List<JNAPAction> actions,
    required JNAPTransactionSuccess transactionSuccess,
  }) {
    return JNAPTransactionSuccessWrap(
      result: transactionSuccess.result,
      sideEffects: transactionSuccess.getSideEffects() ?? [],
      data: actions
          .mapIndexed((index, action) =>
              MapEntry(action, transactionSuccess.responses[index]))
          .toList(),
    );
  }

  static JNAPSuccess? getResult(
      JNAPAction action, Map<JNAPAction, JNAPResult> results) {
    if (!results.containsKey(action)) {
      return null;
    }
    return results[action] as JNAPSuccess?;
  }

  @override
  List<Object?> get props => super.props..add(data);
}

class JNAPError extends JNAPResult {
  final String? error;

  const JNAPError({
    required super.result,
    this.error,
  });

  factory JNAPError.fromMap(Map<String, dynamic> map) {
    // Check if it's a transaction jnap
    if (map.containsKey(keyJnapResponses)) {
      final responses = map[keyJnapResponses] as List;
      // Get the first error result that occurs in the transaction
      for (final response in responses) {
        if (response[keyJnapResult] != jnapResultOk) {
          return JNAPError(
            result: response[keyJnapResult],
            error:
                response[keyJnapError] ?? jsonEncode(response[keyJnapOutput]),
          );
        }
      }
      return const JNAPError(
        result: jnapResultError,
        error: jnapResultError,
      );
    }
    // Otherwise, it's a general jnap
    return JNAPError(
      result: map[keyJnapResult],
      error: map[keyJnapError] ?? jsonEncode(map[keyJnapOutput]),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        keyJnapError: error,
      })
      ..removeWhere((key, value) => value == null);
  }

  factory JNAPError.fromJson(String json) {
    return JNAPError.fromMap(jsonDecode(json));
  }

  @override
  List<Object?> get props => super.props..add(error);
}

mixin SideEffectGetter {
  List<String>? getSideEffects() {
    if (this is JNAPSuccess) {
      return (this as JNAPSuccess).sideEffects;
    } else if (this is JNAPTransactionSuccess) {
      return (this as JNAPTransactionSuccess).sideEffects;
    } else if (this is JNAPTransactionSuccessWrap) {
      final trans = this as JNAPTransactionSuccessWrap;
      // return trans.data
      //     .map((e) => e.value as JNAPSuccess?)
      //     .whereType<JNAPSuccess>()
      //     .fold<List<String>>([], (previousValue, element) {
      //   if (element.sideEffects != null) {
      //     previousValue.addAll(element.sideEffects!);
      //   }
      //   return previousValue;
      // }).toList();
      return trans.sideEffects;
    } else {
      return null;
    }
  }
}
