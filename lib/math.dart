import 'dart:math' as Math;

Function atan2 = Math.atan2;
Function cos = Math.cos;
Function max = Math.max;
Function min = Math.min;
Function sin = Math.sin;
Function sqrt = Math.sqrt;

const double epsilon = 1e-12;
const double pi = Math.pi;
const double halfPi = pi / 2;
const double tau = 2 * pi;

num abs(num x) {
  return x != null ? x.abs() : null;
}

double acos(x) {
  return x > 1 ? 0 : x < -1 ? pi : Math.acos(x);
}

double asin(x) {
  return x >= 1 ? halfPi : x <= -1 ? -halfPi : Math.asin(x);
}
