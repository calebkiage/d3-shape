import 'package:d3_shape/curves.dart';
import 'package:d3_shape/src/curve/curve.dart';

class BasisClosedCurve implements Curve {
  dynamic _context;
  var _point;
  var _x0, _x1, _x2, _x3, _x4, _y0, _y1, _y2, _y3, _y4;

  BasisClosedCurve(this._context);

  dynamic get context => this._context;
  get x0 => this._x0;
  get x1 => this._x1;
  get y0 => this._y0;
  get y1 => this._y1;

  @override
  areaStart() {}

  @override
  areaEnd() {}

  @override
  lineStart() {
    this._x0 = this._x1 = this._x2 = this._x3 = this._x4 =
        this._y0 = this._y1 = this._y2 = this._y3 = this._y4 = double.nan;
    this._point = 0;
  }

  @override
  lineEnd() {
    switch (this._point) {
      case 1:
        {
          this._context.moveTo(this._x2, this._y2);
          this._context.closePath();
          break;
        }
      case 2:
        {
          this._context.moveTo(
              (this._x2 + 2 * this._x3) / 3, (this._y2 + 2 * this._y3) / 3);
          this._context.lineTo(
              (this._x3 + 2 * this._x2) / 3, (this._y3 + 2 * this._y2) / 3);
          this._context.closePath();
          break;
        }
      case 3:
        {
          this.point(this._x2, this._y2);
          this.point(this._x3, this._y3);
          this.point(this._x4, this._y4);
          break;
        }
    }
  }

  @override
  point(num x, num y) {
    x = x ?? 0;
    y = y ?? 0;
    switch (this._point) {
      case 0:
        this._point = 1;
        this._x2 = x;
        this._y2 = y;
        break;
      case 1:
        this._point = 2;
        this._x3 = x;
        this._y3 = y;
        break;
      case 2:
        this._point = 3;
        this._x4 = x;
        this._y4 = y;
        this._context.moveTo((this._x0 + 4 * this._x1 + x) / 6,
            (this._y0 + 4 * this._y1 + y) / 6);
        break;
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

Function basisClosedCurve() {
  return (context) {
    return BasisClosedCurve(context);
  };
}
