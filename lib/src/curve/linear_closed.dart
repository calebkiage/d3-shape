import 'package:d3_shape/curves.dart';

class LinearClosedCurve implements Curve {
  var _context;
  var _point;

  LinearClosedCurve(this._context);

  @override
  areaEnd() {}

  @override
  areaStart() {}

  @override
  lineStart() {
    this._point = 0;
  }

  @override
  lineEnd() {
    if (this._point != 0 && this._point != null) this._context.closePath();
  }

  @override
  point(num x, num y) {
    x = x ?? 0;
    y = y ?? 0;
    if (this._point != null && this._point != 0) {
      this._context.lineTo(x, y);
    } else {
      this._point = 1;
      this._context.moveTo(x, y);
    }
  }
}

Function linearClosedCurve() {
  return (context) {
    return LinearClosedCurve(context);
  };
}
