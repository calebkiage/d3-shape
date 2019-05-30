import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:d3_shape/src/point.dart';
import 'package:test/test.dart';

import 'util/path_equal.dart';

main() {
  test('draw() returns a default line shape', () {
    var l = shape.LineGenerator().generate(data: [Point(0, 1), Point(2, 3), Point(4, 5)]);
    expect(l.x([42, 34]), equals(42));
    expect(l.y([42, 34]), equals(34));
    expect(l.defined(), isTrue);
    expect(l.curve.runtimeType, equals(curves.linearCurve().runtimeType));
    expect(l.context, isNull);
    expect(l.draw(), pathEqual('M0,1L2,3L4,5'));
  });

  test('line with x(f).draw(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    var l = shape.LineGenerator().x(f).generate(data: data);
    l.draw();
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('line with y(f).draw(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };

    var l = shape.LineGenerator().y(f).generate(data: data);
    l.draw();
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('line with defined(f).draw(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    var l = shape.LineGenerator().defined(f).generate(data: data);
    l.draw();
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('line with x(x).draw(data) observes the specified function', () {
    var x = ([d, _, __]) {
      return d['x'];
    };

    var l = shape.LineGenerator().x(x).generate(data: [{'x': 0, 1: 1}, {'x': 2, 1: 3}, {'x': 4, 1: 5}]);
    var output = l.draw();
    expect(output, pathEqual('M0,1L2,3L4,5'));
  });

  test('line with constant x.draw(data) observes the specified constant', () {
    var l = shape.LineGenerator().x(0).generate(data: [{1: 1}, {1: 3}, {1: 5}]);
    var output = l.draw();
    expect(output, pathEqual('M0,1L0,3L0,5'));
  });

  test('line with y(y).draw(data) observes the specified function', () {
    var y = ([d, _, __]) {
      return d['y'];
    };
    var l = shape.LineGenerator().y(y).generate(data: [{0: 0, 'y': 1}, {0: 2, 'y': 3}, {0: 4, 'y': 5}]);
    var output = l.draw();
    expect(output, pathEqual('M0,1L2,3L4,5'));
  });

  test('line with constant y.draw(data) observes the specified constant', () {
    var l = shape.LineGenerator().y(0).generate(data: [{0: 0}, {0: 2}, {0: 4}]);
    var output = l.draw();
    expect(output, pathEqual('M0,0L2,0L4,0'));
  });

  test('line.curve = curve sets the curve method', () {
    var l = shape.LineGenerator().curve(curves.linearClosedCurve());

    expect(l.generate(data: []).draw(), isNull);
    expect(l.generate(data: [[0, 1], [2, 3]]).draw(), pathEqual('M0,1L2,3Z'));
  });
}
