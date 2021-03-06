import 'package:d3_shape/curves.dart';

_pointFn(that, x, y) {
  that._context.bezierCurveTo(
      that._x1 + that._k * (that._x2 - that._x0),
      that._y1 + that._k * (that._y2 - that._y0),
      that._x2 + that._k * (that._x1 - x),
      that._y2 + that._k * (that._y1 - y),
      that._x2,
      that._y2
  );
}

class CardinalCurve implements Curve {
  dynamic _context;
  var _k;
  var _point, _line;
  var _x0, _x1, _x2, _y0, _y1, _y2;

  CardinalCurve([this._context, num tension = 0]) {
    this._k = (1 - tension) / 6;
  }

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
    this._x0 = this._x1 = this._x2 = this._y0 = this._y1 = this._y2 = null;
    this._point = 0;
  }

  @override
  lineEnd() {
    switch (this._point) {
      case 2:
        this._context.lineTo(this._x2, this._y2);
        break;
      case 3:
        _pointFn(this, this._x1, this._y1); break;
    }
    if ((this._line != null && this._line != 0) || (this._line != 0 && this._point == 1)) {
      this._context.closePath();
    }
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
        this._x1 = x;
        this._y1 = y;
        break;
      case 2:
        this._point = 3; // proceed
        continue point;
      point:
      default:
        _pointFn(this, x, y);
        break;
    }

    this._x0 = this._x1;
    this._x1 = this._x2;
    this._x2 = x;
    this._y0 = this._y1;
    this._y1 = this._y2;
    this._y2 = y;
  }
}

Function curveCardinal({tension = 0}) {
  num t = 0;

  if (tension is String) {
    t = (double.tryParse(tension) ?? 0);
  } else if (tension is num) {
    t = tension ?? 0;
  }

  return (context) {
    return CardinalCurve(context, t);
  };
}
