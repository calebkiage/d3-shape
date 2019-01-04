import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:d3_shape/curves.dart' as curves;
import 'package:test/test.dart';
import '../util/path_equal.dart';

main() {
  test('line.curve(curveLinear)(data) generates the expected path', () {
    var l = shape.line().curve(curves.curveLinear);
    expect(l([]), isNull);
    expect(l([[0, 1]]), pathEqual('M0,1Z'));
    expect(l([[0, 1], [2, 3]]), pathEqual('M0,1L2,3'));
    expect(l([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L2,3L4,5'));
  });

  test('area.curve(curveLinear)(data) generates the expected path', () {
    var a = shape.area().curve(curves.curveLinear);
    expect(a([]), isNull);
    expect(a([[0, 1]]), pathEqual('M0,1L0,0Z'));
    expect(a([[0, 1], [2, 3]]), pathEqual('M0,1L2,3L2,0L0,0Z'));
    expect(a([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L2,3L4,5L4,0L2,0L0,0Z'));
  });
}