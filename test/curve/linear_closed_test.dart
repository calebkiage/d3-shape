import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:test/test.dart';

import '../util/path_equal.dart';

main() {
  test('line.curve(curveLinearClosed)(data) generates the expected path', () {
    var l = () {
      var l = shape.LineGenerator();
      l.curve = curves.linearClosedCurve();
      return l;
    };
    expect(l().draw([]), isNull);
    expect(l().draw([[0, 1]]), pathEqual('M0,1Z'));
    expect(l().draw([[0, 1], [2, 3]]), pathEqual('M0,1L2,3Z'));
    expect(l().draw([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L2,3L4,5Z'));
  });
}
