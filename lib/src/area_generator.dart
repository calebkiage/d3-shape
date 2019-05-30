import 'package:d3_path/d3_path.dart';
import 'package:d3_shape/constant.dart';
import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart';

class AreaGenerator implements ShapeGenerator {
  dynamic _context = null, _curve = curves.linearCurve(), _output = null;
  Function _defined = constant(true),
      _x0 = UntypedPoint.x,
      _x1,
      _y0 = constant(0),
      _y1 = UntypedPoint.y;

  LineGenerator _areaLine() {
    return LineGenerator()
        .context(this._context)
        .curve(this._curve)
        .defined(this._defined);
  }

  LineGenerator _line0() {
    return this._areaLine().x(this._x0).y(this._y0);
  }

  AreaGenerator context(value) {
    if (value == null) {
      this._context = this._output = null;
    } else {
      this._context = value;
      this._output = this._curve(this._context);
    }

    return this;
  }

  @override
  AreaGenerator curve(value) {
    //print("is function: ${value is Function}");
    this._curve = value is Function ? value : constant(value);

    if (this.context != null) {
      this._output = this._curve(this.context);
    }

    return this;
  }

  AreaGenerator defined(value) {
    if (value != null) {
      this._defined = value is Function ? value : constant(true);
    } else {
      this._defined = constant(false);
    }

    return this;
  }

  @override
  Area generate({data}) {
    return new Area(this._context, this._curve, this._defined, this._output,
        this._x0, this._x1, this._y0, this._y1, data);
  }

  LineGenerator lineX0() {
    return this._line0();
  }

  LineGenerator lineX1() {
    return this._areaLine().x(this._x1).y(this._y0);
  }

  LineGenerator lineY0() {
    return this._line0();
  }

  LineGenerator lineY1() {
    return this._areaLine().x(this._x0).y(this._y1);
  }

  AreaGenerator x(value) {
    this._x0 = value is Function ? value : constant(value);
    this._x1 = null;
    return this;
  }

  AreaGenerator x0(value) {
    this._x0 = value is Function ? value : constant(value);
    return this;
  }

  AreaGenerator x1(value) {
    this._x1 = value is Function ? value : constant(value);
    return this;
  }

  AreaGenerator y(value) {
    this._y0 = value is Function ? value : constant(value);
    this._y1 = null;
    return this;
  }

  AreaGenerator y0(value) {
    this._y0 = value is Function ? value : constant(value);
    return this;
  }

  AreaGenerator y1(value) {
    this._y1 = value is Function ? value : constant(value);
    return this;
  }
}

class Area implements Shape {
  bool _drawn = false;
  dynamic _context = null, _curve = curves.linearCurve(), _output = null;
  Function _defined = constant(true),
      _x0 = UntypedPoint.x,
      _x1,
      _y0 = constant(0),
      _y1 = UntypedPoint.y;
  var _data = [];

  Area(this._context, this._curve, this._defined, this._output, this._x0,
      this._x1, this._y0, this._y1, this._data);

  get context => this._context;

  get curve => this._curve;

  get defined => this._defined;

  get x => this._x0;

  get x0 => this._x0;

  get x1 => this._x1;

  get y => this._y0;

  get y0 => this._y0;

  get y1 => this._y1;

  @override
  String draw() {
    var i,
        j,
        k,
        n = this._data.length,
        d,
        defined0 = false,
        buffer,
        x0z = List(n),
        y0z = List(n);

    if (this._context == null) {
      buffer = path();
      this._setContext(buffer);
    }

    if (this._drawn) {
      return this._processOutput(buffer);
    }

    for (i = 0; i <= n; ++i) {
      var def = false;
      if (i < n) {
        d = this._data[i];
        def = this._defined(d, i, this._data) ?? false;
      }

      if (!(i < n && def) == defined0) {
        defined0 = !defined0;
        if (defined0) {
          j = i;
          this._output.areaStart();
          this._output.lineStart();
        } else {
          this._output.lineEnd();
          this._output.lineStart();
          for (k = i - 1; k >= j; --k) {
            var __x = x0z[k] is num ? x0z[k] : 0;
            var __y = y0z[k] is num ? y0z[k] : 0;
            this._output.point(__x, __y);
          }
          this._output.lineEnd();
          this._output.areaEnd();
        }
      }

      if (defined0) {
        x0z[i] = this._x0(d, i, this._data) ?? 0;
        y0z[i] = this._y0(d, i, this._data) ?? 0;

        var __x1 = this._x1 != null ? this._x1(d, i, this._data) : x0z[i];
        var __y1 = this._y1 != null ? this._y1(d, i, this._data) : y0z[i];
        if (__x1 is! num) {
          __x1 = null;
        }
        if (__y1 is! num) {
          __y1 = null;
        }
        this._output.point(__x1, __y1);
      }
    }

    this._drawn = true;
    return this._processOutput(buffer);
  }

  String _processOutput(buffer) {
    if (buffer != null) {
      this._output = null;
      return "$buffer".isEmpty ? null : "$buffer";
    }

    return null;
  }

  _setContext(value) {
    if (value == null) {
      this._context = this._output = null;
    } else {
      this._context = value;
      this._output = this._curve(this._context);
    }
  }
}
