import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:test/test.dart';

import '../util/path_equal.dart';

main() {
  _lineGen(curve) {
    return shape.LineGenerator().curve(curve);
  }

  _areaGen(curve) {
    return shape.AreaGenerator().curve(curve);
  }

  group('step tests', () {
    test('line.curve(stepCurve)(data) generates the expected path', () {
      var l = _lineGen(curves.stepCurve());
      expect(l.generate(data: []).draw(), isNull);
      expect(l.generate(data: [[0, 1]]).draw(), pathEqual('M0,1Z'));
      expect(l.generate(data: [[0, 1], [2, 3]]).draw(), pathEqual('M0,1L1,1L1,3L2,3'));
      expect(l.generate(data: [[0, 1], [2, 3], [4, 5]]).draw(), pathEqual('M0,1L1,1L1,3L3,3L3,5L4,5'));
    });

    test('area.curve(stepCurve)(data) generates the expected path', () {
      var a = _areaGen(curves.stepCurve());
      expect(a.generate(data: []).draw(), isNull);
      expect(a.generate(data: [[0, 1]]).draw(), pathEqual('M0,1L0,0Z'));
      expect(a.generate(data: [[0, 1], [2, 3]]).draw(), pathEqual('M0,1L1,1L1,3L2,3L2,0L1,0L1,0L0,0Z'));
      expect(a.generate(data: [[0, 1], [2, 3], [4, 5]]).draw(), pathEqual('M0,1L1,1L1,3L3,3L3,5L4,5L4,0L3,0L3,0L1,0L1,0L0,0Z'));
    });
  });

  group('stepAfter tests', () {
    test('line.curve(stepAfterCurve)(data) generates the expected path', () {
      var l = _lineGen(curves.stepAfterCurve());
      expect(l.generate(data: []).draw(), isNull);
      expect(l.generate(data: [[0, 1]]).draw(), pathEqual('M0,1Z'));
      expect(l.generate(data: [[0, 1], [2, 3]]).draw(), pathEqual('M0,1L2,1L2,3'));
      expect(l.generate(data: [[0, 1], [2, 3], [4, 5]]).draw(), pathEqual('M0,1L2,1L2,3L4,3L4,5'));
    });

    test('area.curve(stepAfterCurve)(data) generates the expected path', () {
      var a = _areaGen(curves.stepAfterCurve());
      expect(a.generate(data: []).draw(), isNull);
      expect(a.generate(data: [[0, 1]]).draw(), pathEqual('M0,1L0,0Z'));
      expect(a.generate(data: [[0, 1], [2, 3]]).draw(), pathEqual('M0,1L2,1L2,3L2,0L2,0L0,0Z'));
      expect(a.generate(data: [[0, 1], [2, 3], [4, 5]]).draw(), pathEqual('M0,1L2,1L2,3L4,3L4,5L4,0L4,0L2,0L2,0L0,0Z'));
    });
  });

  group('stepBefore tests', () {
    test('line.curve(stepBeforeCurve)(data) generates the expected path', () {
      var l = _lineGen(curves.stepBeforeCurve());
      expect(l.generate(data: []).draw(), isNull);
      expect(l.generate(data: [[0, 1]]).draw(), pathEqual('M0,1Z'));
      expect(l.generate(data: [[0, 1], [2, 3]]).draw(), pathEqual('M0,1L0,3L2,3'));
      expect(l.generate(data: [[0, 1], [2, 3], [4, 5]]).draw(), pathEqual('M0,1L0,3L2,3L2,5L4,5'));
    });

    test('area.curve(stepBeforeCurve)(data) generates the expected path', () {
      var a = _areaGen(curves.stepBeforeCurve());
      expect(a.generate(data: []).draw(), isNull);
      expect(a.generate(data: [[0, 1]]).draw(), pathEqual('M0,1L0,0Z'));
      expect(a.generate(data: [[0, 1], [2, 3]]).draw(), pathEqual('M0,1L0,3L2,3L2,0L0,0L0,0Z'));
      expect(a.generate(data: [[0, 1], [2, 3], [4, 5]]).draw(), pathEqual('M0,1L0,3L2,3L2,5L4,5L4,0L2,0L2,0L0,0L0,0Z'));
    });
  });
}
