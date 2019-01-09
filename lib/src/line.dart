import 'package:d3_path/d3_path.dart';
import 'package:d3_shape/constant.dart';
import 'package:d3_shape/src/model.dart';
import 'package:d3_shape/src/point.dart' as point;
import 'package:d3_shape/src/curve/linear.dart';

String _lineFunction(data, parent) {
  var i,
      n = data.length,
      d,
      defined0 = false,
      buffer;

  if (parent._context == null) parent._output = parent._curve(buffer = path());

  for (i = 0; i <= n; i++) {
    if (!(i < n && (parent._defined(d = data[i], i, data) ?? false)) == defined0) {
      defined0 = !defined0;
      if (defined0) {
        parent._output.lineStart();
      } else {
        parent._output.lineEnd();
      }
    }
    if (defined0) {
      var __x = parent._x(d, i, data);
      var __y = parent._y(d, i, data);
      parent._output.point(__x, __y is num ? __y : 0);
    }
  }

  if (buffer != null) {
    parent._output = null;
    return '$buffer'.isEmpty ? null : '$buffer';
  }

  return null;
}

_LazyLineGenerator line() {
  var gen = _LazyLineGenerator();
  gen.line = ([data]) {
    return _lineFunction(data, gen);
  };
  return gen;
}

class _LazyLineGenerator {
  dynamic _x = point.x,
      _y = point.y;
  var _defined = constant(true);
  dynamic _context = null,
      _curve = curveLinear,
      _output = null;

  Function _line;

  set line(Function _line) => this._line = Lazy(_line);

  call([args]) {
    return this._line(args);
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
      this._defined = datum is Function ? datum : constant(!!datum);
      return this;
    } else {
      return this._defined;
    }
  }

  x([List<Object> arguments]) {
    if ((arguments?.length ?? 0) > 0) {
      var datum = arguments.first;
      this._x = datum is Function ? datum : constant(datum);
      return this;
    } else {
      return this._x;
    }
  }

  y([List<Object> arguments]) {
    if ((arguments?.length ?? 0) > 0) {
      var datum = arguments.first;
      this._y = datum is Function ? datum : constant(datum);
      return this;
    } else {
      return this._y;
    }
  }
}
