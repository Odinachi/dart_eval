import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/stdlib/core.dart';

/// dart_eval bridge wrapper for [num]
class $num<T extends num> implements $Instance {
  /// Wrap a [num] in a [$num].
  $num(this.$value) : _superclass = $Object($value);

  static const $declaration = BridgeClassDef(
      BridgeClassType(BridgeTypeRef(CoreTypes.num), isAbstract: true),
      constructors: {},
      methods: {
        // Other num methods are defined in builtins.dart
        // since they have special requirements (return types dependent on
        // argument types, etc.)
        'parse': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.num)),
                params: [
                  BridgeParameter(
                      'source',
                      BridgeTypeAnnotation(
                          BridgeTypeRef.type(RuntimeTypes.stringType)),
                      false),
                  BridgeParameter(
                      'onError',
                      BridgeTypeAnnotation(
                          BridgeTypeRef.type(RuntimeTypes.functionType),
                          nullable: true),
                      true),
                ],
                namedParams: []),
            isStatic: true),
        'tryParse': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.num),
                    nullable: true),
                params: [
                  BridgeParameter(
                      'source',
                      BridgeTypeAnnotation(
                          BridgeTypeRef.type(RuntimeTypes.stringType)),
                      false),
                ],
                namedParams: []),
            isStatic: true),
      },
      getters: {},
      setters: {},
      fields: {},
      wrap: true);

  @override
  T $value;

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case '+':
        return __plus;
      case '-':
        return __minus;
      case '*':
        return __mul;
      case '/':
        return __div;
      case '%':
        return __mod;
      case '<':
        return __lt;
      case '>':
        return __gt;
      case '<=':
        return __lteq;
      case '>=':
        return __gteq;
      case 'compareTo':
        return __compareTo;
    }
    return _superclass.$getProperty(runtime, identifier);
  }

  @override
  void $setProperty(Runtime runtime, String identifier, $Value value) {
    return _superclass.$setProperty(runtime, identifier, value);
  }

  final $Instance _superclass;

  @override
  T get $reified => $value;

  static const $Function __plus = $Function(_plus);
  static $Value? _plus(Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value + other!.$value;

    if (_evalResult is int) {
      return $int(_evalResult);
    }

    if (_evalResult is double) {
      return $double(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __minus = $Function(_minus);
  static $Value? _minus(Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value - other!.$value;

    if (_evalResult is int) {
      return $int(_evalResult);
    }

    if (_evalResult is double) {
      return $double(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __mul = $Function(_mul);
  static $Value? _mul(Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value * other!.$value;

    if (_evalResult is int) {
      return $int(_evalResult);
    }

    if (_evalResult is double) {
      return $double(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __div = $Function(_div);
  static $Value? _div(Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value / other!.$value;

    if (_evalResult is double) {
      return $double(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __mod = $Function(_mod);

  static $Value? _mod(Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value % other!.$value;

    if (_evalResult is int) {
      return $int(_evalResult);
    }

    if (_evalResult is double) {
      return $double(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __lt = $Function(_lt);
  static $Value? _lt(Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value < other!.$value;

    if (_evalResult is bool) {
      return $bool(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __gt = $Function(_gt);
  static $Value? _gt(Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value > other!.$value;

    if (_evalResult is bool) {
      return $bool(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __lteq = $Function(_lteq);
  static $Value? _lteq(Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value <= other!.$value;

    if (_evalResult is bool) {
      return $bool(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __gteq = $Function(_gteq);
  static $Value? _gteq(Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value >= other!.$value;

    if (_evalResult is bool) {
      return $bool(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __compareTo = $Function(_compareTo);
  static $Value? _compareTo(
      Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value.compareTo(other!.$value);

    return $int(_evalResult);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is $num &&
          runtimeType == other.runtimeType &&
          $value == other.$value;

  @override
  int get hashCode => $value.hashCode;

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType(CoreTypes.num);
}

/// dart_eval wrapper for [int]
class $int extends $num<int> {
  /// Wrap an [int] in a [$int].
  $int(int $value) : super($value);

  static const $declaration = BridgeClassDef(
      BridgeClassType(BridgeTypeRef(CoreTypes.int),
          $extends: BridgeTypeRef(CoreTypes.num), isAbstract: true),
      constructors: {},
      methods: {
        'parse': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int)),
                params: [
                  BridgeParameter(
                      'source',
                      BridgeTypeAnnotation(
                          BridgeTypeRef.type(RuntimeTypes.stringType)),
                      false),
                  BridgeParameter(
                      'onError',
                      BridgeTypeAnnotation(
                          BridgeTypeRef.type(RuntimeTypes.functionType),
                          nullable: true),
                      true),
                ],
                namedParams: []),
            isStatic: true),
        'tryParse': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.int),
                    nullable: true),
                params: [
                  BridgeParameter(
                      'source',
                      BridgeTypeAnnotation(
                          BridgeTypeRef.type(RuntimeTypes.stringType)),
                      false),
                ],
                namedParams: []),
            isStatic: true),
      },
      getters: {},
      setters: {},
      fields: {},
      wrap: true);

  @override
  int get $reified => $value;

  @override
  String toString() {
    return $value.toString();
  }

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType(CoreTypes.int);

  @override
  $Value? $getProperty(Runtime runtime, String identifier) {
    switch (identifier) {
      case '|':
        return __bitwiseOr;
      case '&':
        return __bitwiseAnd;
      case '<<':
        return __shiftLeft;
      case '>>':
        return __shiftRight;
      case '^':
        return __bitwiseXor;
    }
    return super.$getProperty(runtime, identifier);
  }

  static const $Function __bitwiseOr = $Function(_bitwiseOr);
  static $Value? _bitwiseOr(
      Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value | other!.$value;

    if (_evalResult is int) {
      return $int(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __bitwiseAnd = $Function(_bitwiseAnd);
  static $Value? _bitwiseAnd(
      Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value & other!.$value;

    if (_evalResult is int) {
      return $int(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __shiftLeft = $Function(_shiftLeft);
  static $Value? _shiftLeft(
      Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value << other!.$value;

    if (_evalResult is int) {
      return $int(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __shiftRight = $Function(_shiftRight);
  static $Value? _shiftRight(
      Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value >> other!.$value;

    if (_evalResult is int) {
      return $int(_evalResult);
    }

    throw UnimplementedError();
  }

  static const $Function __bitwiseXor = $Function(_bitwiseXor);

  static $Value? _bitwiseXor(
      Runtime runtime, $Value? target, List<$Value?> args) {
    final other = args[0];
    final _evalResult = target!.$value ^ other!.$value;

    if (_evalResult is int) {
      return $int(_evalResult);
    }

    throw UnimplementedError();
  }
}

/// dart_eval wrapper for [double]
class $double extends $num<double> {
  /// Wrap a [double] in a [$double].
  $double(double $value) : super($value);

  static const $declaration = BridgeClassDef(
      BridgeClassType(BridgeTypeRef(CoreTypes.double),
          $extends: BridgeTypeRef(CoreTypes.num), isAbstract: true),
      constructors: {},
      methods: {
        'parse': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.double)),
                params: [
                  BridgeParameter(
                      'source',
                      BridgeTypeAnnotation(
                          BridgeTypeRef.type(RuntimeTypes.stringType)),
                      false),
                  BridgeParameter(
                      'onError',
                      BridgeTypeAnnotation(
                          BridgeTypeRef.type(RuntimeTypes.functionType),
                          nullable: true),
                      true),
                ],
                namedParams: []),
            isStatic: true),
        'tryParse': BridgeMethodDef(
            BridgeFunctionDef(
                returns: BridgeTypeAnnotation(BridgeTypeRef(CoreTypes.double),
                    nullable: true),
                params: [
                  BridgeParameter(
                      'source',
                      BridgeTypeAnnotation(
                          BridgeTypeRef.type(RuntimeTypes.stringType)),
                      false),
                ],
                namedParams: []),
            isStatic: true),
      },
      getters: {},
      setters: {},
      fields: {},
      wrap: true);

  @override
  double get $reified => $value;

  @override
  int $getRuntimeType(Runtime runtime) => runtime.lookupType(CoreTypes.double);
}
