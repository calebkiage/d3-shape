import 'package:d3_shape/curves.dart';

class BasisOpenCurve implements Curve {
  dynamic _context;
  var _point, _line;
  var _x0, _x1, _y0, _y1;

  BasisOpenCurve(this._context);

  dynamic get context => this._context;

  get x0 => this._x0;

  get x1 => this._x1;

  get y0 => this._y0;

  get y1 => this._y1;

  @override
  areaStart() {
    this._line = 0;
  }

  @override
  areaEnd() {
    this._line = double.nan;
  }

  @override
  lineStart() {
    this._x0 = this._x1 = this._y0 = this._y1 = double.nan;
    this._point = 0;
  }

  @override
  lineEnd() {
    var lineNotEmpty = this._line != null && this._line != 0;
    if (lineNotEmpty || (this._line != 0 && this._point == 3)) {
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
        break;
      case 1:
        this._point = 2;
        break;
      case 2:
        this._point = 3;
        var x0 = (this._x0 + 4 * this._x1 + x) / 6,
            y0 = (this._y0 + 4 * this._y1 + y) / 6;
        var lineNotEmpty = this._line != null && this._line != 0;
        lineNotEmpty ? this._context.lineTo(x0, y0) : this._context
            .moveTo(x0, y0);
        break;
      case 3:
        this._point = 4; // proceed
        continue defaultLabel;
      defaultLabel:
      default:
        basisPointFn(this, x, y);
        break;
    }
    this._x0 = this._x1;
    this._x1 = x;
    this._y0 = this._y1;
    this._y1 = y;
  }
}

Function basisOpenCurve() {
  return (context) {
    return BasisOpenCurve(context);
  };
}
