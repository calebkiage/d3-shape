import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:d3_shape/curves.dart' as curves;
import 'package:test/test.dart';
import '../util/path_equal.dart';

main() {
  test('line.curve(curveLinearClosed)(data) generates the expected path', () {
    var l = shape.line().curve(curves.curveLinearClosed);
    expect(l([]), isNull);
    expect(l([[0, 1]]), pathEqual('M0,1Z'));
    expect(l([[0, 1], [2, 3]]), pathEqual('M0,1L2,3Z'));
    expect(l([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L2,3L4,5Z'));
  });
}
