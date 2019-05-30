import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:test/test.dart';

import '../util/path_equal.dart';

main() {
  test('line with curve(linearCurve()).draw(data) generates the expected path', () {
    var l = shape.LineGenerator().curve(curves.linearCurve());
    expect(l.generate(data: []).draw(), isNull);
    expect(l.generate(data: [[0, 1]]).draw(), pathEqual('M0,1Z'));
    expect(l.generate(data: [[0, 1], [2, 3]]).draw(), pathEqual('M0,1L2,3'));
    expect(l.generate(data: [[0, 1], [2, 3], [4, 5]]).draw(), pathEqual('M0,1L2,3L4,5'));
  });

  test('area with curve(linearCurve()).draw(data) generates the expected path', () {
    var a = shape.AreaGenerator().curve(curves.linearCurve());
    expect(a.generate(data: []).draw(), isNull);
    expect(a.generate(data: [[0, 1]]).draw(), pathEqual('M0,1L0,0Z'));
    expect(a.generate(data: [[0, 1], [2, 3]]).draw(), pathEqual('M0,1L2,3L2,0L0,0Z'));
    expect(a.generate(data: [[0, 1], [2, 3], [4, 5]]).draw(), pathEqual('M0,1L2,3L4,5L4,0L2,0L0,0Z'));
  });
}