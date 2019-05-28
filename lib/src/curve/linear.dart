import 'package:d3_shape/curves.dart';

class LinearCurve implements Curve {
  var _context;
  var _point, _line;

  LinearCurve(this._context);

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
    this._point = 0;
  }

  @override
  lineEnd() {
    if ((this._line != null && this._line != 0) || (this._line != 0 && this._point == 1))
      this._context.closePath();
    this._line = 1 - (this._line ?? 0);
  }

  @override
  point(num x, num y) {
    x = x ?? 0;
    y = y ?? 0;
    var line = this._line ?? 0;
    switch (this._point) {
      case 0:
        this._point = 1;
        line != 0 ? this._context.lineTo(x, y) : this._context.moveTo(x, y);
        break;
      case 1:
        this._point = 2; // proceed
        continue line;
      line:
      default:
        this._context.lineTo(x, y);
        break;
    }
  }
}

Function linearCurve() {
  return (context) {
    return LinearCurve(context);
  };
}
