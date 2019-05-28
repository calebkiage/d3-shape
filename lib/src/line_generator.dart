import 'package:d3_path/d3_path.dart';
import 'package:d3_shape/constant.dart';
import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart';
import 'package:d3_shape/util.dart';

class LineGenerator implements ShapeGenerator {
  bool _drawn = false;
  dynamic _context = null,
      _curve = curves.linearCurve(),
      output = null;
  Function _defined = constant(true), _x = UntypedPoint.x, _y = UntypedPoint.y;

  get context {
    return this._context;
  }

  set context(value) {
    if (value == null) {
      this._context = this.output = null;
    } else {
      this._context = value;
      this.output = this._curve(this._context);
    }
  }

  get curve {
    return this._curve;
  }

  set curve(value) {
    this._curve = value is Function ? value : constant(value);

    if (this.context != null) {
      this.output = this._curve(this.context);
    }
  }

  Function get defined {
    return this._defined;
  }

  set defined(value) {
    if (value != null) {
      this._defined = value is Function ? value : constant(true);
    } else {
      this._defined = constant(false);
    }
  }

  @override
  draw([data]) {
    if (this._drawn) {
      throw new DrawException("The draw method can only be called once.");
    }

    var i,
        n = data.length,
        d,
        defined0 = false,
        buffer;

    if (this.context == null) {
      buffer = path();
      this.context = buffer;
    }

    for (i = 0; i <= n; i++) {
      var def = false;
      if (i < n) {
        d = data[i];
        def = this.defined(d, i, data) ?? false;
      }

      if (!(i < n && def) == defined0) {
        defined0 = !defined0;
        if (defined0) {
          this.output.lineStart();
        } else {
          this.output.lineEnd();
        }
      }
      if (defined0) {
        var __x = this.x(d, i, data);
        var __y = this.y(d, i, data);
        this.output.point(__x is num ? __x : 0, __y is num ? __y : 0);
      }
    }

    this._drawn = true;
    if (buffer != null) {
      this.output = null;
      return "$buffer".isEmpty ? null : "$buffer";
    }

    return null;
  }

  get x {
    return this._x;
  }

  set x(value) {
    this._x = value is Function ? value : constant(value);
  }

  get y {
    return this._y;
  }

  set y(value) {
    this._y = value is Function ? value : constant(value);
  }
}
