import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:test/test.dart';

import '../util/path_equal.dart';

main() {
  group("line tests", () {
    _lineGen(curve) {
      return shape.LineGenerator().curve(curve);
    }

    test('line.curve(curveCardinal)(data) generates the expected path', () {
      var l = _lineGen(curves.curveCardinal());
      expect(l.generate(data: []).draw(), isNull);
      expect(l.generate(data: [[0, 1]]).draw(), pathEqual('M0,1Z'));
      expect(l.generate(data: [[0, 1], [1, 3]]).draw(), pathEqual('M0,1L1,3'));
      expect(l.generate(data: [[0, 1], [1, 3], [2, 1], [3, 3]]).draw(), pathEqual('M0,1C0,1,0.666667,3,1,3C1.333333,3,1.666667,1,2,1C2.333333,1,3,3,3,3'));
    });

    test('line.curve(curveCardinal) uses a default tension of zero', () {
      var l0 = _lineGen(curves.curveCardinal());
      var l1 = _lineGen(curves.curveCardinal(tension: 0));
      var data = [[0, 1], [1, 3], [2, 1], [3, 3]];
      expect(l0.generate(data: data).draw(), equals(l1.generate(data: data).draw()));
    });

    test('line.curve(curveCardinal.tension(tension)) uses the specified tension', () {
      var l = _lineGen(curves.curveCardinal(tension: 0.5));
      expect(l.generate(data: [[0, 1], [1, 3], [2, 1], [3, 3]]).draw(), pathEqual('M0,1C0,1,0.833333,3,1,3C1.166667,3,1.833333,1,2,1C2.166667,1,3,3,3,3'));
    });

    test('line.curve(curveCardinal.tension(tension)) coerces the specified tension to a number', () {
      var l0 = _lineGen(curves.curveCardinal(tension: 0.5));
      var l1 = _lineGen(curves.curveCardinal(tension: "0.5"));
      var data = [[0, 1], [1, 3], [2, 1], [3, 3]];
      expect(l0.generate(data: data).draw(), equals(l1.generate(data: data).draw()));
    });
  });

  group("area tests", () {
    _areaGen(curve) {
      return shape.AreaGenerator().curve(curve);
    }

    test('area.curve(curveCardinal)(data) generates the expected path', () {
      var a = _areaGen(curves.curveCardinal());
      expect(a.generate(data: []).draw(), isNull);
      expect(a.generate(data: [[0, 1]]).draw(), pathEqual('M0,1L0,0Z'));
      expect(a.generate(data: [[0, 1], [1, 3]]).draw(), pathEqual('M0,1L1,3L1,0L0,0Z'));
      expect(a.generate(data: [[0, 1], [1, 3], [2, 1]]).draw(), pathEqual('M0,1C0,1,0.666667,3,1,3C1.333333,3,2,1,2,1L2,0C2,0,1.333333,0,1,0C0.666667,0,0,0,0,0Z'));
      expect(a.generate(data: [[0, 1], [1, 3], [2, 1], [3, 3]]).draw(), pathEqual('M0,1C0,1,0.666667,3,1,3C1.333333,3,1.666667,1,2,1C2.333333,1,3,3,3,3L3,0C3,0,2.333333,0,2,0C1.666667,0,1.333333,0,1,0C0.666667,0,0,0,0,0Z'));
    });

    test('area.curve(curveCardinal) uses a default tension of zero', () {
      var a0 = _areaGen(curves.curveCardinal());
      var a1 = _areaGen(curves.curveCardinal(tension: 0));
      var data = [[0, 1], [1, 3], [2, 1], [3, 3]];
      expect(a0.generate(data: data).draw(), equals(a1.generate(data: data).draw()));
    });

    test('area.curve(curveCardinal.tension(tension)) uses the specified tension', () {
      var a = _areaGen(curves.curveCardinal(tension: 0.5));
      var data = [[0, 1], [1, 3], [2, 1], [3, 3]];
      expect(a.generate(data: data).draw(), pathEqual('M0,1C0,1,0.833333,3,1,3C1.166667,3,1.833333,1,2,1C2.166667,1,3,3,3,3L3,0C3,0,2.166667,0,2,0C1.833333,0,1.166667,0,1,0C0.833333,0,0,0,0,0Z'));
    });

    test('area.curve(curveCardinal.tension(tension)) coerces the specified tension to a number', () {
      var a0 = _areaGen(curves.curveCardinal(tension: 0.5));
      var a1 = _areaGen(curves.curveCardinal(tension: "0.5"));
      var data = [[0, 1], [1, 3], [2, 1], [3, 3]];
      expect(a0.generate(data: data).draw(), equals(a1.generate(data: data).draw()));
    });
  });
}