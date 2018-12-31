class ShapeData {}

class Shape {}

class ArcData extends ShapeData {
  final double cornerRadius;
  final double endAngle;
  final double innerRadius;
  final double outerRadius;
  final double padAngle;
  final double padRadius;
  final double startAngle;

  ArcData({
    this.cornerRadius,
    this.endAngle,
    this.innerRadius,
    this.outerRadius,
    this.padAngle,
    this.padRadius,
    this.startAngle,
  });
}

class LineData extends ShapeData {
  final context;
  final curve;
  final num x;
  final num y;

  LineData({this.context, this.curve, this.x, this.y});
}

class Lazy<TArgs, TReturn> {
  final Function _func;

  const Lazy(this._func);

  TReturn call([TArgs args]) {
    return _func(args);
  }
}