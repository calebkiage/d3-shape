import 'package:matcher/matcher.dart';

var reNumber = RegExp(r'[-+]?(?:\d+\.\d+|\d+\.|\.\d+|\d+)(?:[eE][-]?\d+)?');

Matcher pathEqual(String expected) => _PathMatcher(expected);

class _PathMatcher extends Matcher {
  final String _value;

  _PathMatcher(this._value);

  @override
  Description describe(Description description) {
    return null;
  }

  @override
  bool matches(item, Map matchState) {
    var actual = _normalizePath('${item}');

    return actual == this._value;
  }

  _normalizePath(String path) {
    return path.replaceAllMapped(reNumber, (m) {
      var match = m[0];
      var n = num.tryParse(match);
      return _formatNumber(n);
    });
  }

  String _formatNumber(num s) {
    return '${(s - s.round()).abs() < 1e-6 ? s.round() : s.toStringAsFixed(6)}';
  }
}