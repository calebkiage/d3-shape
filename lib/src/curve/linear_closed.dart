import '../noop.dart';

class LinearClosed {
  var _context;
  var _point;

  LinearClosed(this._context);

  Function areaStart = noop;
  Function areaEnd = noop;

  lineStart() {
    this._point = 0;
  }

  lineEnd() {
    if (this._point != 0 && this._point != null) this._context.closePath();
  }

  point(num x, num y) {
    x = x ?? 0;
    y = y ?? 0;
    if (this._point != null && this._point != 0) {
      this._context.lineTo(x, y);
    }
    else {
      this._point = 1;
      this._context.moveTo(x, y);
    }
  }
}

LinearClosed curveLinearClosed(context) {
  return LinearClosed(context);
}
