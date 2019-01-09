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

  test('area.curve(curve) sets the curve method', () {
    var a = shape.area().curve(curves.curveCardinal);
    expect(a([[0, 1], [1, 3], [2, 1], [3, 3]]), pathEqual('M0,1C0,1,0.666667,3,1,3C1.333333,3,1.666667,1,2,1C2.333333,1,3,3,3,3L3,0C3,0,2.333333,0,2,0C1.666667,0,1.333333,0,1,0C0.666667,0,0,0,0,0Z'));
  });

  test('area.curve(curveCardinal.tension(tension)) sets the cardinal spline tension', () {
    var a = shape.area().curve(curves.curveCardinal.tension(0.1));
    expect(a([]), isNull);
    expect(a([[0, 1]]), pathEqual('M0,1L0,0Z'));
    expect(a([[0, 1], [1, 3]]), pathEqual('M0,1L1,3L1,0L0,0Z'));
    expect(a([[0, 1], [1, 3], [2, 1]]), pathEqual('M0,1C0,1,0.700000,3,1,3C1.300000,3,2,1,2,1L2,0C2,0,1.300000,0,1,0C0.700000,0,0,0,0,0Z'));
    expect(a([[0, 1], [1, 3], [2, 1], [3, 3]]), pathEqual('M0,1C0,1,0.700000,3,1,3C1.300000,3,1.700000,1,2,1C2.300000,1,3,3,3,3L3,0C3,0,2.300000,0,2,0C1.700000,0,1.300000,0,1,0C0.700000,0,0,0,0,0Z'));
  });

  test('area.curve(curveCardinal.tension(tension)) coerces the specified tension to a number', () {
    var a = shape.area().curve(curves.curveCardinal.tension('0.1'));
    expect(a([]), isNull);
    expect(a([[0, 1]]), pathEqual('M0,1L0,0Z'));
    expect(a([[0, 1], [1, 3]]), pathEqual('M0,1L1,3L1,0L0,0Z'));
    expect(a([[0, 1], [1, 3], [2, 1]]), pathEqual('M0,1C0,1,0.700000,3,1,3C1.300000,3,2,1,2,1L2,0C2,0,1.300000,0,1,0C0.700000,0,0,0,0,0Z'));
    expect(a([[0, 1], [1, 3], [2, 1], [3, 3]]), pathEqual('M0,1C0,1,0.700000,3,1,3C1.300000,3,1.700000,1,2,1C2.300000,1,3,3,3,3L3,0C3,0,2.300000,0,2,0C1.700000,0,1.300000,0,1,0C0.700000,0,0,0,0,0Z'));
  });
  
  test('area.lineX0() returns a line derived from the area', () {
    var defined = () => true,
        curve = curves.curveCardinal,
        context = {},
        x0 = ([List<Object> _]) => {},
        x1 = ([List<Object> _]) => {},
        y = ([List<Object> _]) => {},
        a = shape.area().defined(defined).curve(curve).context([context]).y([y]).x0([x0]).x1([x1]),
        l = a.lineX0();
    expect(l.defined(), equals(defined));
    expect(l.curve(), equals(curve));
    expect(l.context(), equals(context));
    expect(l.x(), equals(x0));
    expect(l.y(), equals(y));
  });

  test('area.lineX1() returns a line derived from the area', () {
    var defined = () => true,
        curve = curves.curveCardinal,
        context = {},
        x0 = ([List<Object> _]) => {},
        x1 = ([List<Object> _]) => {},
        y = ([List<Object> _]) => {},
        a = shape.area().defined(defined).curve(curve).context([context]).y([y]).x0([x0]).x1([x1]),
        l = a.lineX1();
    expect(l.defined(), equals(defined));
    expect(l.curve(), equals(curve));
    expect(l.context(), equals(context));
    expect(l.x(), equals(x1));
    expect(l.y(), equals(y));
  });

  test('area.lineY0() returns a line derived from the area', () {
    var defined = () => true,
        curve = curves.curveCardinal,
        context = {},
        x = ([List<Object> _]) => {},
        y0 = ([List<Object> _]) => {},
        y1 = ([List<Object> _]) => {},
        a = shape.area().defined(defined).curve(curve).context([context]).x([x]).y0([y0]).y1([y1]),
        l = a.lineY0();
    expect(l.defined(), equals(defined));
    expect(l.curve(), equals(curve));
    expect(l.context(), equals(context));
    expect(l.x(), equals(x));
    expect(l.y(), equals(y0));
  });

  test('area.lineY1() returns a line derived from the area', () {
    var defined = () => true,
        curve = curves.curveCardinal,
        context = {},
        x = ([List<Object> _]) => {},
        y0 = ([List<Object> _]) => {},
        y1 = ([List<Object> _]) => {},
        a = shape.area().defined(defined).curve(curve).context([context]).x([x]).y0([y0]).y1([y1]),
        l = a.lineY1();
    expect(l.defined(), equals(defined));
    expect(l.curve(), equals(curve));
    expect(l.context(), equals(context));
    expect(l.x(), equals(x));
    expect(l.y(), equals(y1));
  });
}
