import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:test/test.dart';

import '../util/path_equal.dart';

main() {
  group("line tests", () {
    _lineGen(curve) {
      return () {
        var l = shape.LineGenerator();
        l.curve = curve;
        return l;
      };
    }

    test('line.curve(curveCardinal)(data) generates the expected path', () {
      var l = _lineGen(curves.curveCardinal());
      expect(l().draw([]), isNull);
      expect(l().draw([[0, 1]]), pathEqual('M0,1Z'));
      expect(l().draw([[0, 1], [1, 3]]), pathEqual('M0,1L1,3'));
      expect(l().draw([[0, 1], [1, 3], [2, 1], [3, 3]]), pathEqual('M0,1C0,1,0.666667,3,1,3C1.333333,3,1.666667,1,2,1C2.333333,1,3,3,3,3'));
    });

    test('line.curve(curveCardinal) uses a default tension of zero', () {
      var l0 = _lineGen(curves.curveCardinal());
      var l1 = _lineGen(curves.curveCardinal(tension: 0));
      expect(l0().draw([[0, 1], [1, 3], [2, 1], [3, 3]]), equals(l1().draw([[0, 1], [1, 3], [2, 1], [3, 3]])));
    });

    test('line.curve(curveCardinal.tension(tension)) uses the specified tension', () {
      var l = _lineGen(curves.curveCardinal(tension: 0.5));
      expect(l().draw([[0, 1], [1, 3], [2, 1], [3, 3]]), pathEqual('M0,1C0,1,0.833333,3,1,3C1.166667,3,1.833333,1,2,1C2.166667,1,3,3,3,3'));
    });

    test('line.curve(curveCardinal.tension(tension)) coerces the specified tension to a number', () {
      var l0 = _lineGen(curves.curveCardinal(tension: 0.5));
      var l1 = _lineGen(curves.curveCardinal(tension: "0.5"));
      expect(l0().draw([[0, 1], [1, 3], [2, 1], [3, 3]]), equals(l1().draw([[0, 1], [1, 3], [2, 1], [3, 3]])));
    });
  });

  group("area tests", () {
    _areaGen(curve) {
      return () {
        var l = shape.AreaGenerator();
        l.curve = curve;
        return l;
      };
    }

    test('area.curve(curveCardinal)(data) generates the expected path', () {
      var a = _areaGen(curves.curveCardinal());
      expect(a().draw([]), isNull);
      expect(a().draw([[0, 1]]), pathEqual('M0,1L0,0Z'));
      expect(a().draw([[0, 1], [1, 3]]), pathEqual('M0,1L1,3L1,0L0,0Z'));
      expect(a().draw([[0, 1], [1, 3], [2, 1]]), pathEqual('M0,1C0,1,0.666667,3,1,3C1.333333,3,2,1,2,1L2,0C2,0,1.333333,0,1,0C0.666667,0,0,0,0,0Z'));
      expect(a().draw([[0, 1], [1, 3], [2, 1], [3, 3]]), pathEqual('M0,1C0,1,0.666667,3,1,3C1.333333,3,1.666667,1,2,1C2.333333,1,3,3,3,3L3,0C3,0,2.333333,0,2,0C1.666667,0,1.333333,0,1,0C0.666667,0,0,0,0,0Z'));
    });

    test('area.curve(curveCardinal) uses a default tension of zero', () {
      var a0 = _areaGen(curves.curveCardinal());
      var a1 = _areaGen(curves.curveCardinal(tension: 0));
      expect(a0().draw([[0, 1], [1, 3], [2, 1], [3, 3]]), equals(a1().draw([[0, 1], [1, 3], [2, 1], [3, 3]])));
    });

    test('area.curve(curveCardinal.tension(tension)) uses the specified tension', () {
      var a = _areaGen(curves.curveCardinal(tension: 0.5));
      expect(a().draw([[0, 1], [1, 3], [2, 1], [3, 3]]), pathEqual('M0,1C0,1,0.833333,3,1,3C1.166667,3,1.833333,1,2,1C2.166667,1,3,3,3,3L3,0C3,0,2.166667,0,2,0C1.833333,0,1.166667,0,1,0C0.833333,0,0,0,0,0Z'));
    });

    test('area.curve(curveCardinal.tension(tension)) coerces the specified tension to a number', () {
      var a0 = _areaGen(curves.curveCardinal(tension: 0.5));
      var a1 = _areaGen(curves.curveCardinal(tension: "0.5"));
      expect(a0().draw([[0, 1], [1, 3], [2, 1], [3, 3]]), equals(a1().draw([[0, 1], [1, 3], [2, 1], [3, 3]])));
    });
  });
}