import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:test/test.dart';

import '../util/path_equal.dart';

main() {
  test('line with curve(basisCurve()).draw(data) generates the expected path', () {
    var l = shape.LineGenerator().curve(curves.basisCurve());
    expect(l.generate(data: []).draw(), isNull);
    expect(l.generate(data: [[0, 1]]).draw(), pathEqual('M0,1Z'));
    expect(l.generate(data: [[0, 1], [1, 3]]).draw(), pathEqual('M0,1L1,3'));
    expect(l.generate(data: [[0, 1], [1, 3], [2, 1]]).draw(), pathEqual('M0,1L0.166667,1.333333C0.333333,1.666667,0.666667,2.333333,1,2.333333C1.333333,2.333333,1.666667,1.666667,1.833333,1.333333L2,1'));
  });

  test('area.curve(curveBasis)(data) generates the expected path', () {
    var a = shape.AreaGenerator().curve(curves.basisCurve());;
    expect(a.generate(data: []).draw(), isNull);
    expect(a.generate(data: [[0, 1]]).draw(), pathEqual('M0,1L0,0Z'));
    expect(a.generate(data: [[0, 1], [1, 3]]).draw(), pathEqual('M0,1L1,3L1,0L0,0Z'));
    expect(a.generate(data: [[0, 1], [1, 3], [2, 1]]).draw(), pathEqual('M0,1L0.166667,1.333333C0.333333,1.666667,0.666667,2.333333,1,2.333333C1.333333,2.333333,1.666667,1.666667,1.833333,1.333333L2,1L2,0L1.833333,0C1.666667,0,1.333333,0,1,0C0.666667,0,0.333333,0,0.166667,0L0,0Z'));
  });
}