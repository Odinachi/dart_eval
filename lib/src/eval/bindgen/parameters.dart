import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_eval/src/eval/bindgen/context.dart';
import 'package:dart_eval/src/eval/bindgen/type.dart';

String namedParameters(BindgenContext ctx,
    {required ExecutableElement element}) {
  final params = element.parameters.where((e) => e.isNamed);
  if (params.isEmpty) {
    return '';
  }

  return parameters(ctx, params.toList());
}

String positionalParameters(BindgenContext ctx,
    {required ExecutableElement element}) {
  final params = element.parameters.where((e) => e.isPositional);
  if (params.isEmpty) {
    return '';
  }

  return parameters(ctx, params.toList());
}

String parameters(BindgenContext ctx, List<ParameterElement> params) {
  return List.generate(
      params.length, (index) => _parameterFrom(ctx, params[index])).join('\n');
}

String _parameterFrom(BindgenContext ctx, ParameterElement parameter) {
  return '''
    BridgeParameter(
      '${parameter.name}',
      ${bridgeTypeAnnotationFrom(ctx, parameter.type)},
      ${parameter.isOptional ? 'true' : 'false'},
    ),
  ''';
}

String argumentAccessors(BindgenContext ctx, List<ParameterElement> params,
    {Map<String, String> paramMapping = const {}}) {
  final paramBuffer = StringBuffer();
  for (var i = 0; i < params.length; i++) {
    final param = params[i];
    if (param.isNamed) {
      paramBuffer.write('${paramMapping[param.name] ?? param.name}: ');
    }
    final type = param.type;
    if (type.isDartCoreFunction || type is FunctionType) {
      paramBuffer.write('(');
      if (type is FunctionType) {
        for (var j = 0; j < type.normalParameterTypes.length; j++) {
          var _name = type.normalParameterNames[j];
          if (_name.isEmpty) {
            _name = 'v$j';
          }
          paramBuffer.write(_name);
          if (j < type.normalParameterTypes.length - 1) {
            paramBuffer.write(', ');
          }
        }

        if (type.optionalParameterNames.isNotEmpty) {
          if (type.normalParameterTypes.isNotEmpty) {
            paramBuffer.write(', ');
          }
          paramBuffer.write('[');

          for (var j = 0; j < type.optionalParameterNames.length; j++) {
            final _name = type.optionalParameterNames[i];
            paramBuffer.write(_name);
            if (j < type.optionalParameterNames.length - 1) {
              paramBuffer.write(', ');
            }
          }
          paramBuffer.write(']');
        }

        if (type.namedParameterTypes.isNotEmpty) {
          if (type.normalParameterTypes.isNotEmpty ||
              type.optionalParameterNames.isNotEmpty) {
            paramBuffer.write(', ');
          }
          paramBuffer.write('{');

          var k = 0;
          type.namedParameterTypes.forEach((_name, _type) {
            paramBuffer.write(_name);
            if (k < type.namedParameterTypes.length - 1) {
              paramBuffer.write(', ');
            }
          });
          paramBuffer.write('}');
        }
      }
      paramBuffer.write(') {\n');
      paramBuffer.write('return (args[$i] as EvalCallable)(runtime, null, [');
      if (type is FunctionType) {
        for (var j = 0; j < type.normalParameterTypes.length; j++) {
          var _name = type.normalParameterNames[j];
          if (_name.isEmpty) {
            _name = 'v$j';
          }
          paramBuffer.write(wrapVar(ctx, type.normalParameterTypes[i], _name));
          if (j < type.normalParameterTypes.length - 1) {
            paramBuffer.write(', ');
          }
        }

        if (type.optionalParameterNames.isNotEmpty) {
          if (type.normalParameterTypes.isNotEmpty) {
            paramBuffer.write(', ');
          }

          for (var j = 0; j < type.optionalParameterNames.length; j++) {
            final _name = type.optionalParameterNames[i];
            paramBuffer
                .write(wrapVar(ctx, type.optionalParameterTypes[i], _name));
            if (j < type.optionalParameterNames.length - 1) {
              paramBuffer.write(', ');
            }
          }
        }

        if (type.namedParameterTypes.isNotEmpty) {
          if (type.normalParameterTypes.isNotEmpty ||
              type.optionalParameterNames.isNotEmpty) {
            paramBuffer.write(', ');
          }

          var k = 0;
          type.namedParameterTypes.forEach((_name, _type) {
            paramBuffer.write(wrapVar(ctx, _type, _name));
            if (k < type.namedParameterTypes.length - 1) {
              paramBuffer.write(', ');
            }
          });
        }
      }
      paramBuffer.write('])?.\$value;\n}');
    } else {
      final needsCast =
          type.isDartCoreList || type.isDartCoreMap || type.isDartCoreSet;
      if (needsCast) {
        paramBuffer.write('(');
      }
      paramBuffer.write('args[$i]');
      final accessor = needsCast ? 'reified' : 'value';
      if (param.isRequired) {
        paramBuffer.write('!.\$$accessor');
      } else {
        paramBuffer.write('?.\$$accessor');
        if (param.hasDefaultValue) {
          paramBuffer.write(' ?? ${param.defaultValueCode}');
        }
      }
      if (needsCast) {
        final q = (param.isRequired ? '' : '?');
        paramBuffer.write(' as ${type.element!.name}$q');
        paramBuffer.write(')$q.cast()');
      }
    }

    if (i < params.length - 1) {
      paramBuffer.write(', ');
    }
  }
  return paramBuffer.toString();
}
