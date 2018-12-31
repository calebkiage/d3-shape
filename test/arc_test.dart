import 'dart:math' as Math;

import 'package:d3_shape/d3_shape.dart' as shape;
import 'package:test/test.dart';
import 'util/path_equal.dart';

void main() {
  test(
    'arc().cornerRadius(f)(…) propagates the context and arguments to the specified function f',
    () {
      var expected = {
        'that': {},
        'args': [42]
      };
      Map<String, Object> actual;
      var arc = shape.arc();
      var f = ([args]) {
        actual = {
          'that': {},
          'args': args,
        };
      };

      Function.apply(
          arc.outerRadius(100).cornerRadius(f).call, [expected['args']]);
      expect(actual, equals(expected));
    },
  );

  test(
    'arc().endAngle(f)(…) propagates the context and arguments to the specified function f',
    () {
      var expected = {
        'that': {},
        'args': [42]
      };
      Map<String, Object> actual;
      var arc = shape.arc();
      var f = ([args]) {
        actual = {
          'that': {},
          'args': args,
        };
      };

      Function.apply(arc.endAngle(f).call, [expected['args']]);
      expect(actual, equals(expected));
    },
  );

  test(
    'arc().innerRadius(f)(…) propagates the context and arguments to the specified function f',
    () {
      var expected = {
        'that': {},
        'args': [42]
      };
      Map<String, Object> actual;
      var arc = shape.arc();
      var f = ([args]) {
        actual = {
          'that': {},
          'args': args,
        };
      };

      Function.apply(arc.innerRadius(f).call, [expected['args']]);
      expect(actual, equals(expected));
    },
  );

  test(
    'arc().outerRadius(f)(…) propagates the context and arguments to the specified function f',
    () {
      var expected = {
        'that': {},
        'args': [42]
      };
      Map<String, Object> actual;
      var arc = shape.arc();
      var f = ([args]) {
        actual = {
          'that': {},
          'args': args,
        };
      };

      Function.apply(arc.outerRadius(f).call, [expected['args']]);
      expect(actual, equals(expected));
    },
  );

  test(
    'arc().padAngle(f)(…) propagates the context and arguments to the specified function f',
    () {
      var expected = {
        'that': {},
        'args': [42]
      };
      Map<String, Object> actual;
      var arc = shape.arc();
      var f = ([args]) {
        actual = {
          'that': {},
          'args': args,
        };
      };

      Function.apply(
          arc.outerRadius(100).startAngle(Math.pi / 2).padAngle(f).call,
          [expected['args']]);
      expect(actual, equals(expected));
    },
  );

  test(
    'arc().padRadius(f)(…) propagates the context and arguments to the specified function f',
    () {
      var expected = {
        'that': {},
        'args': [42]
      };
      Map<String, Object> actual;
      var arc = shape.arc();
      var f = ([args]) {
        actual = {
          'that': {},
          'args': args,
        };
      };

      Function.apply(
          arc
              .outerRadius(100)
              .startAngle(Math.pi / 2)
              .padAngle(0.1)
              .padRadius(f)
              .call,
          [expected['args']]);
      expect(actual, equals(expected));
    },
  );

  test(
    'arc().startAngle(f)(…) propagates the context and arguments to the specified function f',
    () {
      var expected = {
        'that': {},
        'args': [42]
      };
      Map<String, Object> actual;
      var arc = shape.arc();
      var f = ([args]) {
        actual = {
          'that': {},
          'args': args,
        };
      };

      Function.apply(arc.startAngle(f).call, [expected['args']]);
      expect(actual, equals(expected));
    },
  );

  test(
    'arc().centroid(…) computes the midpoint of the center line of the arc',
    () {
      var a = shape.arc(),
          round = (x) {
        return (x * 1e6).round() / 1e6;
      };
      var data = shape.ArcData(
          innerRadius: 0, outerRadius: 100, startAngle: 0, endAngle: Math.pi);
      expect(a.centroid(data).map((n) => round(n)), unorderedEquals([50, 0]));
      data = shape.ArcData(
          innerRadius: 0,
          outerRadius: 100,
          startAngle: 0,
          endAngle: Math.pi / 2);
      expect(a.centroid(data).map((n) => round(n)),
          unorderedEquals([35.355339, -35.355339]));
      data = shape.ArcData(
          innerRadius: 50, outerRadius: 100, startAngle: 0, endAngle: -Math.pi);
      expect(a.centroid(data).map((n) => round(n)), unorderedEquals([-75, 0]));
      data = shape.ArcData(
          innerRadius: 50,
          outerRadius: 100,
          startAngle: 0,
          endAngle: -Math.pi / 2);
      expect(a.centroid(data).map((n) => round(n)),
          unorderedEquals([-53.033009, -53.033009]));
    },
  );

  test(
    'arc().innerRadius(f).centroid(…) propagates the context and arguments to the specified function f',
    () {
      var expected = {
        'that': {},
        'args': [42]
      };
      Map<String, Object> actual;
      var arc = shape.arc();
      var f = ([args]) {
        actual = {
          'that': {},
          'args': args,
        };
      };

      Function.apply(arc.innerRadius(f).centroid.call, [expected['args']]);
      expect(actual, equals(expected));
    },
  );

  test(
    'arc().outerRadius(f).centroid(…) propagates the context and arguments to the specified function f',
    () {
      var expected = {
        'that': {},
        'args': [42]
      };
      Map<String, Object> actual;
      var arc = shape.arc();
      var f = ([args]) {
        actual = {
          'that': {},
          'args': args,
        };
      };

      Function.apply(arc.outerRadius(f).centroid.call, [expected['args']]);
      expect(actual, equals(expected));
    },
  );

  test(
    'arc().startAngle(f).centroid(…) propagates the context and arguments to the specified function f',
    () {
      var expected = {
        'that': {},
        'args': [42]
      };
      Map<String, Object> actual;
      var arc = shape.arc();
      var f = ([args]) {
        actual = {
          'that': {},
          'args': args,
        };
      };

      Function.apply(arc.startAngle(f).centroid.call, [expected['args']]);
      expect(actual, equals(expected));
    },
  );

  test(
    'arc().endAngle(f).centroid(…) propagates the context and arguments to the specified function f',
    () {
      var expected = {
        'that': {},
        'args': [42]
      };
      Map<String, Object> actual;
      var arc = shape.arc();
      var f = ([args]) {
        actual = {
          'that': {},
          'args': args,
        };
      };

      Function.apply(arc.endAngle(f).centroid.call, [expected['args']]);
      expect(actual, equals(expected));
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(0) renders a point',
    () {
      var arc = shape.arc();
      expect(arc.startAngle(0).endAngle(2 * Math.pi)(), pathEqual('M0,0Z'));
      expect(arc.startAngle(0).endAngle(0)(), 'M0,0Z');
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁) renders a clockwise circle if r > 0 and θ₁ - θ₀ ≥ τ',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(2 * Math.pi)(),
        pathEqual('M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100Z'),
      );
      expect(
        a.startAngle(0).endAngle(3 * Math.pi)(),
        pathEqual('M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(0)(),
        pathEqual('M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(Math.pi)(),
        pathEqual('M0,100A100,100,0,1,1,0,-100A100,100,0,1,1,0,100Z'),
      );
      expect(
        a.startAngle(-3 * Math.pi).endAngle(0)(),
        pathEqual('M0,100A100,100,0,1,1,0,-100A100,100,0,1,1,0,100Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁) renders an anticlockwise circle if r > 0 and θ₀ - θ₁ ≥ τ',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(-2 * Math.pi)(),
        pathEqual('M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100Z'),
      );
      expect(
        a.startAngle(0).endAngle(-3 * Math.pi)(),
        pathEqual('M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(0)(),
        pathEqual('M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(-Math.pi)(),
        pathEqual('M0,100A100,100,0,1,0,0,-100A100,100,0,1,0,0,100Z'),
      );
      expect(
        a.startAngle(3 * Math.pi).endAngle(0)(),
        pathEqual('M0,100A100,100,0,1,0,0,-100A100,100,0,1,0,0,100Z'),
      );
    },
  );

  // Note: The outer ring starts and ends at θ₀, but the inner ring starts and ends at θ₁.
  // Note: The outer ring is clockwise, but the inner ring is anticlockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁) renders a clockwise annulus if r₀ > 0, r₁ > 0 and θ₀ - θ₁ ≥ τ',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(2 * Math.pi)(),
        pathEqual(
            'M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100M0,-50A50,50,0,1,0,0,50A50,50,0,1,0,0,-50Z'),
      );
      expect(
        a.startAngle(0).endAngle(3 * Math.pi)(),
        pathEqual(
            'M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100M0,50A50,50,0,1,0,0,-50A50,50,0,1,0,0,50Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(0)(),
        pathEqual(
            'M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100M0,-50A50,50,0,1,0,0,50A50,50,0,1,0,0,-50Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(Math.pi)(),
        pathEqual(
            'M0,100A100,100,0,1,1,0,-100A100,100,0,1,1,0,100M0,50A50,50,0,1,0,0,-50A50,50,0,1,0,0,50Z'),
      );
      expect(
        a.startAngle(-3 * Math.pi).endAngle(0)(),
        pathEqual(
            'M0,100A100,100,0,1,1,0,-100A100,100,0,1,1,0,100M0,-50A50,50,0,1,0,0,50A50,50,0,1,0,0,-50Z'),
      );
    },
  );

  // Note: The outer ring starts and ends at θ₀, but the inner ring starts and ends at θ₁.
// Note: The outer ring is anticlockwise, but the inner ring is clockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁) renders an anticlockwise annulus if r₀ > 0, r₁ > 0 and θ₁ - θ₀ ≥ τ',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(-2 * Math.pi)(),
        pathEqual(
            'M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100M0,-50A50,50,0,1,1,0,50A50,50,0,1,1,0,-50Z'),
      );
      expect(
        a.startAngle(0).endAngle(-3 * Math.pi)(),
        pathEqual(
            'M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100M0,50A50,50,0,1,1,0,-50A50,50,0,1,1,0,50Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(0)(),
        pathEqual(
            'M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100M0,-50A50,50,0,1,1,0,50A50,50,0,1,1,0,-50Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(-Math.pi)(),
        pathEqual(
            'M0,100A100,100,0,1,0,0,-100A100,100,0,1,0,0,100M0,50A50,50,0,1,1,0,-50A50,50,0,1,1,0,50Z'),
      );
      expect(
        a.startAngle(3 * Math.pi).endAngle(0)(),
        pathEqual(
            'M0,100A100,100,0,1,0,0,-100A100,100,0,1,0,0,100M0,-50A50,50,0,1,1,0,50A50,50,0,1,1,0,-50Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁) renders a small clockwise sector if r > 0 and π > θ₁ - θ₀ ≥ 0',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,0,1,100,0L0,0Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(5 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,0,1,100,0L0,0Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(-Math.pi / 2)(),
        pathEqual('M0,100A100,100,0,0,1,-100,0L0,0Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁) renders a small anticlockwise sector if r > 0 and π > θ₀ - θ₁ ≥ 0',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(-Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,0,0,-100,0L0,0Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(-5 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,0,0,-100,0L0,0Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(Math.pi / 2)(),
        pathEqual('M0,100A100,100,0,0,0,100,0L0,0Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁) renders a large clockwise sector if r > 0 and τ > θ₁ - θ₀ ≥ π',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(3 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,1,1,-100,0L0,0Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(7 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,1,1,-100,0L0,0Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(Math.pi / 2)(),
        pathEqual('M0,100A100,100,0,1,1,100,0L0,0Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁) renders a large anticlockwise sector if r > 0 and τ > θ₀ - θ₁ ≥ π',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(-3 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,1,0,100,0L0,0Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(-7 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,1,0,100,0L0,0Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(-Math.pi / 2)(),
        pathEqual('M0,100A100,100,0,1,0,-100,0L0,0Z'),
      );
    },
  );

// Note: The outer ring is clockwise, but the inner ring is anticlockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁) renders a small clockwise annular sector if r₀ > 0, r₁ > 0 and π > θ₁ - θ₀ ≥ 0',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,0,1,100,0L50,0A50,50,0,0,0,0,-50Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(5 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,0,1,100,0L50,0A50,50,0,0,0,0,-50Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(-Math.pi / 2)(),
        pathEqual('M0,100A100,100,0,0,1,-100,0L-50,0A50,50,0,0,0,0,50Z'),
      );
    },
  );

// Note: The outer ring is anticlockwise, but the inner ring is clockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁) renders a small anticlockwise annular sector if r₀ > 0, r₁ > 0 and π > θ₀ - θ₁ ≥ 0',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(-Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,0,0,-100,0L-50,0A50,50,0,0,1,0,-50Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(-5 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,0,0,-100,0L-50,0A50,50,0,0,1,0,-50Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(Math.pi / 2)(),
        pathEqual('M0,100A100,100,0,0,0,100,0L50,0A50,50,0,0,1,0,50Z'),
      );
    },
  );

// Note: The outer ring is clockwise, but the inner ring is anticlockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁) renders a large clockwise annular sector if r₀ > 0, r₁ > 0 and τ > θ₁ - θ₀ ≥ π',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(3 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,1,1,-100,0L-50,0A50,50,0,1,0,0,-50Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(7 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,1,1,-100,0L-50,0A50,50,0,1,0,0,-50Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(Math.pi / 2)(),
        pathEqual('M0,100A100,100,0,1,1,100,0L50,0A50,50,0,1,0,0,50Z'),
      );
    },
  );

// Note: The outer ring is anticlockwise, but the inner ring is clockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁) renders a large anticlockwise annular sector if r₀ > 0, r₁ > 0 and τ > θ₀ - θ₁ ≥ π',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100);
      expect(
        a.startAngle(0).endAngle(-3 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,1,0,100,0L50,0A50,50,0,1,1,0,-50Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(-7 * Math.pi / 2)(),
        pathEqual('M0,-100A100,100,0,1,0,100,0L50,0A50,50,0,1,1,0,-50Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(-Math.pi / 2)(),
        pathEqual('M0,100A100,100,0,1,0,-100,0L-50,0A50,50,0,1,1,0,50Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(0).cornerRadius(r) renders a point',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(0).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(2 * Math.pi)(),
        pathEqual('M0,0Z'),
      );
      expect(
        a.startAngle(0).endAngle(0)(),
        pathEqual('M0,0Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders a clockwise circle if r > 0 and θ₁ - θ₀ ≥ τ',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(2 * Math.pi)(),
        pathEqual('M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100Z'),
      );
      expect(
        a.startAngle(0).endAngle(3 * Math.pi)(),
        pathEqual('M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(0)(),
        pathEqual('M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(Math.pi)(),
        pathEqual('M0,100A100,100,0,1,1,0,-100A100,100,0,1,1,0,100Z'),
      );
      expect(
        a.startAngle(-3 * Math.pi).endAngle(0)(),
        pathEqual('M0,100A100,100,0,1,1,0,-100A100,100,0,1,1,0,100Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders an anticlockwise circle if r > 0 and θ₀ - θ₁ ≥ τ',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(-2 * Math.pi)(),
        pathEqual('M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100Z'),
      );
      expect(
        a.startAngle(0).endAngle(-3 * Math.pi)(),
        pathEqual('M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(0)(),
        pathEqual('M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(-Math.pi)(),
        pathEqual('M0,100A100,100,0,1,0,0,-100A100,100,0,1,0,0,100Z'),
      );
      expect(
        a.startAngle(3 * Math.pi).endAngle(0)(),
        pathEqual('M0,100A100,100,0,1,0,0,-100A100,100,0,1,0,0,100Z'),
      );
    },
  );

// Note: The outer ring starts and ends at θ₀, but the inner ring starts and ends at θ₁.
// Note: The outer ring is clockwise, but the inner ring is anticlockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders a clockwise annulus if r₀ > 0, r₁ > 0 and θ₀ - θ₁ ≥ τ',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(2 * Math.pi)(),
        pathEqual(
            'M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100M0,-50A50,50,0,1,0,0,50A50,50,0,1,0,0,-50Z'),
      );
      expect(
        a.startAngle(0).endAngle(3 * Math.pi)(),
        pathEqual(
            'M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100M0,50A50,50,0,1,0,0,-50A50,50,0,1,0,0,50Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(0)(),
        pathEqual(
            'M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100M0,-50A50,50,0,1,0,0,50A50,50,0,1,0,0,-50Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(Math.pi)(),
        pathEqual(
            'M0,100A100,100,0,1,1,0,-100A100,100,0,1,1,0,100M0,50A50,50,0,1,0,0,-50A50,50,0,1,0,0,50Z'),
      );
      expect(
        a.startAngle(-3 * Math.pi).endAngle(0)(),
        pathEqual(
            'M0,100A100,100,0,1,1,0,-100A100,100,0,1,1,0,100M0,-50A50,50,0,1,0,0,50A50,50,0,1,0,0,-50Z'),
      );
    },
  );

// Note: The outer ring starts and ends at θ₀, but the inner ring starts and ends at θ₁.
// Note: The outer ring is anticlockwise, but the inner ring is clockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders an anticlockwise annulus if r₀ > 0, r₁ > 0 and θ₁ - θ₀ ≥ τ',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(-2 * Math.pi)(),
        pathEqual(
            'M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100M0,-50A50,50,0,1,1,0,50A50,50,0,1,1,0,-50Z'),
      );
      expect(
        a.startAngle(0).endAngle(-3 * Math.pi)(),
        pathEqual(
            'M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100M0,50A50,50,0,1,1,0,-50A50,50,0,1,1,0,50Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(0)(),
        pathEqual(
            'M0,-100A100,100,0,1,0,0,100A100,100,0,1,0,0,-100M0,-50A50,50,0,1,1,0,50A50,50,0,1,1,0,-50Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(-Math.pi)(),
        pathEqual(
            'M0,100A100,100,0,1,0,0,-100A100,100,0,1,0,0,100M0,50A50,50,0,1,1,0,-50A50,50,0,1,1,0,50Z'),
      );
      expect(
        a.startAngle(3 * Math.pi).endAngle(0)(),
        pathEqual(
            'M0,100A100,100,0,1,0,0,-100A100,100,0,1,0,0,100M0,-50A50,50,0,1,1,0,50A50,50,0,1,1,0,-50Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders a small clockwise sector if r > 0 and π > θ₁ - θ₀ ≥ 0',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,1,5.263158,-99.861400A100,100,0,0,1,99.861400,-5.263158A5,5,0,0,1,94.868330,0L0,0Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(5 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,1,5.263158,-99.861400A100,100,0,0,1,99.861400,-5.263158A5,5,0,0,1,94.868330,0L0,0Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(-Math.pi / 2)(),
        pathEqual(
            'M0,94.868330A5,5,0,0,1,-5.263158,99.861400A100,100,0,0,1,-99.861400,5.263158A5,5,0,0,1,-94.868330,0L0,0Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders a small anticlockwise sector if r > 0 and π > θ₀ - θ₁ ≥ 0',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(-Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,0,-5.263158,-99.861400A100,100,0,0,0,-99.861400,-5.263158A5,5,0,0,0,-94.868330,0L0,0Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(-5 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,0,-5.263158,-99.861400A100,100,0,0,0,-99.861400,-5.263158A5,5,0,0,0,-94.868330,0L0,0Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(Math.pi / 2)(),
        pathEqual(
            'M0,94.868330A5,5,0,0,0,5.263158,99.861400A100,100,0,0,0,99.861400,5.263158A5,5,0,0,0,94.868330,0L0,0Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders a large clockwise sector if r > 0 and τ > θ₁ - θ₀ ≥ π',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(3 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,1,5.263158,-99.861400A100,100,0,1,1,-99.861400,5.263158A5,5,0,0,1,-94.868330,0L0,0Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(7 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,1,5.263158,-99.861400A100,100,0,1,1,-99.861400,5.263158A5,5,0,0,1,-94.868330,0L0,0Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(Math.pi / 2)(),
        pathEqual(
            'M0,94.868330A5,5,0,0,1,-5.263158,99.861400A100,100,0,1,1,99.861400,-5.263158A5,5,0,0,1,94.868330,0L0,0Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders a large anticlockwise sector if r > 0 and τ > θ₀ - θ₁ ≥ π',
    () {
      var a = shape.arc().innerRadius(0).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(-3 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,0,-5.263158,-99.861400A100,100,0,1,0,99.861400,5.263158A5,5,0,0,0,94.868330,0L0,0Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(-7 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,0,-5.263158,-99.861400A100,100,0,1,0,99.861400,5.263158A5,5,0,0,0,94.868330,0L0,0Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(-Math.pi / 2)(),
        pathEqual(
            'M0,94.868330A5,5,0,0,0,5.263158,99.861400A100,100,0,1,0,-99.861400,-5.263158A5,5,0,0,0,-94.868330,0L0,0Z'),
      );
    },
  );

// Note: The outer ring is clockwise, but the inner ring is anticlockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders a small clockwise annular sector if r₀ > 0, r₁ > 0 and π > θ₁ - θ₀ ≥ 0',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,1,5.263158,-99.861400A100,100,0,0,1,99.861400,-5.263158A5,5,0,0,1,94.868330,0L54.772256,0A5,5,0,0,1,49.792960,-4.545455A50,50,0,0,0,4.545455,-49.792960A5,5,0,0,1,0,-54.772256Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(5 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,1,5.263158,-99.861400A100,100,0,0,1,99.861400,-5.263158A5,5,0,0,1,94.868330,0L54.772256,0A5,5,0,0,1,49.792960,-4.545455A50,50,0,0,0,4.545455,-49.792960A5,5,0,0,1,0,-54.772256Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(-Math.pi / 2)(),
        pathEqual(
            'M0,94.868330A5,5,0,0,1,-5.263158,99.861400A100,100,0,0,1,-99.861400,5.263158A5,5,0,0,1,-94.868330,0L-54.772256,0A5,5,0,0,1,-49.792960,4.545455A50,50,0,0,0,-4.545455,49.792960A5,5,0,0,1,0,54.772256Z'),
      );
    },
  );

// Note: The outer ring is anticlockwise, but the inner ring is clockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders a small anticlockwise annular sector if r₀ > 0, r₁ > 0 and π > θ₀ - θ₁ ≥ 0',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(-Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,0,-5.263158,-99.861400A100,100,0,0,0,-99.861400,-5.263158A5,5,0,0,0,-94.868330,0L-54.772256,0A5,5,0,0,0,-49.792960,-4.545455A50,50,0,0,1,-4.545455,-49.792960A5,5,0,0,0,0,-54.772256Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(-5 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,0,-5.263158,-99.861400A100,100,0,0,0,-99.861400,-5.263158A5,5,0,0,0,-94.868330,0L-54.772256,0A5,5,0,0,0,-49.792960,-4.545455A50,50,0,0,1,-4.545455,-49.792960A5,5,0,0,0,0,-54.772256Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(Math.pi / 2)(),
        pathEqual(
            'M0,94.868330A5,5,0,0,0,5.263158,99.861400A100,100,0,0,0,99.861400,5.263158A5,5,0,0,0,94.868330,0L54.772256,0A5,5,0,0,0,49.792960,4.545455A50,50,0,0,1,4.545455,49.792960A5,5,0,0,0,0,54.772256Z'),
      );
    },
  );

// Note: The outer ring is clockwise, but the inner ring is anticlockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders a large clockwise annular sector if r₀ > 0, r₁ > 0 and τ > θ₁ - θ₀ ≥ π',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(3 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,1,5.263158,-99.861400A100,100,0,1,1,-99.861400,5.263158A5,5,0,0,1,-94.868330,0L-54.772256,0A5,5,0,0,1,-49.792960,4.545455A50,50,0,1,0,4.545455,-49.792960A5,5,0,0,1,0,-54.772256Z'),
      );
      expect(
        a.startAngle(2 * Math.pi).endAngle(7 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,1,5.263158,-99.861400A100,100,0,1,1,-99.861400,5.263158A5,5,0,0,1,-94.868330,0L-54.772256,0A5,5,0,0,1,-49.792960,4.545455A50,50,0,1,0,4.545455,-49.792960A5,5,0,0,1,0,-54.772256Z'),
      );
      expect(
        a.startAngle(-Math.pi).endAngle(Math.pi / 2)(),
        pathEqual(
            'M0,94.868330A5,5,0,0,1,-5.263158,99.861400A100,100,0,1,1,99.861400,-5.263158A5,5,0,0,1,94.868330,0L54.772256,0A5,5,0,0,1,49.792960,-4.545455A50,50,0,1,0,-4.545455,49.792960A5,5,0,0,1,0,54.772256Z'),
      );
    },
  );

// Note: The outer ring is anticlockwise, but the inner ring is clockwise.
  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁).cornerRadius(rᵧ) renders a large anticlockwise annular sector if r₀ > 0, r₁ > 0 and τ > θ₀ - θ₁ ≥ π',
    () {
      var a = shape.arc().innerRadius(50).outerRadius(100).cornerRadius(5);
      expect(
        a.startAngle(0).endAngle(-3 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,0,-5.263158,-99.861400A100,100,0,1,0,99.861400,5.263158A5,5,0,0,0,94.868330,0L54.772256,0A5,5,0,0,0,49.792960,4.545455A50,50,0,1,1,-4.545455,-49.792960A5,5,0,0,0,0,-54.772256Z'),
      );
      expect(
        a.startAngle(-2 * Math.pi).endAngle(-7 * Math.pi / 2)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,0,-5.263158,-99.861400A100,100,0,1,0,99.861400,5.263158A5,5,0,0,0,94.868330,0L54.772256,0A5,5,0,0,0,49.792960,4.545455A50,50,0,1,1,-4.545455,-49.792960A5,5,0,0,0,0,-54.772256Z'),
      );
      expect(
        a.startAngle(Math.pi).endAngle(-Math.pi / 2)(),
        pathEqual(
            'M0,94.868330A5,5,0,0,0,5.263158,99.861400A100,100,0,1,0,-99.861400,-5.263158A5,5,0,0,0,-94.868330,0L-54.772256,0A5,5,0,0,0,-49.792960,-4.545455A50,50,0,1,1,4.545455,49.792960A5,5,0,0,0,0,54.772256Z'),
      );
    },
  );

  test(
    'arc().innerRadius(r₀).outerRadius(r₁).cornerRadius(rᵧ) restricts rᵧ to |r₁ - r₀| / 2',
    () {
      var a = shape
          .arc()
          .cornerRadius(double.infinity)
          .startAngle(0)
          .endAngle(Math.pi / 2);
      expect(
        a.innerRadius(90).outerRadius(100)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,1,5.263158,-99.861400A100,100,0,0,1,99.861400,-5.263158A5,5,0,0,1,94.868330,0L94.868330,0A5,5,0,0,1,89.875260,-4.736842A90,90,0,0,0,4.736842,-89.875260A5,5,0,0,1,0,-94.868330Z'),
      );
      expect(
        a.innerRadius(100).outerRadius(90)(),
        pathEqual(
            'M0,-94.868330A5,5,0,0,1,5.263158,-99.861400A100,100,0,0,1,99.861400,-5.263158A5,5,0,0,1,94.868330,0L94.868330,0A5,5,0,0,1,89.875260,-4.736842A90,90,0,0,0,4.736842,-89.875260A5,5,0,0,1,0,-94.868330Z'),
      );
    },
  );

  test(
    'arc().innerRadius(r₀).outerRadius(r₁).cornerRadius(rᵧ) merges adjacent corners when rᵧ is relatively large',
    () {
      var a = shape
          .arc()
          .cornerRadius(double.infinity)
          .startAngle(0)
          .endAngle(Math.pi / 2);
      expect(
        a.innerRadius(10).outerRadius(100)(),
        pathEqual(
            'M0,-41.421356A41.421356,41.421356,0,1,1,41.421356,0L24.142136,0A24.142136,24.142136,0,0,1,0,-24.142136Z'),
      );
      expect(
        a.innerRadius(100).outerRadius(10)(),
        pathEqual(
            'M0,-41.421356A41.421356,41.421356,0,1,1,41.421356,0L24.142136,0A24.142136,24.142136,0,0,1,0,-24.142136Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(0).startAngle(0).endAngle(τ).padAngle(δ) does not pad a point',
    () {
      var a = shape
          .arc()
          .innerRadius(0)
          .outerRadius(0)
          .startAngle(0)
          .endAngle(2 * Math.pi)
          .padAngle(0.1);
      expect(
        a(),
        pathEqual('M0,0Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(0).endAngle(τ).padAngle(δ) does not pad a circle',
    () {
      var a = shape
          .arc()
          .innerRadius(0)
          .outerRadius(100)
          .startAngle(0)
          .endAngle(2 * Math.pi)
          .padAngle(0.1);
      expect(
        a(),
        pathEqual('M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100Z'),
      );
    },
  );

  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(0).endAngle(τ).padAngle(δ) does not pad an annulus',
    () {
      var a = shape
          .arc()
          .innerRadius(50)
          .outerRadius(100)
          .startAngle(0)
          .endAngle(2 * Math.pi)
          .padAngle(0.1);
      expect(
        a(),
        pathEqual(
            'M0,-100A100,100,0,1,1,0,100A100,100,0,1,1,0,-100M0,-50A50,50,0,1,0,0,50A50,50,0,1,0,0,-50Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁).padAngle(δ) pads the outside of a circular sector',
    () {
      var a = shape
          .arc()
          .innerRadius(0)
          .outerRadius(100)
          .startAngle(0)
          .endAngle(Math.pi / 2)
          .padAngle(0.1);
      expect(
        a(),
        pathEqual(
            'M4.997917,-99.875026A100,100,0,0,1,99.875026,-4.997917L0,0Z'),
      );
    },
  );

  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁).padAngle(δ) pads an annular sector',
    () {
      var a = shape
          .arc()
          .innerRadius(50)
          .outerRadius(100)
          .startAngle(0)
          .endAngle(Math.pi / 2)
          .padAngle(0.1);
      expect(
        a(),
        pathEqual(
            'M5.587841,-99.843758A100,100,0,0,1,99.843758,-5.587841L49.686779,-5.587841A50,50,0,0,0,5.587841,-49.686779Z'),
      );
    },
  );

  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁).padAngle(δ) may collapse the inside of an annular sector',
    () {
      var a = shape
          .arc()
          .innerRadius(10)
          .outerRadius(100)
          .startAngle(0)
          .endAngle(Math.pi / 2)
          .padAngle(0.2);
      expect(
        a(),
        pathEqual(
            'M10.033134,-99.495408A100,100,0,0,1,99.495408,-10.033134L7.071068,-7.071068Z'),
      );
    },
  );

  test(
    'arc().innerRadius(0).outerRadius(r).startAngle(θ₀).endAngle(θ₁).padAngle(δ).cornerRadius(rᵧ) rounds and pads a circular sector',
    () {
      var a = shape
          .arc()
          .innerRadius(0)
          .outerRadius(100)
          .startAngle(0)
          .endAngle(Math.pi / 2)
          .padAngle(0.1)
          .cornerRadius(10);
      expect(
        a(),
        pathEqual(
            'M4.470273,-89.330939A10,10,0,0,1,16.064195,-98.701275A100,100,0,0,1,98.701275,-16.064195A10,10,0,0,1,89.330939,-4.470273L0,0Z'),
      );
    },
  );

  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁).padAngle(δ).cornerRadius(rᵧ) rounds and pads an annular sector',
    () {
      var a = shape
          .arc()
          .innerRadius(50)
          .outerRadius(100)
          .startAngle(0)
          .endAngle(Math.pi / 2)
          .padAngle(0.1)
          .cornerRadius(10);
      expect(
        a(),
        pathEqual(
            'M5.587841,-88.639829A10,10,0,0,1,17.319823,-98.488698A100,100,0,0,1,98.488698,-17.319823A10,10,0,0,1,88.639829,-5.587841L57.939790,-5.587841A10,10,0,0,1,48.283158,-12.989867A50,50,0,0,0,12.989867,-48.283158A10,10,0,0,1,5.587841,-57.939790Z'),
      );
    },
  );

  test(
    'arc().innerRadius(r₀).outerRadius(r₁).startAngle(θ₀).endAngle(θ₁).padAngle(δ).cornerRadius(rᵧ) rounds and pads a collapsed annular sector',
    () {
      var a = shape
          .arc()
          .innerRadius(10)
          .outerRadius(100)
          .startAngle(0)
          .endAngle(Math.pi / 2)
          .padAngle(0.2)
          .cornerRadius(10);
      expect(
        a(),
        pathEqual(
            'M9.669396,-88.145811A10,10,0,0,1,21.849183,-97.583878A100,100,0,0,1,97.583878,-21.849183A10,10,0,0,1,88.145811,-9.669396L7.071068,-7.071068Z'),
      );
    },
  );
}
