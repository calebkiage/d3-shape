import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:d3_shape/curves.dart' as curves;
import 'package:test/test.dart';
import '../util/path_equal.dart';

main() {
  group('step tests', () {
    test('line.curve(curveStep)(data) generates the expected path', () {
      var l = shape.line().curve(curves.curveStep);
      expect(l([]), isNull);
      expect(l([[0, 1]]), pathEqual('M0,1Z'));
      expect(l([[0, 1], [2, 3]]), pathEqual('M0,1L1,1L1,3L2,3'));
      expect(l([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L1,1L1,3L3,3L3,5L4,5'));
    });

    test('area.curve(curveStep)(data) generates the expected path', () {
      var a = shape.area().curve(curves.curveStep);
      expect(a([]), isNull);
      expect(a([[0, 1]]), pathEqual('M0,1L0,0Z'));
      expect(a([[0, 1], [2, 3]]), pathEqual('M0,1L1,1L1,3L2,3L2,0L1,0L1,0L0,0Z'));
      expect(a([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L1,1L1,3L3,3L3,5L4,5L4,0L3,0L3,0L1,0L1,0L0,0Z'));
    });
  });

  group('stepAfter tests', () {
    test('line.curve(curveStepAfter)(data) generates the expected path', () {
      var l = shape.line().curve(curves.curveStepAfter);
      expect(l([]), isNull);
      expect(l([[0, 1]]), pathEqual('M0,1Z'));
      expect(l([[0, 1], [2, 3]]), pathEqual('M0,1L2,1L2,3'));
      expect(l([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L2,1L2,3L4,3L4,5'));
    });

    test('area.curve(curveStepAfter)(data) generates the expected path', () {
      var a = shape.area().curve(curves.curveStepAfter);
      expect(a([]), isNull);
      expect(a([[0, 1]]), pathEqual('M0,1L0,0Z'));
      expect(a([[0, 1], [2, 3]]), pathEqual('M0,1L2,1L2,3L2,0L2,0L0,0Z'));
      expect(a([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L2,1L2,3L4,3L4,5L4,0L4,0L2,0L2,0L0,0Z'));
    });
  });

  group('stepBefore tests', () {
    test('line.curve(curveStepBefore)(data) generates the expected path', () {
      var l = shape.line().curve(curves.curveStepBefore);
      expect(l([]), isNull);
      expect(l([[0, 1]]), pathEqual('M0,1Z'));
      expect(l([[0, 1], [2, 3]]), pathEqual('M0,1L0,3L2,3'));
      expect(l([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L0,3L2,3L2,5L4,5'));
    });

    test('area.curve(curveStepBefore)(data) generates the expected path', () {
      var a = shape.area().curve(curves.curveStepBefore);
      expect(a([]), isNull);
      expect(a([[0, 1]]), pathEqual('M0,1L0,0Z'));
      expect(a([[0, 1], [2, 3]]), pathEqual('M0,1L0,3L2,3L2,0L0,0L0,0Z'));
      expect(a([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L0,3L2,3L2,5L4,5L4,0L2,0L2,0L0,0L0,0Z'));
    });
  });
}
