class UntypedPoint {
  static x([p, index, data]) {
    var result = null;

    if (p is Point) {
      result = p.x;
    } else {
      try {
        result = p[0];
      } catch (e) {}
    }

    return result;
  }

  static y([p, index, data]) {
    var result = null;

    if (p is Point) {
      result = p.y;
    } else {
      try {
        result = p[1];
      } catch (e) {}
    }

    return result;
  }
}

class Point {
  Object x, y;

  Point(this.x, this.y);

  Point.origin() {
    this.x = 0;
    this.y = 0;
  }

  @override
  String toString() {
    return "[${this.x}, ${this.y}]";
  }
}
