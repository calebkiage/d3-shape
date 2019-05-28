import 'package:d3_shape/d3_shape.dart' as shape;

main() {
  var arc = shape.ArcGenerator().draw();
  print('Arc: ${arc}');
}
