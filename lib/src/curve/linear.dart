class Linear {
  var _context;
  var _point, _line;

  Linear(this._context);

  areaStart() {
    this._line = 0;
  }

  areaEnd() {
    this._line = null;
  }

  lineStart() {
    this._point = 0;
  }

  lineEnd() {
    if (this._line ?? this._line != 0 ? this._point == 1 : 0)
      this._context.closePath();
    this._line = 1 - (this._line ?? 0);
  }

  point(num x, num y) {
    x = x ?? 0;
    y = y ?? 0;
    switch (this._point) {
      case 0:
        this._point = 1;
        this._line != null ? this._context.lineTo(x, y) : this._context.moveTo(x, y);
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

Linear curveLinear(context) {
  return Linear(context);
}
