import 'package:flutter_app_environment/src/environment_env_file_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EnvironmentEnvFileParser', () {
    test('should parse simple key-value pairs', () {
      const content = 'KEY1=VALUE1\nKEY2=VALUE2';
      final result = EnvironmentEnvFileParser.parse(content);

      expect(result['KEY1'], 'VALUE1');
      expect(result['KEY2'], 'VALUE2');
    });

    test('should trim keys and values', () {
      const content = '  KEY  =  VALUE  ';
      final result = EnvironmentEnvFileParser.parse(content);
      expect(result['KEY'], 'VALUE');
    });

    test('should handle empty values', () {
      const content = 'EMPTY=';
      final result = EnvironmentEnvFileParser.parse(content);
      expect(result['EMPTY'], '');
    });

    test('should handle special characters inside quotes', () {
      const content = '''
HASH_IN_QUOTE="value # 1"
EQUALS_IN_QUOTE='value=2'
''';
      final result = EnvironmentEnvFileParser.parse(content);
      expect(result['HASH_IN_QUOTE'], 'value # 1');
      expect(result['EQUALS_IN_QUOTE'], 'value=2');
    });

    test('should handle comments starting with #', () {
      const content = '''
# Full line comment
KEY1=VALUE1
  # Indented comment
KEY2=VALUE2
''';
      final result = EnvironmentEnvFileParser.parse(content);

      expect(result['KEY1'], 'VALUE1');
      expect(result['KEY2'], 'VALUE2');
      expect(result.length, 2);
    });

    test('should handle trailing comments', () {
      const content = 'KEY1=VALUE1 # trailing comment';
      final result = EnvironmentEnvFileParser.parse(content);

      expect(result['KEY1'], 'VALUE1');
    });

    test('should handle quoted values', () {
      const content = '''
SINGLE_QUOTED='Value with spaces'
DOUBLE_QUOTED="Another value"
UNQUOTED=NoQuotes
''';
      final result = EnvironmentEnvFileParser.parse(content);

      expect(result['SINGLE_QUOTED'], 'Value with spaces');
      expect(result['DOUBLE_QUOTED'], 'Another value');
      expect(result['UNQUOTED'], 'NoQuotes');
    });

    test('should infer basic types', () {
      const content = '''
INT_VAL=123
DOUBLE_VAL=123.45
BOOL_TRUE=true
BOOL_FALSE=false
STRING_VAL=hello
''';
      final result = EnvironmentEnvFileParser.parse(content);

      expect(result['INT_VAL'], 123);
      expect(result['DOUBLE_VAL'], 123.45);
      expect(result['BOOL_TRUE'], true);
      expect(result['BOOL_FALSE'], false);
      expect(result['STRING_VAL'], 'hello');
    });

    test('should handle export keyword', () {
      const content = 'export KEY1=VALUE1';
      final result = EnvironmentEnvFileParser.parse(content);

      expect(result['KEY1'], 'VALUE1');
    });

    test('should handle multiple equals signs in values', () {
      const content = 'KEY1=VALUE1=VALUE2';
      final result = EnvironmentEnvFileParser.parse(content);

      expect(result['KEY1'], 'VALUE1=VALUE2');
    });

    test('should ignore lines without equals sign', () {
      const content = 'INVALID_LINE';
      final result = EnvironmentEnvFileParser.parse(content);

      expect(result, isEmpty);
    });

    test('should handle empty lines', () {
      const content = '\n\nKEY1=VALUE1\n\n';
      final result = EnvironmentEnvFileParser.parse(content);

      expect(result['KEY1'], 'VALUE1');
      expect(result.length, 1);
    });
  });
}
