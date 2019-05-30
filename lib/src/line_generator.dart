import 'package:d3_path/d3_path.dart';
import 'package:d3_shape/constant.dart';
import 'package:d3_shape/curves.dart' as curves;
import 'package:d3_shape/d3_shape.dart';

class LineGenerator implements ShapeGenerator {
  bool _drawn = false;
  dynamic _context = null, _curve = curves.linearCurve(), _output = null;
  Function _defined = constant(true), _x = UntypedPoint.x, _y = UntypedPoint.y;

  LineGenerator context(value) {
    if (value == null) {
      this._context = this._output = null;
    } else {
      this._context = value;
      this._output = this._curve(this._context);
    }

    return this;
  }

  LineGenerator curve(value) {
    this._curve = value is Function ? value : constant(value);

    if (this._context != null) {
      this._output = this._curve(this._context);
    }

    return this;
  }

  LineGenerator defined(value) {
    if (value != null) {
      this._defined = value is Function ? value : constant(true);
    } else {
      this._defined = constant(false);
    }

    return this;
  }

  @override
  Line generate({data}) {
    return new Line(this._context, this._curve, this._defined, this._output,
        this._x, this._y, data);
  }

  LineGenerator x(value) {
    this._x = value is Function ? value : constant(value);
    return this;
  }

  LineGenerator y(value) {
    this._y = value is Function ? value : constant(value);
    return this;
  }
}

class Line implements Shape {
  bool _drawn = false;
  dynamic _context = null, _curve = curves.linearCurve(), _output = null;
  Function _defined = constant(true), _x = UntypedPoint.x, _y = UntypedPoint.y;
  var _data = [];

  Line(this._context, this._curve, this._defined, this._output, this._x,
      this._y, this._data);

  get context => this._context;

  get curve => this._curve;

  get defined => this._defined;

  get x => this._x;

  get y => this._y;

  @override
  String draw() {
    var i, n = this._data.length, d, defined0 = false, buffer;

    if (this._context == null) {
      buffer = path();
      this._setContext(buffer);
    }

    if (this._drawn) {
      return _processOutput(buffer);
    }

    for (i = 0; i <= n; i++) {
      var def = false;
      if (i < n) {
        d = this._data[i];
        def = this._defined(d, i, this._data) ?? false;
      }

      if (!(i < n && def) == defined0) {
        defined0 = !defined0;
        if (defined0) {
          this._output.lineStart();
        } else {
          this._output.lineEnd();
        }
      }
      if (defined0) {
        var __x = this._x(d, i, this._data);
        var __y = this._y(d, i, this._data);
        this._output.point(__x is num ? __x : 0, __y is num ? __y : 0);
      }
    }

    this._drawn = true;
    return _processOutput(buffer);
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
