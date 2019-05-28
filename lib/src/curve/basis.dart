import 'package:d3_shape/src/curve/curve.dart';

_pointFn(that, x, y) {
  that._context.bezierCurveTo(
      (2 * that._x0 + that._x1) / 3,
      (2 * that._y0 + that._y1) / 3,
      (that._x0 + 2 * that._x1) / 3,
      (that._y0 + 2 * that._y1) / 3,
      (that._x0 + 4 * that._x1 + x) / 6,
      (that._y0 + 4 * that._y1 + y) / 6);
}

class BasisCurve implements Curve {
  dynamic _context;
  var _point, _line;
  var _x0, _x1, _y0, _y1;

  BasisCurve(this._context);

  @override
  areaStart() {
    this._line = 0;
  }

  @override
  areaEnd() {
    this._line = null;
  }

  @override
  lineStart() {
    this._x0 = this._x1 = this._y0 = this._y1 = null;
    this._point = 0;
  }

  @override
  lineEnd() {
    switch (this._point) {
      case 3:
        _pointFn(this, this._x1, this._y1);
        // proceed
        continue line;
      line:
      case 2:
        this._context.lineTo(this._x1, this._y1);
        break;
    }
    if ((this._line != null && this._line != 0) || (this._line != 0 && this._point == 1))
      this._context.closePath();
    this._line = 1 - (this._line ?? 0);
  }

  @override
  point(num x, num y) {
    x = x ?? 0;
    y = y ?? 0;
    switch (this._point) {
      case 0:
        this._point = 1;
        (this._line != null && this._line != 0) ? this._context.lineTo(x, y) : this._context.moveTo(x, y);
        break;
      case 1:
        this._point = 2;
        break;
      case 2:
        this._point = 3;
        this._context.lineTo((5 * this._x0 + this._x1) / 6,
            (5 * this._y0 + this._y1) / 6); // proceed
        continue point;
      point:
      default:
        _pointFn(this, x, y);
        break;
    }

    this._x0 = this._x1;
    this._x1 = x;
    this._y0 = this._y1;
    this._y1 = y;
  }
}

Function basisCurve() {
  return (context) {
    return BasisCurve(context);
  };
}
