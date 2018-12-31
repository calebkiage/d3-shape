import 'package:d3_shape/constant.dart';
import 'package:test/test.dart';

void main() {
  group('Constant tests', () {
    test('Constant returns function Test', () {
      expect(constant(true) is Function, isTrue);
    });

    test('Constant function returns value Test', () {
      expect(constant(false)(), isFalse);
    });
  });
}
