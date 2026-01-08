/// A parser for .env files, providing functionality to convert .env file content
/// into a Map of key-value pairs with basic type inference.
class EnvironmentEnvFileParser {
  static final _comment = RegExp(r'''#[^'"]*$''');
  static final _surroundQuotes = RegExp(r'''^(["'])(.*?[^\\])\1''');
  static final _leadingExport = RegExp('^ *export ?');

  /// Parses the [content] of a .env file into a [Map<String, dynamic>].
  ///
  /// This parser handles:
  /// - Comments starting with #
  /// - Leading 'export' keyword
  /// - Quoted values (single and double quotes)
  /// - Basic type inference (int, double, bool)
  static Map<String, dynamic> parse(String content) {
    final result = <String, dynamic>{};
    final lines = content.split('\n');

    for (final line in lines) {
      final trimmedLine = line.trim();
      if (trimmedLine.isEmpty || trimmedLine.startsWith('#')) {
        continue;
      }

      final lineWithoutComments = _removeCommentsFromLine(trimmedLine);
      if (!lineWithoutComments.contains('=')) {
        continue;
      }

      final indexOfEquals = lineWithoutComments.indexOf('=');
      final rawKey = lineWithoutComments.substring(0, indexOfEquals);
      final key = _trimExportKeyword(rawKey);

      if (key.isEmpty) {
        continue;
      }

      final rawValue = lineWithoutComments.substring(indexOfEquals + 1).trim();
      final valueWithoutQuotes = _removeSurroundingQuotes(rawValue);

      result[key] = _convertValue(valueWithoutQuotes);
    }

    return result;
  }

  static String _removeCommentsFromLine(String line) =>
      line.replaceAll(_comment, '').trim();

  static String _trimExportKeyword(String line) =>
      line.replaceAll(_leadingExport, '').trim();

  static String _removeSurroundingQuotes(String val) {
    if (!_surroundQuotes.hasMatch(val)) {
      return val;
    }
    return _surroundQuotes.firstMatch(val)!.group(2)!;
  }

  static dynamic _convertValue(String value) {
    if (value.toLowerCase() == 'true') {
      return true;
    }
    if (value.toLowerCase() == 'false') {
      return false;
    }

    final intValue = int.tryParse(value);
    if (intValue != null) {
      return intValue;
    }

    final doubleValue = double.tryParse(value);
    if (doubleValue != null) {
      return doubleValue;
    }

    return value;
  }
}
