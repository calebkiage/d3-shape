import 'package:d3_path/d3_path.dart';
import 'package:d3_shape/constant.dart';
import 'package:d3_shape/src/model.dart';
import 'package:d3_shape/src/point.dart' as point;
import 'package:d3_shape/src/curve/linear.dart';
import 'package:d3_shape/src/line.dart';

String _areaFunction(data, parent) {
  var i,
      j,
      k,
      n = data.length,
      d,
      defined0 = false,
      buffer,
      x0z = List(n),
      y0z = List(n);

  if (parent._context == null) parent._output = parent._curve(buffer = path());

  for (i = 0; i <= n; ++i) {
    if (!(i < n && (parent._defined(d = data[i], i, data) ?? false)) ==
        defined0) {
      defined0 = !defined0;
      if (defined0) {
        j = i;
        parent._output.areaStart();
        parent._output.lineStart();
      } else {
        parent._output.lineEnd();
        parent._output.lineStart();
        for (k = i - 1; k >= j; --k) {
          var __x = x0z[k] is num ? x0z[k] : 0;
          var __y = y0z[k] is num ? y0z[k] : 0;
          parent._output.point(__x, __y);
        }
        parent._output.lineEnd();
        parent._output.areaEnd();
      }
    }
    if (defined0) {
      x0z[i] = parent._x0(d, i, data) ?? 0;
      y0z[i] = parent._y0(d, i, data) ?? 0;

      var __x1 = parent._x1 != null ? parent._x1(d, i, data) : x0z[i];
      var __y1 = parent._y1 != null ? parent._y1(d, i, data) : y0z[i];
      if (__x1 is! num) {
        __x1 = null;
      }
      if (__y1 is! num) {
        __y1 = null;
      }
      parent._output.point(__x1, __y1);
    }
  }

  if (buffer != null) {
    parent._output = null;
    return '$buffer'.isEmpty ? null : '$buffer';
  }

  return null;
}

_LazyAreaGenerator area() {
  var gen = _LazyAreaGenerator();
  gen.area = ([data]) {
    return _areaFunction(data, gen);
  };
  return gen;
}

class _LazyAreaGenerator {
  var _x0 = point.x,
      _x1 = null,
      _y0 = constant(0),
      _y1 = point.y,
      _defined = constant(true);
  dynamic _context = null,
      _curve = curveLinear,
      _output = null;

  Function _area;

  set area(Function _area) => this._area = Lazy(_area);

  get lineX0 => _line0;
  get lineY0 => _line0;

  _areaLine() {
    return line().defined(this._defined).curve(this._curve).context(this._context);
  }

  call([args]) {
    return this._area(args);
  }

  context([List<Object> arguments]) {
    if (arguments != null && arguments.length > 0) {
      var value = arguments.first;
      if (value == null) {
        this._context = this._output = null;
      } else {
        this._output = this._curve(this._context = value);
      }

      return this;
    } else {
      return this._context;
    }
  }

  curve([value]) {
    if (value != null) {
      this._curve = value;

      if (this._context != null) {
        this._output = this._curve(this._context);
      }

      this._curve = value is Function ? value : constant(value);
      return this;
    } else {
      return this._curve;
    }
  }

  defined([datum, int index, data]) {
    if (datum != null) {
      if (datum is Function) {
        this._defined = datum;
      } else {
        var defined = datum != 0 && datum != null && datum?.length > 0;
        this._defined = constant(defined);
      }
      return this;
    } else {
      return this._defined;
    }
  }

  x([List<Object> arguments]) {
    if (arguments != null && arguments.length > 0) {
      var datum = arguments.first;
      this._x0 = datum is Function ? datum : constant(datum);
      this._x1 = null;
      return this;
    } else {
      return this._x0;
    }
  }

  x0([List<Object> arguments]) {
    if (arguments != null && arguments.length > 0) {
      var datum = arguments.first;
      this._x0 = datum is Function ? datum : constant(datum);
      return this;
    } else {
      return this._x0;
    }
  }

  x1([List<Object> arguments]) {
    if (arguments != null && arguments.length > 0) {
      var datum = arguments.first;
      this._x1 = datum == null ? null : datum is Function ? datum : constant(datum);
      return this;
    } else {
      return this._x1;
    }
  }

  y([List<Object> arguments]) {
    if (arguments != null && arguments.length > 0) {
      var datum = arguments.first;
      this._y0 = datum is Function ? datum : constant(datum);
      this._y1 = null;
      return this;
    } else {
      return this._y0;
    }
  }

  y0([List<Object> arguments]) {
    if (arguments != null && arguments.length > 0) {
      var datum = arguments.first;
      this._y0 = datum is Function ? datum : constant(datum);
      return this;
    } else {
      return this._y0;
    }
  }

  y1([List<Object> arguments]) {
    if (arguments != null && arguments.length > 0) {
      var datum = arguments.first;
      this._y1 = datum == null ? null : datum is Function ? datum : constant(datum);
      return this;
    } else {
      return this._y1;
    }
  }

  _line0() {
    return this._areaLine().x([this.x0]).y([this.y0]);
  }

  lineX1() {
    return this._areaLine().x([this.x1]).y([this.y0]);
  }

  lineY1() {
    return this._areaLine().x([this.x0]).y([this.y1]);
  }
}
