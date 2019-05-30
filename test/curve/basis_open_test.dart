import 'package:test/test.dart';
import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart' as shape;

import '../util/path_equal.dart';

main() {
  test("line.curve(curveBasisOpen)(data) generates the expected path", () {
    var l = shape.LineGenerator().curve(curves.basisOpenCurve());
    var d1 = [];
    var d2 = [
      [0, 0]
    ];
    var d3 = [
      [0, 0],
      [0, 10]
    ];
    var d4 = [
      [0, 0],
      [0, 10],
      [10, 10]
    ];
    var d5 = [
      [0, 0],
      [0, 10],
      [10, 10],
      [10, 0]
    ];
    var d6 = [
      [0, 0],
      [0, 10],
      [10, 10],
      [10, 0],
      [0, 0]
    ];

    var path1 = "M1.666667,8.333333Z";
    var path2 = "M1.666667,8.333333C3.333333,10,6.666667,10,8.333333,8.333333";
    var path3 =
        "M1.666667,8.333333C3.333333,10,6.666667,10,8.333333,8.333333C10,6.666667,10,3.333333,8.333333,1.666667";

    expect(l.generate(data: d1).draw(), isNull);
    expect(l.generate(data: d2).draw(), isNull);
    expect(l.generate(data: d3).draw(), isNull);
    expect(l.generate(data: d4).draw(), pathEqual(path1));
    expect(l.generate(data: d5).draw(), pathEqual(path2));
    expect(l.generate(data: d6).draw(), pathEqual(path3));
  });

  test("area.curve(curveBasisOpen)(data) generates the expected path", () {
    var a = shape.AreaGenerator().curve(curves.basisOpenCurve());
    var d1 = [];
    var d2 = [
      [0, 1]
    ];
    var d3 = [
      [0, 1],
      [1, 3]
    ];
    var d4 = [
      [0, 0],
      [0, 10],
      [10, 10]
    ];
    var d5 = [
      [0, 0],
      [0, 10],
      [10, 10],
      [10, 0]
    ];
    var d6 = [
      [0, 0],
      [0, 10],
      [10, 10],
      [10, 0],
      [0, 0]
    ];

    var path1 = "M1.666667,8.333333L1.666667,0Z";
    var path2 =
        "M1.666667,8.333333C3.333333,10,6.666667,10,8.333333,8.333333L8.333333,0C6.666667,0,3.333333,0,1.666667,0Z";
    var path3 =
        "M1.666667,8.333333C3.333333,10,6.666667,10,8.333333,8.333333C10,6.666667,10,3.333333,8.333333,1.666667L8.333333,0C10,0,10,0,8.333333,0C6.666667,0,3.333333,0,1.666667,0Z";

    expect(a.generate(data: d1).draw(), isNull);
    expect(a.generate(data: d2).draw(), isNull);
    expect(a.generate(data: d3).draw(), isNull);
    expect(a.generate(data: d4).draw(), pathEqual(path1));
    expect(a.generate(data: d5).draw(), pathEqual(path2));
    expect(a.generate(data: d6).draw(), pathEqual(path3));
  });
}
