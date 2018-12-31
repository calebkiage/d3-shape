import 'package:d3_path/d3_path.dart';
import 'package:d3_shape/constant.dart';
import 'package:d3_shape/math.dart';
import 'package:d3_shape/src/model.dart';

String _arcFunction(data, parent) {
  var buffer;
  num r;
  num r0 = parent._innerRadius(data) ?? 0;
  num r1 = parent._outerRadius(data) ?? 0;
  num a0 =
      parent._startAngle(data) != null ? parent._startAngle(data) - halfPi : 0;
  num a1 = parent._endAngle(data) != null ? parent._endAngle(data) - halfPi : 0;
  num da = abs(a1 - a0);
  bool cw = a1 > a0;

  if (parent._context == null) parent._context = buffer = path();

  // Ensure that the outer radius is always larger than the inner radius.
  if (r1 < r0) {
    r = r1;
    r1 = r0;
    r0 = r;
  }

  // Is it a point?
  if (!(r1 > epsilon))
    parent._context.moveTo(0, 0);

  // Or is it a circle or annulus?
  else if (da > tau - epsilon) {
    parent._context.moveTo(r1 * cos(a0), r1 * sin(a0));
    parent._context.arc(0, 0, r1, a0, a1, !cw);
    if (r0 > epsilon) {
      parent._context.moveTo(r0 * cos(a1), r0 * sin(a1));
      parent._context.arc(0, 0, r0, a1, a0, cw);
    }
  }

  // Or is it a circular or annular sector?
  else {
    var rp_0 = (parent._padRadius != null
            ? parent._padRadius(data)
            : sqrt(r0 * r0 + r1 * r1)) ??
        0;
    var a01 = a0,
        a11 = a1,
        a00 = a0,
        a10 = a1,
        da0 = da,
        da1 = da,
        ap = (parent._padAngle(data) ?? 0) > 0 ? parent._padAngle(data) / 2 : 0,
        rp = ((ap > epsilon) ? rp_0 : 0),
        rc = min(abs(r1 - r0) / 2, parent._cornerRadius(data) ?? 0),
        rc0 = rc,
        rc1 = rc,
        t0,
        t1;

    // Apply padding? Note that since r1 ≥ r0, da1 ≥ da0.
    if (rp > epsilon) {
      var p0 = asin(rp / r0 * sin(ap)), p1 = asin(rp / r1 * sin(ap));
      if ((da0 -= p0 * 2) > epsilon) {
        p0 *= (cw ? 1 : -1);
        a00 += p0;
        a10 -= p0;
      } else {
        da0 = 0;
        a00 = a10 = (a0 + a1) / 2;
      }
      if ((da1 -= p1 * 2) > epsilon) {
        p1 *= (cw ? 1 : -1);
        a01 += p1;
        a11 -= p1;
      } else {
        da1 = 0;
        a01 = a11 = (a0 + a1) / 2;
      }
    }

    var x01 = r1 * cos(a01),
        y01 = r1 * sin(a01),
        x10 = r0 * cos(a10),
        y10 = r0 * sin(a10);

    var x11 = r1 * cos(a11),
        y11 = r1 * sin(a11),
        x00 = r0 * cos(a00),
        y00 = r0 * sin(a00);

    // Apply rounded corners?
    if (rc > epsilon) {
      // Restrict the corner radius according to the sector angle.
      if (da < pi) {
        var oc = da0 > epsilon
                ? _intersect(x01, y01, x00, y00, x11, y11, x10, y10)
                : [x10, y10],
            ax = x01 - oc[0],
            ay = y01 - oc[1],
            bx = x11 - oc[0],
            by = y11 - oc[1],
            kc = 1 /
                sin(acos((ax * bx + ay * by) /
                        (sqrt(ax * ax + ay * ay) * sqrt(bx * bx + by * by))) /
                    2),
            lc = sqrt(oc[0] * oc[0] + oc[1] * oc[1]);
        rc0 = min(rc, (r0 - lc) / (kc - 1));
        rc1 = min(rc, (r1 - lc) / (kc + 1));
      }
    }

    // Is the sector collapsed to a line?
    if (!(da1 > epsilon))
      parent._context.moveTo(x01, y01);

    // Does the sector’s outer ring have rounded corners?
    else if (rc1 > epsilon) {
      t0 = _cornerTangents(x00, y00, x01, y01, r1, rc1, cw);
      t1 = _cornerTangents(x11, y11, x10, y10, r1, rc1, cw);

      parent._context.moveTo(t0.cx + t0.x01, t0.cy + t0.y01);

      // Have the corners merged?
      if (rc1 < rc)
        parent._context.arc(t0.cx, t0.cy, rc1, atan2(t0.y01, t0.x01),
            atan2(t1.y01, t1.x01), !cw);

      // Otherwise, draw the two corners and the ring.
      else {
        parent._context.arc(t0.cx, t0.cy, rc1, atan2(t0.y01, t0.x01),
            atan2(t0.y11, t0.x11), !cw);
        parent._context.arc(0, 0, r1, atan2(t0.cy + t0.y11, t0.cx + t0.x11),
            atan2(t1.cy + t1.y11, t1.cx + t1.x11), !cw);
        parent._context.arc(t1.cx, t1.cy, rc1, atan2(t1.y11, t1.x11),
            atan2(t1.y01, t1.x01), !cw);
      }
    }

    // Or is the outer ring just a circular arc?
    else {
      parent._context.moveTo(x01, y01);
      parent._context.arc(0, 0, r1, a01, a11, !cw);
    }

    // Is there no inner ring, and it’s a circular sector?
    // Or perhaps it’s an annular sector collapsed due to padding?
    if (!(r0 > epsilon) || !(da0 > epsilon))
      parent._context.lineTo(x10, y10);

    // Does the sector’s inner ring (or point) have rounded corners?
    else if (rc0 > epsilon) {
      t0 = _cornerTangents(x10, y10, x11, y11, r0, -rc0, cw);
      t1 = _cornerTangents(x01, y01, x00, y00, r0, -rc0, cw);

      parent._context.lineTo(t0.cx + t0.x01, t0.cy + t0.y01);

      // Have the corners merged?
      if (rc0 < rc)
        parent._context.arc(t0.cx, t0.cy, rc0, atan2(t0.y01, t0.x01),
            atan2(t1.y01, t1.x01), !cw);

      // Otherwise, draw the two corners and the ring.
      else {
        parent._context.arc(t0.cx, t0.cy, rc0, atan2(t0.y01, t0.x01),
            atan2(t0.y11, t0.x11), !cw);
        parent._context.arc(0, 0, r0, atan2(t0.cy + t0.y11, t0.cx + t0.x11),
            atan2(t1.cy + t1.y11, t1.cx + t1.x11), cw);
        parent._context.arc(t1.cx, t1.cy, rc0, atan2(t1.y11, t1.x11),
            atan2(t1.y01, t1.x01), !cw);
      }
    }

    // Or is the inner ring just a circular arc?
    else
      parent._context.arc(0, 0, r0, a10, a00, cw);
  }

  parent._context.closePath();

  if (buffer != null) {
    parent._context = null;
    return "$buffer" ?? null;
  }

  return null;
}

