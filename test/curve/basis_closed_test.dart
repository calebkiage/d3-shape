import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:test/test.dart';

import '../util/path_equal.dart';

main() {
  test('line with curve(basisCurve()).draw(data) generates the expected path', () {
    var l = shape.LineGenerator().curve(curves.basisClosedCurve());
    expect(l.generate(data: []).draw(), isNull);
    expect(l.generate(data: [[0, 0]]).draw(), pathEqual("M0,0Z"));
    expect(l.generate(data: [[0, 0], [0, 10]]).draw(), pathEqual("M0,6.666667L0,3.333333Z"));
    expect(l.generate(data: [[0, 0], [0, 10], [10, 10]]).draw(), pathEqual("M1.666667,8.333333C3.333333,10,6.666667,10,6.666667,8.333333C6.666667,6.666667,3.333333,3.333333,1.666667,3.333333C0,3.333333,0,6.666667,1.666667,8.333333"));
    expect(l.generate(data: [[0, 0], [0, 10], [10, 10], [10, 0]]).draw(), pathEqual("M1.666667,8.333333C3.333333,10,6.666667,10,8.333333,8.333333C10,6.666667,10,3.333333,8.333333,1.666667C6.666667,0,3.333333,0,1.666667,1.666667C0,3.333333,0,6.666667,1.666667,8.333333"));
    expect(l.generate(data: [[0, 0], [0, 10], [10, 10], [10, 0], [0, 0]]).draw(), pathEqual("M1.666667,8.333333C3.333333,10,6.666667,10,8.333333,8.333333C10,6.666667,10,3.333333,8.333333,1.666667C6.666667,0,3.333333,0,1.666667,0C0,0,0,0,0,1.666667C0,3.333333,0,6.666667,1.666667,8.333333"));
  });
}