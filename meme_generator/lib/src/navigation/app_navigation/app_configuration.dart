final class AppConfiguration {
  AppConfiguration({
    this.isTransition = false,
  });

  factory AppConfiguration.fromUri(Uri uri) {
    // final params = uri.queryParameters;

    if (uri.pathSegments.isEmpty) {
      return AppConfiguration();
    } else if (uri.pathSegments.length == 1 &&
        uri.pathSegments[0] == transition) {
      return AppConfiguration(isTransition: true);
    }

    return AppConfiguration();
  }

  static const String transition = 'transition';

  bool isTransition;

  Uri toUri() {
    String location = '';

    if (isTransition) location += addPathSegment(transition);

    return Uri.parse(location);
  }

  @override
  String toString() => 'AppConfiguration{isTransition: $isTransition}';
}

void tryParseQueryParam(Map<String, String> params, String key, void Function(String) setter) {
    if (params.containsKey(key)) setter(params[key] ?? '');
  }

  String addQueryParam(String key, String? value) {
    if (value == null) return '';

    return '$key=$value&';
  }

  String addPathSegment(String segment) => '/$segment';