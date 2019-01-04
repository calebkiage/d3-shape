import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:d3_shape/curves.dart' as curves;
import 'package:test/test.dart';
import 'util/path_equal.dart';

main() {
  test('area() returns a default area shape', () {
    var a = shape.area();
    expect(a.x0()([42, 34]), equals(42));
    expect(a.x1(), isNull);
    expect(a.y0()([42, 34]), equals(0));
    expect(a.y1()([42, 34]), equals(34));
    expect(a.defined()([42, 34]), isTrue);
    expect(a.curve(), equals(curves.curveLinear));
    expect(a.context(), isNull);
    expect(a([[0, 1], [2, 3], [4, 5]]), pathEqual('M0,1L2,3L4,5L4,0L2,0L0,0Z'));
  });

  test('area.x([f])(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    shape.area().x([f])(data);
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('area.x0([f])(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    shape.area().x0([f])(data);
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('area.x1([f])(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    shape.area().x1([f])(data);
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('area.y([f])(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    shape.area().y([f])(data);
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('area.y0([f])(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    shape.area().y0([f])(data);
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('area.y1([f])(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    shape.area().y1([f])(data);
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('area.defined(f)(data) passes d, i and data to the specified function f', () {
    var data = ['a', 'b'], actual = [];
    var f = ([args, _, __]) {
      actual.add([args, _, __]);
    };
    shape.area().defined(f)(data);
    expect(actual, [['a', 0, data], ['b', 1, data]]);
  });

  test('area.x(x)(data) observes the specified function', () {
    var x = ([d, _, __]) {
      return d['x'];
    };
    var a = shape.area().x([x]);
    expect(a.x(), equals(x));
    expect(a.x0(), equals(x));
    expect(a.x1(), isNull);
    expect(a([{'x': 0, 1: 1}, {'x': 2, 1: 3}, {'x': 4, 1: 5}]), pathEqual('M0,1L2,3L4,5L4,0L2,0L0,0Z'));
  });

  test('area.x(x)(data) observes the specified constant', () {
    var x = 0;
    var a = shape.area().x([x]);
    expect(a.x()(), equals(x));
    expect(a.x0()(), equals(x));
    expect(a.x1(), isNull);
    expect(a([{1: 1}, {1: 3}, {1: 5}]), pathEqual('M0,1L0,3L0,5L0,0L0,0L0,0Z'));
  });

  test('area.y(y)(data) observes the specified function', () {
    var y = ([d, _, __]) {
      return d['y'];
    };
    var a = shape.area().y([y]);
    expect(a.y(), equals(y));
    expect(a.y0(), equals(y));
    expect(a.y1(), isNull);
    expect(a([{0: 0, 'y': 1}, {0: 2, 'y': 3}, {0: 4, 'y': 5}]), pathEqual('M0,1L2,3L4,5L4,5L2,3L0,1Z'));
  });

  test('area.y(y)(data) observes the specified constant', () {
    var y = 0;
    var a = shape.area().y([y]);
    expect(a.y()(), equals(y));
    expect(a.y0()(), equals(y));
    expect(a.y1(), isNull);
    expect(a([{0: 0}, {0: 2}, {0: 4}]), pathEqual('M0,0L2,0L4,0L4,0L2,0L0,0Z'));
  });
}