_LazyArcGenerator arc() {
  var gen = _LazyArcGenerator();
  gen.arc = ([data]) {
    return _arcFunction(data, gen);
  };
  return gen;
}

class _LazyArcGenerator {
  var _context = null;
  Function _cornerRadius = constant(0);
  Function _endAngle = _arcEndAngle;
  Function _innerRadius = _arcInnerRadius;
  Function _outerRadius = _arcOuterRadius;
  Function _padAngle = _arcPadAngle;
  Function _padRadius = null;
  Function _startAngle = _arcStartAngle;

  Function _arc;

  set arc(Function _arc) => this._arc = Lazy(_arc);

  call([args]) {
    return this._arc(args);
  }

  List<num> centroid([data]) {
    var r_cache = (_innerRadius(data) ?? 0) + (_outerRadius(data) ?? 0);
    var a_cache = (_startAngle(data) ?? 0) + (_endAngle(data) ?? 0);
    var r = r_cache != 0 ? r_cache / 2 : 0,
        a = a_cache != 0 ? (a_cache / 2 - pi / 2) : 0;
    return [cos(a) * r, sin(a) * r];
  }

  context([value]) {
    if (value != null) {
      _context = value == null ? null : value;
      return this;
    } else {
      return _context;
    }
  }

  cornerRadius([value]) {
    if (value != null) {
      _cornerRadius = value is Function ? value : constant(value);
      return this;
    } else {
      return _cornerRadius;
    }
  }

