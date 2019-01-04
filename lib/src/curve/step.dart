class Step {
  var _context, _t;
  var _line, _point, _x, _y;

  Step(this._context, this._t);

  areaStart() {
    this._line = 0;
  }

  areaEnd() {
    this._line = null;
  }

  lineStart() {
    this._x = this._y = null;
    this._point = 0;
  }

  lineEnd() {
    if (0 < this._t && this._t < 1 && this._point == 2)
      this._context.lineTo(this._x, this._y);
    if ((this._line != null && this._line != 0) || (this._line != 0 && this._point == 1))
      this._context.closePath();
    var t = this._t ?? 0;
    var line = this._line ?? 0;
    if (line >= 0) {
      this._t = 1 - t;
      this._line = 1 - line;
    }
  }

  point(x, y) {
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
        continue _default;
      _default:
      default: {
        if (this._t <= 0) {
          this._context.lineTo(this._x, y);
          this._context.lineTo(x, y);
        } else {
          var x1 = this._x * (1 - this._t) + x * this._t;
          this._context.lineTo(x1, this._y);
          this._context.lineTo(x1, y);
        }
        break;
      }
    }

    this._x = x;
    this._y = y;
  }
}

Step curveStep(context) {
  return Step(context, 0.5);
}

Step curveStepAfter(context) {
  return Step(context, 1);
}

Step curveStepBefore(context) {
  return Step(context, 0);
}