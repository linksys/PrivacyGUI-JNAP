import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Jsonable extends Equatable {
  const Jsonable();

  Map<String, dynamic> toMap();

  factory Jsonable.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError('fromMap must be implemented by subclasses');
  }

  String toJson() => jsonEncode(toMap());

  factory Jsonable.fromJson(String json) {
    throw UnimplementedError('fromMap must be implemented by subclasses');
  }

  /// Creates a new instance of the class with the given fields replaced by the non-null values
  /// from the provided map. This is an abstract method that must be implemented by subclasses.
  /// For optional fields, use ValueGetter<T>? instead of T?.
  ///
  /// Example implementation in a subclass:
  /// ```dart
  /// @override
  /// MyClass copyWith({
  ///   String? field1,
  ///   int? field2,
  /// }) {
  ///   return MyClass(
  ///     field1: field1 ?? this.field1,
  ///     field2: field2 ?? this.field2,
  ///   );
  /// }
  /// ```
  Jsonable copyWith();

  @override
  bool? get stringify => true;
}
