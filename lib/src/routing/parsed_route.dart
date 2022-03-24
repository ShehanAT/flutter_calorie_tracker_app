
import 'package:collection/collection.dart';
import 'package:quiver/core.dart';

import 'parser.dart';

// A route path that has been parsed by [TemplateRouteParser]
class ParsedRoute {
  // The current path location without query parameters
  final String path;

  // The path template(/book/:id)
  final String pathTemplate;

  // The path parameters({ id: 123 })
  final Map<String, String> parameters;

  // The query parameters({ search: abc })
  final Map<String, String> queryParameters;

  static const _mapEquality = MapEquality<String, String>();

  ParsedRoute(
      this.path, this.pathTemplate, this.parameters, this.queryParameters
      );

}