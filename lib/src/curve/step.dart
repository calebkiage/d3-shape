import 'package:d3_shape/curves.dart';

class StepCurve implements Curve {
  var _context, _t;
  var _line, _point, _x, _y;

  StepCurve(this._context, this._t);

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
    this._x = this._y = null;
    this._point = 0;
  }

  @override
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

  @override
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

Function stepCurve() {
  return (context) {
    return StepCurve(context, 0.5);
  };
}

Function stepAfterCurve() {
  return (context) {
    return StepCurve(context, 1);
  };
}

Function stepBeforeCurve() {
  return (context) {
    return StepCurve(context, 0);
  };
}