import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:d3_shape/curves.dart' as curves;
import 'package:test/test.dart';
import '../util/path_equal.dart';

main() {
  test('line.curve(curveCardinal)(data) generates the expected path', () {
    var l = shape.line().curve(curves.curveCardinal);
    expect(l([]), isNull);
    expect(l([[0, 1]]), pathEqual('M0,1Z'));
    expect(l([[0, 1], [1, 3]]), pathEqual('M0,1L1,3'));
    expect(l([[0, 1], [1, 3], [2, 1], [3, 3]]), pathEqual('M0,1C0,1,0.666667,3,1,3C1.333333,3,1.666667,1,2,1C2.333333,1,3,3,3,3'));
  });

  test('line.curve(curveCardinal) uses a default tension of zero', () {
    var l = shape.line().curve(curves.curveCardinal.tension(0));
    expect(shape.line().curve(curves.curveCardinal)([[0, 1], [1, 3], [2, 1], [3, 3]]), equals(l([[0, 1], [1, 3], [2, 1], [3, 3]])));
  });

  test('line.curve(curveCardinal.tension(tension)) uses the specified tension', () {
    expect(shape.line().curve(curves.curveCardinal.tension(0.5))([[0, 1], [1, 3], [2, 1], [3, 3]]), pathEqual('M0,1C0,1,0.833333,3,1,3C1.166667,3,1.833333,1,2,1C2.166667,1,3,3,3,3'));
  });

  test('line.curve(curveCardinal.tension(tension)) coerces the specified tension to a number', () {
    var l = shape.line().curve(curves.curveCardinal.tension("0.5"));
    expect(shape.line().curve(curves.curveCardinal.tension(0.5))([[0, 1], [1, 3], [2, 1], [3, 3]]), equals(l([[0, 1], [1, 3], [2, 1], [3, 3]])));
  });

  test('area.curve(curveCardinal)(data) generates the expected path', () {
    var a = shape.area().curve(curves.curveCardinal);
    expect(a([]), isNull);
    expect(a([[0, 1]]), pathEqual('M0,1L0,0Z'));
    expect(a([[0, 1], [1, 3]]), pathEqual('M0,1L1,3L1,0L0,0Z'));
    expect(a([[0, 1], [1, 3], [2, 1]]), pathEqual('M0,1C0,1,0.666667,3,1,3C1.333333,3,2,1,2,1L2,0C2,0,1.333333,0,1,0C0.666667,0,0,0,0,0Z'));
    expect(a([[0, 1], [1, 3], [2, 1], [3, 3]]), pathEqual('M0,1C0,1,0.666667,3,1,3C1.333333,3,1.666667,1,2,1C2.333333,1,3,3,3,3L3,0C3,0,2.333333,0,2,0C1.666667,0,1.333333,0,1,0C0.666667,0,0,0,0,0Z'));
  });

  test('area.curve(curveCardinal) uses a default tension of zero', () {
    var a = shape.area().curve(curves.curveCardinal.tension(0));
    expect(shape.area().curve(curves.curveCardinal)([[0, 1], [1, 3], [2, 1], [3, 3]]), equals(a([[0, 1], [1, 3], [2, 1], [3, 3]])));
  });

  test('area.curve(curveCardinal.tension(tension)) uses the specified tension', () {
    expect(shape.area().curve(curves.curveCardinal.tension(0.5))([[0, 1], [1, 3], [2, 1], [3, 3]]), pathEqual('M0,1C0,1,0.833333,3,1,3C1.166667,3,1.833333,1,2,1C2.166667,1,3,3,3,3L3,0C3,0,2.166667,0,2,0C1.833333,0,1.166667,0,1,0C0.833333,0,0,0,0,0Z'));
  });

  test('area.curve(curveCardinal.tension(tension)) coerces the specified tension to a number', () {
    var a = shape.area().curve(curves.curveCardinal.tension("0.5"));
    expect(shape.area().curve(curves.curveCardinal.tension(0.5))([[0, 1], [1, 3], [2, 1], [3, 3]]), equals(a([[0, 1], [1, 3], [2, 1], [3, 3]])));
  });
}