import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:test/test.dart';

import '../util/path_equal.dart';

main() {
  test('line with curve(linearCurve()).draw(data) generates the expected path', () {
    var l = () {
      var l = shape.LineGenerator();
      l.curve = curves.linearCurve();
      return l;
    };
    expect(l().draw([]), isNull);
    expect(l().draw([[0, 1]]), pathEqual('M0,1Z'));
    expect(l().draw([[0, 1], [2, 3]]), pathEqual('M0,1L2,3'));
    expect(l().draw([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L2,3L4,5'));
  });

  test('area with curve(linearCurve()).draw(data) generates the expected path', () {
    var a = () {
      var a = shape.AreaGenerator();
      a.curve = curves.linearCurve();
      return a;
    };
    expect(a().draw([]), isNull);
    expect(a().draw([[0, 1]]), pathEqual('M0,1L0,0Z'));
    expect(a().draw([[0, 1], [2, 3]]), pathEqual('M0,1L2,3L2,0L0,0Z'));
    expect(a().draw([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L2,3L4,5L4,0L2,0L0,0Z'));
  });
}