import 'package:d3_path/d3_path.dart';
import 'package:d3_shape/constant.dart';
import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart';
import 'package:d3_shape/util.dart';

class AreaGenerator implements ShapeGenerator {
  bool _drawn = false;
  dynamic _context = null,
      _curve = curves.linearCurve(),
      output = null;
  Function _defined = constant(true),
      _x0 = UntypedPoint.x,
      _x1,
      _y0 = constant(0),
      _y1 = UntypedPoint.y;

  get lineX0 => this._line0;
  get lineY0 => this._line0;

  LineGenerator _areaLine() {
    var l = LineGenerator();
    l.defined = this.defined;
    l.curve = this.curve;
    l.context = this.context;
    return l;
  }

  LineGenerator _line0() {
    var l = this._areaLine();
    l.x = this.x0;
    l.y = this.y0;
    return l;
  }

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
    //print("is function: ${value is Function}");
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
        j,
        k,
        n = data.length,
        d,
        defined0 = false,
        buffer,
        x0z = List(n),
        y0z = List(n);

    if (this.context == null) {
      buffer = path();
      this.context = buffer;
    }

    for (i = 0; i <= n; ++i) {
      var def = false;
      if (i < n) {
        d = data[i];
        def = this.defined(d, i, data) ?? false;
      }

      if (!(i < n && def) == defined0) {
        defined0 = !defined0;
        if (defined0) {
          j = i;
          this.output.areaStart();
          this.output.lineStart();
        } else {
          this.output.lineEnd();
          this.output.lineStart();
          for (k = i - 1; k >= j; --k) {
            var __x = x0z[k] is num ? x0z[k] : 0;
            var __y = y0z[k] is num ? y0z[k] : 0;
            this.output.point(__x, __y);
          }
          this.output.lineEnd();
          this.output.areaEnd();
        }
      }

      if (defined0) {
        x0z[i] = this.x0(d, i, data) ?? 0;
        y0z[i] = this.y0(d, i, data) ?? 0;

        var __x1 = this.x1 != null ? this.x1(d, i, data) : x0z[i];
        var __y1 = this.y1 != null ? this.y1(d, i, data) : y0z[i];
        if (__x1 is! num) {
          __x1 = null;
        }
        if (__y1 is! num) {
          __y1 = null;
        }
        this.output.point(__x1, __y1);
      }
    }

    if (buffer != null) {
      this.output = null;
      return '$buffer'.isEmpty ? null : '$buffer';
    }

    return null;
  }

  LineGenerator lineX1() {
    var l = this._areaLine();
    l.x = this.x1;
    l.y = this.y0;
    return l;
  }

  LineGenerator lineY1() {
    var l = this._areaLine();
    l.x = this.x0;
    l.y = this.y1;
    return l;
  }

  get x {
    return this._x0;
  }

  set x(value) {
    this._x0 = value is Function ? value : constant(value);
    this._x1 = null;
  }

  get x0 {
    return this._x0;
  }

  set x0(value) {
    this._x0 = value is Function ? value : constant(value);
  }

  get x1 {
    return this._x1;
  }

  set x1(value) {
    this._x1 = value is Function ? value : constant(value);
  }

  get y {
    return this._y0;
  }

  set y(value) {
    this._y0 = value is Function ? value : constant(value);
    this._y1 = null;
  }

  get y0 {
    return this._y0;
  }

  set y0(value) {
    this._y0 = value is Function ? value : constant(value);
  }

  get y1 {
    return this._y1;
  }

  set y1(value) {
    this._y1 = value is Function ? value : constant(value);
  }
}