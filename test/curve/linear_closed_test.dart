import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:test/test.dart';

import '../util/path_equal.dart';

main() {
  test('line.curve(curveLinearClosed)(data) generates the expected path', () {
    var l = shape.LineGenerator().curve(curves.linearClosedCurve());
    expect(l.generate(data: []).draw(), isNull);
    expect(l.generate(data: [[0, 1]]).draw(), pathEqual('M0,1Z'));
    expect(l.generate(data: [[0, 1], [2, 3]]).draw(), pathEqual('M0,1L2,3Z'));
    expect(l.generate(data: [[0, 1], [2, 3], [4, 5]]).draw(), pathEqual('M0,1L2,3L4,5Z'));
  });
}