  endAngle([value]) {
    if (value != null) {
      _endAngle = value is Function ? value : constant(value);
      return this;
    } else {
      return _endAngle;
    }
  }

  innerRadius([value]) {
    if (value != null) {
      _innerRadius = value is Function ? value : constant(value);
      return this;
    } else {
      return _innerRadius;
    }
  }

  outerRadius([value]) {
    if (value != null) {
      _outerRadius = value is Function ? value : constant(value);
      return this;
    } else {
      return _outerRadius;
    }
  }

  padAngle([value]) {
    if (value != null) {
      _padAngle = value is Function ? value : constant(value);
      return this;
    } else {
      return _padAngle;
    }
  }

  padRadius([value]) {
    if (value != null) {
      _padRadius = value is Function ? value : constant(value);
      return this;
    } else {
      return _padRadius;
    }
  }

  startAngle([value]) {
    if (value != null) {
      _startAngle = value is Function ? value : constant(value);
      return this;
    } else {
      return _startAngle;
    }
  }
}

_intersect(num x0, num y0, num x1, num y1, num x2, num y2, num x3, num y3) {
  var x10 = x1 - x0,
      y10 = y1 - y0,
      x32 = x3 - x2,
      y32 = y3 - y2,
      t = (x32 * (y0 - y2) - y32 * (x0 - x2)) / (y32 * x10 - x32 * y10);
  return [x0 + t * x10, y0 + t * y10];
}

// Compute perpendicular offset line of length rc.
// http://mathworld.wolfram.com/Circle-LineIntersection.html
_cornerTangents(num x0, num y0, num x1, num y1, num r1, num rc, bool cw) {
  var x01 = x0 - x1,
      y01 = y0 - y1,
      lo = (cw ? rc : -rc) / sqrt(x01 * x01 + y01 * y01),
      ox = lo * y01,
      oy = -lo * x01,
      x11 = x0 + ox,
      y11 = y0 + oy,
      x10 = x1 + ox,
      y10 = y1 + oy,
      x00 = (x11 + x10) / 2,
      y00 = (y11 + y10) / 2,
      dx = x10 - x11,
      dy = y10 - y11,
      d2 = dx * dx + dy * dy,
      r = r1 - rc,
      D = x11 * y10 - x10 * y11,
      d = (dy < 0 ? -1 : 1) * sqrt(max(0, r * r * d2 - D * D)),
      cx0 = (D * dy - dx * d) / d2,
      cy0 = (-D * dx - dy * d) / d2,
      cx1 = (D * dy + dx * d) / d2,
      cy1 = (-D * dx + dy * d) / d2,
      dx0 = cx0 - x00,
      dy0 = cy0 - y00,
      dx1 = cx1 - x00,
      dy1 = cy1 - y00;

  // Pick the closer of the two intersection points.
  // TODO Is there a faster way to determine which intersection to use?
  if (dx0 * dx0 + dy0 * dy0 > dx1 * dx1 + dy1 * dy1) {
    cx0 = cx1;
    cy0 = cy1;
  }

  var result = _CornerTangentsResult(
    cx: cx0,
    cy: cy0,
    x01: -ox,
    y01: -oy,
    x11: cx0 * (r1 / r - 1),
    y11: cy0 * (r1 / r - 1),
  );

  return result;
}

class _CornerTangentsResult {
  final num cx;
  final num cy;
  final num x01;
  final num y01;
  final num x11;
  final num y11;

  _CornerTangentsResult({
    this.cx,
    this.cy,
    this.x01,
    this.y01,
    this.x11,
    this.y11,
  });
}

num _arcInnerRadius(d) {
  return d is ArcData ? d.innerRadius : 0;
}

num _arcOuterRadius(d) {
  return d is ArcData ? d.outerRadius : 0;
}

num _arcStartAngle(d) {
  return d is ArcData ? d.startAngle : 0;
}

num _arcEndAngle(d) {
  return d is ArcData ? d.endAngle : 0;
}

num _arcPadAngle(d) {
  return d is ArcData ? d?.padAngle : 0; // Note: optional!
}
