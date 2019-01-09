import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:d3_shape/curves.dart' as curves;
import 'package:test/test.dart';
import 'util/path_equal.dart';

main() {
  test('line() returns a default line shape', () {
    var l = shape.line();
    expect(l.x()([42, 34]), equals(42));
    expect(l.y()([42, 34]), equals(34));
    expect(l.defined()([42, 34]), isTrue);
    expect(l.curve(), equals(curves.curveLinear));
    expect(l.context(), isNull);
    expect(l([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L2,3L4,5'));
  });

  test('line.x(f)(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    shape.line().x([f])(data);
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('line.y(f)(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    shape.line().x([f])(data);
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('line.defined(f)(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    shape.line().defined(f)(data);
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('line.x(x)(data) observes the specified function', () {
    var l = shape.line().x([([d, _, __]) {
      return d['x'];
    }]);
    expect(l([{'x': 0, 1: 1}, {'x': 2, 1: 3}, {'x': 4, 1: 5}]), pathEqual('M0,1L2,3L4,5'));
  });

  test('line.x(x)(data) observes the specified constant', () {
    var l = shape.line().x([0]);
    expect(l([{1: 1}, {1: 3}, {1: 5}]), pathEqual('M0,1L0,3L0,5'));
  });

  test('line.y(y)(data) observes the specified function', () {
    var l = shape.line().y([([d, _, __]) {
      return d['y'];
    }]);
    expect(l([{0: 0, 'y': 1}, {0: 2, 'y': 3}, {0: 4, 'y': 5}]), pathEqual('M0,1L2,3L4,5'));
  });

  test('line.y(y)(data) observes the specified constant', () {
    var l = shape.line().y([0]);
    expect(l([{0: 0}, {0: 2}, {0: 4}]), pathEqual('M0,0L2,0L4,0'));
  });

  test('line.curve(curve) sets the curve method', () {
    var l = shape.line().curve(curves.curveLinearClosed);
    expect(l([]), isNull);
    expect(l([[0, 1], [2, 3]]), pathEqual('M0,1L2,3Z'));
  });
}
