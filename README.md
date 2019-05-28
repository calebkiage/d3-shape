A library for Dart developers.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:d3_shape/d3_shape.dart';

main() {
  var awesome = new Awesome();
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme

# d3-shape (Dart)

Visualizations typically consist of discrete graphical marks, such as [symbols](#symbols), [arcs](#arcs), [lines](#lines) and [areas](#areas). While the rectangles of a bar chart may be easy enough to generate directly using [SVG](http://www.w3.org/TR/SVG/paths.html#PathData) or [Canvas](http://www.w3.org/TR/2dcontext/#canvaspathmethods), other shapes are complex, such as rounded annular sectors and centripetal Catmull–Rom splines. This module provides a variety of shape generators for your convenience.

As with other aspects of D3, these shapes are driven by data: each shape generator exposes accessors that control how the input data are mapped to a visual representation. For example, you might define a line generator for a time series by [scaling](https://github.com/d3/d3-scale) fields of your data to fit the chart:

```dart
import 'package:d3_shape/d3_shape.dart' as shape;

var line = shape.LineGenerator();
line.x = (d) { return x(d.date); };
line.y = (d) { return y(d.value); };
```

You can use it to render to a Canvas 2D context:

```js
line.context(context).draw(data);
```

For more, read [Introducing d3-shape](https://medium.com/@mbostock/introducing-d3-shape-73f8367e6d12).

## Installing

Update your `pubspec.yaml` file as follows

```yaml
dependencies:
  d3_shape:
    git:
      url: git://github.com/calebkiage/d3-shape.git
```

## API Reference

* [Arcs](#arcs)
* [Pies](#pies)
* [Lines](#lines)
* [Areas](#areas)
* [Curves](#curves)
* [Custom Curves](#custom-curves)
* [Links](#links)
* [Symbols](#symbols)
* [Custom Symbol Types](#custom-symbol-types)
* [Stacks](#stacks)

### Arcs

[<img alt="Pie Chart" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/pie.png" width="295" height="295">](http://bl.ocks.org/mbostock/8878e7fd82034f1d63cf)[<img alt="Donut Chart" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/donut.png" width="295" height="295">](http://bl.ocks.org/mbostock/2394b23da1994fc202e1)

The arc generator produces a [circular](https://en.wikipedia.org/wiki/Circular_sector) or [annular](https://en.wikipedia.org/wiki/Annulus_\(mathematics\)) sector, as in a pie or donut chart. If the difference between the [start](#arc_startAngle) and [end](#arc_endAngle) angles (the *angular span*) is greater than [τ](https://en.wikipedia.org/wiki/Turn_\(geometry\)#Tau_proposal), the arc generator will produce a complete circle or annulus. If it is less than τ, arcs may have [rounded corners](#arc_cornerRadius) and [angular padding](#arc_padAngle). Arcs are always centered at ⟨0,0⟩; use a transform (see: [SVG](http://www.w3.org/TR/SVG/coords.html#TransformAttribute), [Canvas](http://www.w3.org/TR/2dcontext/#transformations)) to move the arc to a different position.

See also the [pie generator](#pies), which computes the necessary angles to represent an array of data as a pie or donut chart; these angles can then be passed to an arc generator.

<a name="arc" href="#arc">#</a> shape.<b>ArcGenerator</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/arc.js "Source")

Constructs a new arc generator with the default settings.

<a name="_arc" href="#_arc">#</a> <i>arc.</i><b>draw</b>(<i>arguments…</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/arc.js#L89 "Source")

Generates an arc for the given *arguments*. The *arguments* are arbitrary; they are simply propagated to the arc generator’s accessor functions along with the `this` object. For example, with the default settings, an object with radii and angles is expected:

```dart
var arc = shape.ArcGenerator();

arc.draw({
  innerRadius: 0,
  outerRadius: 100,
  startAngle: 0,
  endAngle: Math.PI / 2
}); // "M0,-100A100,100,0,0,1,100,0L0,0Z"
```

If the radii and angles are instead defined as constants, you can generate an arc without any arguments:

```dart
var arc = shape.ArcGenerator();
arc.innerRadius = 0;
arc.outerRadius = 100;
arc.startAngle = 0;
arc.endAngle = Math.PI / 2;

arc.draw(); // "M0,-100A100,100,0,0,1,100,0L0,0Z"
```

If the arc generator has a [context](#arc_context), then the arc is rendered to this context as a sequence of [path method](http://www.w3.org/TR/2dcontext/#canvaspathmethods) calls and this function returns void. Otherwise, a [path data](http://www.w3.org/TR/SVG/paths.html#PathData) string is returned.

<a name="arc_centroid" href="#arc_centroid">#</a> <i>arc</i>.<b>centroid</b>(<i>arguments…</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/arc.js#L224 "Source")

Computes the midpoint [*x*, *y*] of the center line of the arc that would be [generated](#_arc) by the given *arguments*. The *arguments* are arbitrary; they are simply propagated to the arc generator’s accessor functions along with the `this` object. To be consistent with the generated arc, the accessors must be deterministic, *i.e.*, return the same value given the same arguments. The midpoint is defined as ([startAngle](#arc_startAngle) + [endAngle](#arc_endAngle)) / 2 and ([innerRadius](#arc_innerRadius) + [outerRadius](#arc_outerRadius)) / 2. For example:

[<img alt="Circular Sector Centroids" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/centroid-circular-sector.png" width="250" height="250">](http://bl.ocks.org/mbostock/9b5a2fd1ce1a146f27e4)[<img alt="Annular Sector Centroids" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/centroid-annular-sector.png" width="250" height="250">](http://bl.ocks.org/mbostock/c274877f647361f3df7d)

Note that this is **not the geometric center** of the arc, which may be outside the arc; this method is merely a convenience for positioning labels.

<a name="arc_innerRadius" href="#arc_innerRadius">#</a> <i>arc</i>.<b>innerRadius</b>([<i>radius</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/arc.js#L230 "Source")

If *radius* is specified, sets the inner radius to the specified function or number and returns this arc generator. If *radius* is not specified, returns the current inner radius accessor, which defaults to:

```dart
innerRadius(d) {
  return d.innerRadius;
}
```

Specifying the inner radius as a function is useful for constructing a stacked polar bar chart, often in conjunction with a [sqrt scale](https://github.com/d3/d3-scale#sqrt). More commonly, a constant inner radius is used for a donut or pie chart. If the outer radius is smaller than the inner radius, the inner and outer radii are swapped. A negative value is treated as zero.

<a name="arc_outerRadius" href="#arc_outerRadius">#</a> <i>arc</i>.<b>outerRadius</b>([<i>radius</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/arc.js#L234 "Source")

If *radius* is specified, sets the outer radius to the specified function or number and returns this arc generator. If *radius* is not specified, returns the current outer radius accessor, which defaults to:

```dart
outerRadius(d) {
  return d.outerRadius;
}
```

Specifying the outer radius as a function is useful for constructing a coxcomb or polar bar chart, often in conjunction with a [sqrt scale](https://github.com/d3/d3-scale#sqrt). More commonly, a constant outer radius is used for a pie or donut chart. If the outer radius is smaller than the inner radius, the inner and outer radii are swapped. A negative value is treated as zero.

<a name="arc_cornerRadius" href="#arc_cornerRadius">#</a> <i>arc</i>.<b>cornerRadius</b>([<i>radius</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/arc.js#L238 "Source")

If *radius* is specified, sets the corner radius to the specified function or number and returns this arc generator. If *radius* is not specified, returns the current corner radius accessor, which defaults to:

```dart
cornerRadius() {
  return 0;
}
```

If the corner radius is greater than zero, the corners of the arc are rounded using circles of the given radius. For a circular sector, the two outer corners are rounded; for an annular sector, all four corners are rounded. The corner circles are shown in this diagram:

[<img alt="Rounded Circular Sectors" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/rounded-circular-sector.png" width="250" height="250">](http://bl.ocks.org/mbostock/e5e3680f3079cf5c3437)[<img alt="Rounded Annular Sectors" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/rounded-annular-sector.png" width="250" height="250">](http://bl.ocks.org/mbostock/f41f50e06a6c04828b6e)

The corner radius may not be larger than ([outerRadius](#arc_outerRadius) - [innerRadius](#arc_innerRadius)) / 2. In addition, for arcs whose angular span is less than π, the corner radius may be reduced as two adjacent rounded corners intersect. This is occurs more often with the inner corners. See the [arc corners animation](http://bl.ocks.org/mbostock/b7671cb38efdfa5da3af) for illustration.

<a name="arc_startAngle" href="#arc_startAngle">#</a> <i>arc</i>.<b>startAngle</b>([<i>angle</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/arc.js#L246 "Source")

If *angle* is specified, sets the start angle to the specified function or number and returns this arc generator. If *angle* is not specified, returns the current start angle accessor, which defaults to:

```dart
startAngle(d) {
  return d.startAngle;
}
```

The *angle* is specified in radians, with 0 at -*y* (12 o’clock) and positive angles proceeding clockwise. If |endAngle - startAngle| ≥ τ, a complete circle or annulus is generated rather than a sector.

<a name="arc_endAngle" href="#arc_endAngle">#</a> <i>arc</i>.<b>endAngle</b>([<i>angle</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/arc.js#L250 "Source")

If *angle* is specified, sets the end angle to the specified function or number and returns this arc generator. If *angle* is not specified, returns the current end angle accessor, which defaults to:

```dart
endAngle(d) {
  return d.endAngle;
}
```

The *angle* is specified in radians, with 0 at -*y* (12 o’clock) and positive angles proceeding clockwise. If |endAngle - startAngle| ≥ τ, a complete circle or annulus is generated rather than a sector.

<a name="arc_padAngle" href="#arc_padAngle">#</a> <i>arc</i>.<b>padAngle</b>([<i>angle</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/arc.js#L254 "Source")

If *angle* is specified, sets the pad angle to the specified function or number and returns this arc generator. If *angle* is not specified, returns the current pad angle accessor, which defaults to:

```dart
padAngle() {
  return d && d.padAngle;
}
```

The pad angle is converted to a fixed linear distance separating adjacent arcs, defined as [padRadius](#arc_padRadius) * padAngle. This distance is subtracted equally from the [start](#arc_startAngle) and [end](#arc_endAngle) of the arc. If the arc forms a complete circle or annulus, as when |endAngle - startAngle| ≥ τ, the pad angle is ignored.

If the [inner radius](#arc_innerRadius) or angular span is small relative to the pad angle, it may not be possible to maintain parallel edges between adjacent arcs. In this case, the inner edge of the arc may collapse to a point, similar to a circular sector. For this reason, padding is typically only applied to annular sectors (*i.e.*, when innerRadius is positive), as shown in this diagram:

[<img alt="Padded Circular Sectors" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/padded-circular-sector.png" width="250" height="250">](http://bl.ocks.org/mbostock/f37b07b92633781a46f7)[<img alt="Padded Annular Sectors" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/padded-annular-sector.png" width="250" height="250">](http://bl.ocks.org/mbostock/99f0a6533f7c949cf8b8)

The recommended minimum inner radius when using padding is outerRadius \* padAngle / sin(θ), where θ is the angular span of the smallest arc before padding. For example, if the outer radius is 200 pixels and the pad angle is 0.02 radians, a reasonable θ is 0.04 radians, and a reasonable inner radius is 100 pixels. See the [arc padding animation](http://bl.ocks.org/mbostock/053fcc2295a445afab07) for illustration.

Often, the pad angle is not set directly on the arc generator, but is instead computed by the [pie generator](#pies) so as to ensure that the area of padded arcs is proportional to their value; see [*pie*.padAngle](#pie_padAngle). See the [pie padding animation](http://bl.ocks.org/mbostock/3e961b4c97a1b543fff2) for illustration. If you apply a constant pad angle to the arc generator directly, it tends to subtract disproportionately from smaller arcs, introducing distortion.

<a name="arc_padRadius" href="#arc_padRadius">#</a> <i>arc</i>.<b>padRadius</b>([<i>radius</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/arc.js#L242 "Source")

If *radius* is specified, sets the pad radius to the specified function or number and returns this arc generator. If *radius* is not specified, returns the current pad radius accessor, which defaults to null, indicating that the pad radius should be automatically computed as sqrt([innerRadius](#arc_innerRadius) * innerRadius + [outerRadius](#arc_outerRadius) * outerRadius). The pad radius determines the fixed linear distance separating adjacent arcs, defined as padRadius * [padAngle](#arc_padAngle).

<a name="arc_context" href="#arc_context">#</a> <i>arc</i>.<b>context</b>([<i>context</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/arc.js#L258 "Source")

If *context* is specified, sets the context and returns this arc generator. If *context* is not specified, returns the current context, which defaults to null. If the context is not null, then the [generated arc](#_arc) is rendered to this context as a sequence of [path method](http://www.w3.org/TR/2dcontext/#canvaspathmethods) calls. Otherwise, a [path data](http://www.w3.org/TR/SVG/paths.html#PathData) string representing the generated arc is returned.

### Pies

The pie generator does not produce a shape directly, but instead computes the necessary angles to represent a tabular dataset as a pie or donut chart; these angles can then be passed to an [arc generator](#arcs).

<a name="pie" href="#pie">#</a> d3.<b>pie</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/pie.js "Source")

Constructs a new pie generator with the default settings.

<a name="_pie" href="#_pie">#</a> <i>pie</i>(<i>data</i>[, <i>arguments…</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/pie.js#L14 "Source")

Generates a pie for the given array of *data*, returning an array of objects representing each datum’s arc angles. Any additional *arguments* are arbitrary; they are simply propagated to the pie generator’s accessor functions along with the `this` object. The length of the returned array is the same as *data*, and each element *i* in the returned array corresponds to the element *i* in the input data. Each object in the returned array has the following properties:

* `data` - the input datum; the corresponding element in the input data array.
* `value` - the numeric [value](#pie_value) of the arc.
* `index` - the zero-based [sorted index](#pie_sort) of the arc.
* `startAngle` - the [start angle](#pie_startAngle) of the arc.
* `endAngle` - the [end angle](#pie_endAngle) of the arc.
* `padAngle` - the [pad angle](#pie_padAngle) of the arc.

This representation is designed to work with the arc generator’s default [startAngle](#arc_startAngle), [endAngle](#arc_endAngle) and [padAngle](#arc_padAngle) accessors. The angular units are arbitrary, but if you plan to use the pie generator in conjunction with an [arc generator](#arcs), you should specify angles in radians, with 0 at -*y* (12 o’clock) and positive angles proceeding clockwise.

Given a small dataset of numbers, here is how to compute the arc angles to render this data as a pie chart:

```js
var data = [1, 1, 2, 3, 5, 8, 13, 21];
var arcs = d3.pie()(data);
```

The first pair of parens, `pie()`, [constructs](#pie) a default pie generator. The second, `pie()(data)`, [invokes](#_pie) this generator on the dataset, returning an array of objects:

```json
[
  {"data":  1, "value":  1, "index": 6, "startAngle": 6.050474740247008, "endAngle": 6.166830023713296, "padAngle": 0},
  {"data":  1, "value":  1, "index": 7, "startAngle": 6.166830023713296, "endAngle": 6.283185307179584, "padAngle": 0},
  {"data":  2, "value":  2, "index": 5, "startAngle": 5.817764173314431, "endAngle": 6.050474740247008, "padAngle": 0},
  {"data":  3, "value":  3, "index": 4, "startAngle": 5.468698322915565, "endAngle": 5.817764173314431, "padAngle": 0},
  {"data":  5, "value":  5, "index": 3, "startAngle": 4.886921905584122, "endAngle": 5.468698322915565, "padAngle": 0},
  {"data":  8, "value":  8, "index": 2, "startAngle": 3.956079637853813, "endAngle": 4.886921905584122, "padAngle": 0},
  {"data": 13, "value": 13, "index": 1, "startAngle": 2.443460952792061, "endAngle": 3.956079637853813, "padAngle": 0},
  {"data": 21, "value": 21, "index": 0, "startAngle": 0.000000000000000, "endAngle": 2.443460952792061, "padAngle": 0}
]
```

Note that the returned array is in the same order as the data, even though this pie chart is [sorted](#pie_sortValues) by descending value, starting with the arc for the last datum (value 21) at 12 o’clock.

<a name="pie_value" href="#pie_value">#</a> <i>pie</i>.<b>value</b>([<i>value</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/pie.js#L54 "Source")

If *value* is specified, sets the value accessor to the specified function or number and returns this pie generator. If *value* is not specified, returns the current value accessor, which defaults to:

```js
function value(d) {
  return d;
}
```

When a pie is [generated](#_pie), the value accessor will be invoked for each element in the input data array, being passed the element `d`, the index `i`, and the array `data` as three arguments. The default value accessor assumes that the input data are numbers, or that they are coercible to numbers using [valueOf](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/valueOf). If your data are not simply numbers, then you should specify an accessor that returns the corresponding numeric value for a given datum. For example:

```js
var data = [
  {"number":  4, "name": "Locke"},
  {"number":  8, "name": "Reyes"},
  {"number": 15, "name": "Ford"},
  {"number": 16, "name": "Jarrah"},
  {"number": 23, "name": "Shephard"},
  {"number": 42, "name": "Kwon"}
];

var arcs = d3.pie()
    .value(function(d) { return d.number; })
    (data);
```

This is similar to [mapping](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) your data to values before invoking the pie generator:

```js
var arcs = d3.pie()(data.map(function(d) { return d.number; }));
```

The benefit of an accessor is that the input data remains associated with the returned objects, thereby making it easier to access other fields of the data, for example to set the color or to add text labels.

<a name="pie_sort" href="#pie_sort">#</a> <i>pie</i>.<b>sort</b>([<i>compare</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/pie.js#L62 "Source")

If *compare* is specified, sets the data comparator to the specified function and returns this pie generator. If *compare* is not specified, returns the current data comparator, which defaults to null. If both the data comparator and the value comparator are null, then arcs are positioned in the original input order. Otherwise, the data is sorted according to the data comparator, and the resulting order is used. Setting the data comparator implicitly sets the [value comparator](#pie_sortValues) to null.

The *compare* function takes two arguments *a* and *b*, each elements from the input data array. If the arc for *a* should be before the arc for *b*, then the comparator must return a number less than zero; if the arc for *a* should be after the arc for *b*, then the comparator must return a number greater than zero; returning zero means that the relative order of *a* and *b* is unspecified. For example, to sort arcs by their associated name:

```js
pie.sort(function(a, b) { return a.name.localeCompare(b.name); });
```

Sorting does not affect the order of the [generated arc array](#_pie) which is always in the same order as the input data array; it merely affects the computed angles of each arc. The first arc starts at the [start angle](#pie_startAngle) and the last arc ends at the [end angle](#pie_endAngle).

<a name="pie_sortValues" href="#pie_sortValues">#</a> <i>pie</i>.<b>sortValues</b>([<i>compare</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/pie.js#L58 "Source")

If *compare* is specified, sets the value comparator to the specified function and returns this pie generator. If *compare* is not specified, returns the current value comparator, which defaults to descending value. The default value comparator is implemented as:

```js
function compare(a, b) {
  return b - a;
}
```

If both the data comparator and the value comparator are null, then arcs are positioned in the original input order. Otherwise, the data is sorted according to the data comparator, and the resulting order is used. Setting the value comparator implicitly sets the [data comparator](#pie_sort) to null.

The value comparator is similar to the [data comparator](#pie_sort), except the two arguments *a* and *b* are values derived from the input data array using the [value accessor](#pie_value), not the data elements. If the arc for *a* should be before the arc for *b*, then the comparator must return a number less than zero; if the arc for *a* should be after the arc for *b*, then the comparator must return a number greater than zero; returning zero means that the relative order of *a* and *b* is unspecified. For example, to sort arcs by ascending value:

```js
pie.sortValues(function(a, b) { return a - b; });
```

Sorting does not affect the order of the [generated arc array](#_pie) which is always in the same order as the input data array; it merely affects the computed angles of each arc. The first arc starts at the [start angle](#pie_startAngle) and the last arc ends at the [end angle](#pie_endAngle).

<a name="pie_startAngle" href="#pie_startAngle">#</a> <i>pie</i>.<b>startAngle</b>([<i>angle</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/pie.js#L66 "Source")

If *angle* is specified, sets the overall start angle of the pie to the specified function or number and returns this pie generator. If *angle* is not specified, returns the current start angle accessor, which defaults to:

```js
function startAngle() {
  return 0;
}
```

The start angle here means the *overall* start angle of the pie, *i.e.*, the start angle of the first arc. The start angle accessor is invoked once, being passed the same arguments and `this` context as the [pie generator](#_pie). The units of *angle* are arbitrary, but if you plan to use the pie generator in conjunction with an [arc generator](#arcs), you should specify an angle in radians, with 0 at -*y* (12 o’clock) and positive angles proceeding clockwise.

<a name="pie_endAngle" href="#pie_endAngle">#</a> <i>pie</i>.<b>endAngle</b>([<i>angle</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/pie.js#L70 "Source")

If *angle* is specified, sets the overall end angle of the pie to the specified function or number and returns this pie generator. If *angle* is not specified, returns the current end angle accessor, which defaults to:

```js
function endAngle() {
  return 2 * Math.PI;
}
```

The end angle here means the *overall* end angle of the pie, *i.e.*, the end angle of the last arc. The end angle accessor is invoked once, being passed the same arguments and `this` context as the [pie generator](#_pie). The units of *angle* are arbitrary, but if you plan to use the pie generator in conjunction with an [arc generator](#arcs), you should specify an angle in radians, with 0 at -*y* (12 o’clock) and positive angles proceeding clockwise.

The value of the end angle is constrained to [startAngle](#pie_startAngle) ± τ, such that |endAngle - startAngle| ≤ τ.

<a name="pie_padAngle" href="#pie_padAngle">#</a> <i>pie</i>.<b>padAngle</b>([<i>angle</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/pie.js#L74 "Source")

If *angle* is specified, sets the pad angle to the specified function or number and returns this pie generator. If *angle* is not specified, returns the current pad angle accessor, which defaults to:

```js
function padAngle() {
  return 0;
}
```

The pad angle here means the angular separation between each adjacent arc. The total amount of padding reserved is the specified *angle* times the number of elements in the input data array, and at most |endAngle - startAngle|; the remaining space is then divided proportionally by [value](#pie_value) such that the relative area of each arc is preserved. See the [pie padding animation](http://bl.ocks.org/mbostock/3e961b4c97a1b543fff2) for illustration. The pad angle accessor is invoked once, being passed the same arguments and `this` context as the [pie generator](#_pie). The units of *angle* are arbitrary, but if you plan to use the pie generator in conjunction with an [arc generator](#arcs), you should specify an angle in radians.

### Lines

[<img width="295" height="154" alt="Line Chart" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/line.png">](http://bl.ocks.org/mbostock/1550e57e12e73b86ad9e)

The line generator produces a [spline](https://en.wikipedia.org/wiki/Spline_\(mathematics\)) or [polyline](https://en.wikipedia.org/wiki/Polygonal_chain), as in a line chart. Lines also appear in many other visualization types, such as the links in [hierarchical edge bundling](http://bl.ocks.org/mbostock/7607999).

<a name="line" href="#line">#</a> shape.<b>LineGenerator</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/line.js "Source")

Constructs a new line generator with the default settings.

<a name="_line" href="#_line">#</a> <i>line</i>.<b>draw</b>(<i>data</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/line.js#L14 "Source")

Generates a line for the given array of *data*. Depending on this line generator’s associated [curve](#line_curve), the given input *data* may need to be sorted by *x*-value before being passed to the line generator. If the line generator has a [context](#line_context), then the line is rendered to this context as a sequence of [path method](http://www.w3.org/TR/2dcontext/#canvaspathmethods) calls and this function returns void. Otherwise, a [path data](http://www.w3.org/TR/SVG/paths.html#PathData) string is returned.

<a name="line_x" href="#line_x">#</a> <i>line</i>.<b>x</b>([<i>x</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/line.js#L34 "Source")

If *x* is specified, sets the x accessor to the specified function or number and returns this line generator. If *x* is not specified, returns the current x accessor, which defaults to:

```dart
x(d) {
  return d[0];
}
```

When a line is [generated](#_line), the x accessor will be invoked for each [defined](#line_defined) element in the input data array, being passed the element `d`, the index `i`, and the array `data` as three arguments. The default x accessor assumes that the input data are two-element arrays of numbers. If your data are in a different format, or if you wish to transform the data before rendering, then you should specify a custom accessor. For example, if `x` is a [time scale](https://github.com/d3/d3-scale#time-scales) and `y` is a [linear scale](https://github.com/d3/d3-scale#linear-scales):

```dart
var data = [
  {date: new Date(2007, 3, 24), value: 93.24},
  {date: new Date(2007, 3, 25), value: 95.35},
  {date: new Date(2007, 3, 26), value: 98.84},
  {date: new Date(2007, 3, 27), value: 99.92},
  {date: new Date(2007, 3, 30), value: 99.80},
  {date: new Date(2007, 4,  1), value: 99.47},
  …
];

var line = shape.LineGenerator();
line.x = (d) { return x(d.date); };
line.y = (d) { return y(d.value); };
```

<a name="line_y" href="#line_y">#</a> <i>line</i>.<b>y</b>([<i>y</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/line.js#L38 "Source")

If *y* is specified, sets the y accessor to the specified function or number and returns this line generator. If *y* is not specified, returns the current y accessor, which defaults to:

```dart
y(d) {
  return d[1];
}
```

When a line is [generated](#_line), the y accessor will be invoked for each [defined](#line_defined) element in the input data array, being passed the element `d`, the index `i`, and the array `data` as three arguments. The default y accessor assumes that the input data are two-element arrays of numbers. See [*line*.x](#line_x) for more information.

<a name="line_defined" href="#line_defined">#</a> <i>line</i>.<b>defined</b>([<i>defined</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/line.js#L42 "Source")

If *defined* is specified, sets the defined accessor to the specified function or boolean and returns this line generator. If *defined* is not specified, returns the current defined accessor, which defaults to:

```dart
defined() {
  return true;
}
```

The default accessor thus assumes that the input data is always defined. When a line is [generated](#_line), the defined accessor will be invoked for each element in the input data array, being passed the element `d`, the index `i`, and the array `data` as three arguments. If the given element is defined (*i.e.*, if the defined accessor returns a truthy value for this element), the [x](#line_x) and [y](#line_y) accessors will subsequently be evaluated and the point will be added to the current line segment. Otherwise, the element will be skipped, the current line segment will be ended, and a new line segment will be generated for the next defined point. As a result, the generated line may have several discrete segments. For example:

[<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/line-defined.png" width="480" height="250" alt="Line with Missing Data">](http://bl.ocks.org/mbostock/0533f44f2cfabecc5e3a)

Note that if a line segment consists of only a single point, it may appear invisible unless rendered with rounded or square [line caps](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-linecap). In addition, some curves such as [curveCardinalOpen](#curveCardinalOpen) only render a visible segment if it contains multiple points.

<a name="line_curve" href="#line_curve">#</a> <i>line</i>.<b>curve</b>([<i>curve</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/line.js#L46 "Source")

If *curve* is specified, sets the [curve factory](#curves) and returns this line generator. If *curve* is not specified, returns the current curve factory, which defaults to [curveLinear](#curveLinear).

<a name="line_context" href="#line_context">#</a> <i>line</i>.<b>context</b>([<i>context</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/line.js#L50 "Source")

If *context* is specified, sets the context and returns this line generator. If *context* is not specified, returns the current context, which defaults to null. If the context is not null, then the [generated line](#_line) is rendered to this context as a sequence of [path method](http://www.w3.org/TR/2dcontext/#canvaspathmethods) calls. Otherwise, a [path data](http://www.w3.org/TR/SVG/paths.html#PathData) string representing the generated line is returned.

<a name="lineRadial" href="#lineRadial">#</a> d3.<b>lineRadial</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/lineRadial.js "Source")

<img alt="Radial Line" width="250" height="250" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/line-radial.png">

Constructs a new radial line generator with the default settings. A radial line generator is equivalent to the standard Cartesian [line generator](#line), except the [x](#line_x) and [y](#line_y) accessors are replaced with [angle](#lineRadial_angle) and [radius](#lineRadial_radius) accessors. Radial lines are always positioned relative to ⟨0,0⟩; use a transform (see: [SVG](http://www.w3.org/TR/SVG/coords.html#TransformAttribute), [Canvas](http://www.w3.org/TR/2dcontext/#transformations)) to change the origin.

<a name="_lineRadial" href="#_lineRadial">#</a> <i>lineRadial</i>(<i>data</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/lineRadial.js#L4 "Source")

Equivalent to [*line*](#_line).

<a name="lineRadial_angle" href="#lineRadial_angle">#</a> <i>lineRadial</i>.<b>angle</b>([<i>angle</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/lineRadial.js#L7 "Source")

Equivalent to [*line*.x](#line_x), except the accessor returns the angle in radians, with 0 at -*y* (12 o’clock).

<a name="lineRadial_radius" href="#lineRadial_radius">#</a> <i>lineRadial</i>.<b>radius</b>([<i>radius</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/lineRadial.js#L8 "Source")

Equivalent to [*line*.y](#line_y), except the accessor returns the radius: the distance from the origin ⟨0,0⟩.

<a name="lineRadial_defined" href="#lineRadial_defined">#</a> <i>lineRadial</i>.<b>defined</b>([<i>defined</i>])

Equivalent to [*line*.defined](#line_defined).

<a name="lineRadial_curve" href="#lineRadial_curve">#</a> <i>lineRadial</i>.<b>curve</b>([<i>curve</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/lineRadial.js#L10 "Source")

Equivalent to [*line*.curve](#line_curve). Note that [curveMonotoneX](#curveMonotoneX) or [curveMonotoneY](#curveMonotoneY) are not recommended for radial lines because they assume that the data is monotonic in *x* or *y*, which is typically untrue of radial lines.

<a name="lineRadial_context" href="#lineRadial_context">#</a> <i>lineRadial</i>.<b>context</b>([<i>context</i>])

Equivalent to [*line*.context](#line_context).

### Areas

[<img alt="Area Chart" width="295" height="154" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/area.png">](http://bl.ocks.org/mbostock/3883195)[<img alt="Stacked Area Chart" width="295" height="154" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/area-stacked.png">](http://bl.ocks.org/mbostock/3885211)[<img alt="Difference Chart" width="295" height="154" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/area-difference.png">](http://bl.ocks.org/mbostock/3894205)

The area generator produces an area, as in an area chart. An area is defined by two bounding [lines](#lines), either splines or polylines. Typically, the two lines share the same [*x*-values](#area_x) ([x0](#area_x0) = [x1](#area_x1)), differing only in *y*-value ([y0](#area_y0) and [y1](#area_y1)); most commonly, y0 is defined as a constant representing [zero](http://www.vox.com/2015/11/19/9758062/y-axis-zero-chart). The first line (the <i>topline</i>) is defined by x1 and y1 and is rendered first; the second line (the <i>baseline</i>) is defined by x0 and y0 and is rendered second, with the points in reverse order. With a [curveLinear](#curveLinear) [curve](#area_curve), this produces a clockwise polygon.

<a name="area" href="#area">#</a> shape.<b>AreaGenerator</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/area.js "Source")

Constructs a new area generator with the default settings.

<a name="_area" href="#_area">#</a> <i>area.</i><b>draw</b>(<i>data</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L17 "Source")

Generates an area for the given array of *data*. Depending on this area generator’s associated [curve](#area_curve), the given input *data* may need to be sorted by *x*-value before being passed to the area generator. If the area generator has a [context](#line_context), then the area is rendered to this context as a sequence of [path method](http://www.w3.org/TR/2dcontext/#canvaspathmethods) calls and this function returns void. Otherwise, a [path data](http://www.w3.org/TR/SVG/paths.html#PathData) string is returned.

<a name="area_x" href="#area_x">#</a> <i>area</i>.<b>x</b>([<i>x</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L59 "Source")

If *x* is specified, sets [x0](#area_x0) to *x* and [x1](#area_x1) to null and returns this area generator. If *x* is not specified, returns the current x0 accessor.

<a name="area_x0" href="#area_x0">#</a> <i>area</i>.<b>x0</b>([<i>x</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L63 "Source")

If *x* is specified, sets the x0 accessor to the specified function or number and returns this area generator. If *x* is not specified, returns the current x0 accessor, which defaults to:

```dart
x(d) {
  return d[0];
}
```

When an area is [generated](#_area), the x0 accessor will be invoked for each [defined](#area_defined) element in the input data array, being passed the element `d`, the index `i`, and the array `data` as three arguments. The default x0 accessor assumes that the input data are two-element arrays of numbers. If your data are in a different format, or if you wish to transform the data before rendering, then you should specify a custom accessor. For example, if `x` is a [time scale](https://github.com/d3/d3-scale#time-scales) and `y` is a [linear scale](https://github.com/d3/d3-scale#linear-scales):

```dart
var data = [
  {date: new Date(2007, 3, 24), value: 93.24},
  {date: new Date(2007, 3, 25), value: 95.35},
  {date: new Date(2007, 3, 26), value: 98.84},
  {date: new Date(2007, 3, 27), value: 99.92},
  {date: new Date(2007, 3, 30), value: 99.80},
  {date: new Date(2007, 4,  1), value: 99.47},
  …
];

var area = shape.AreaGenerator();
area.x = (d) { return x(d.date); };
area.y1 = (d) { return y(d.value); };
area.y0 = y(0);
```

<a name="area_x1" href="#area_x1">#</a> <i>area</i>.<b>x1</b>([<i>x</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L67 "Source")

If *x* is specified, sets the x1 accessor to the specified function or number and returns this area generator. If *x* is not specified, returns the current x1 accessor, which defaults to null, indicating that the previously-computed [x0](#area_x0) value should be reused for the x1 value.

When an area is [generated](#_area), the x1 accessor will be invoked for each [defined](#area_defined) element in the input data array, being passed the element `d`, the index `i`, and the array `data` as three arguments. See [*area*.x0](#area_x0) for more information.

<a name="area_y" href="#area_y">#</a> <i>area</i>.<b>y</b>([<i>y</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L71 "Source")

If *y* is specified, sets [y0](#area_y0) to *y* and [y1](#area_y1) to null and returns this area generator. If *y* is not specified, returns the current y0 accessor.

<a name="area_y0" href="#area_y0">#</a> <i>area</i>.<b>y0</b>([<i>y</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L75 "Source")

If *y* is specified, sets the y0 accessor to the specified function or number and returns this area generator. If *y* is not specified, returns the current y0 accessor, which defaults to:

```dart
y() {
  return 0;
}
```

When an area is [generated](#_area), the y0 accessor will be invoked for each [defined](#area_defined) element in the input data array, being passed the element `d`, the index `i`, and the array `data` as three arguments. See [*area*.x0](#area_x0) for more information.

<a name="area_y1" href="#area_y1">#</a> <i>area</i>.<b>y1</b>([<i>y</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L79 "Source")

If *y* is specified, sets the y1 accessor to the specified function or number and returns this area generator. If *y* is not specified, returns the current y1 accessor, which defaults to:

```dart
y(d) {
  return d[1];
}
```

A null accessor is also allowed, indicating that the previously-computed [y0](#area_y0) value should be reused for the y1 value. When an area is [generated](#_area), the y1 accessor will be invoked for each [defined](#area_defined) element in the input data array, being passed the element `d`, the index `i`, and the array `data` as three arguments. See [*area*.x0](#area_x0) for more information.

<a name="area_defined" href="#area_defined">#</a> <i>area</i>.<b>defined</b>([<i>defined</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L96 "Source")

If *defined* is specified, sets the defined accessor to the specified function or boolean and returns this area generator. If *defined* is not specified, returns the current defined accessor, which defaults to:

```dart
defined() {
  return true;
}
```

The default accessor thus assumes that the input data is always defined. When an area is [generated](#_area), the defined accessor will be invoked for each element in the input data array, being passed the element `d`, the index `i`, and the array `data` as three arguments. If the given element is defined (*i.e.*, if the defined accessor returns a truthy value for this element), the [x0](#area_x0), [x1](#area_x1), [y0](#area_y0) and [y1](#area_y1) accessors will subsequently be evaluated and the point will be added to the current area segment. Otherwise, the element will be skipped, the current area segment will be ended, and a new area segment will be generated for the next defined point. As a result, the generated area may have several discrete segments. For example:

[<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/area-defined.png" width="480" height="250" alt="Area with Missing Data">](http://bl.ocks.org/mbostock/3035090)

Note that if an area segment consists of only a single point, it may appear invisible unless rendered with rounded or square [line caps](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-linecap). In addition, some curves such as [curveCardinalOpen](#curveCardinalOpen) only render a visible segment if it contains multiple points.

<a name="area_curve" href="#area_curve">#</a> <i>area</i>.<b>curve</b>([<i>curve</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L100 "Source")

If *curve* is specified, sets the [curve factory](#curves) and returns this area generator. If *curve* is not specified, returns the current curve factory, which defaults to [curveLinear](#curveLinear).

<a name="area_context" href="#area_context">#</a> <i>area</i>.<b>context</b>([<i>context</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L104 "Source")

If *context* is specified, sets the context and returns this area generator. If *context* is not specified, returns the current context, which defaults to null. If the context is not null, then the [generated area](#_area) is rendered to this context as a sequence of [path method](http://www.w3.org/TR/2dcontext/#canvaspathmethods) calls. Otherwise, a [path data](http://www.w3.org/TR/SVG/paths.html#PathData) string representing the generated area is returned.

<a name="area_lineX0" href="#area_lineX0">#</a> <i>area</i>.<b>lineX0</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L83 "Source")
<br><a name="area_lineY0" href="#area_lineY0">#</a> <i>area</i>.<b>lineY0</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L84 "Source")

Returns a new [line generator](#lines) that has this area generator’s current [defined accessor](#area_defined), [curve](#area_curve) and [context](#area_context). The line’s [*x*-accessor](#line_x) is this area’s [*x0*-accessor](#area_x0), and the line’s [*y*-accessor](#line_y) is this area’s [*y0*-accessor](#area_y0).

<a name="area_lineX1" href="#area_lineX1">#</a> <i>area</i>.<b>lineX1</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L92 "Source")

Returns a new [line generator](#lines) that has this area generator’s current [defined accessor](#area_defined), [curve](#area_curve) and [context](#area_context). The line’s [*x*-accessor](#line_x) is this area’s [*x1*-accessor](#area_x1), and the line’s [*y*-accessor](#line_y) is this area’s [*y0*-accessor](#area_y0).

<a name="area_lineY1" href="#area_lineY1">#</a> <i>area</i>.<b>lineY1</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/area.js#L88 "Source")

Returns a new [line generator](#lines) that has this area generator’s current [defined accessor](#area_defined), [curve](#area_curve) and [context](#area_context). The line’s [*x*-accessor](#line_x) is this area’s [*x0*-accessor](#area_x0), and the line’s [*y*-accessor](#line_y) is this area’s [*y1*-accessor](#area_y1).

<a name="areaRadial" href="#areaRadial">#</a> d3.<b>areaRadial</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js "Source")

<img alt="Radial Area" width="250" height="250" src="https://raw.githubusercontent.com/d3/d3-shape/master/img/area-radial.png">

Constructs a new radial area generator with the default settings. A radial area generator is equivalent to the standard Cartesian [area generator](#area), except the [x](#area_x) and [y](#area_y) accessors are replaced with [angle](#areaRadial_angle) and [radius](#areaRadial_radius) accessors. Radial areas are always positioned relative to ⟨0,0⟩; use a transform (see: [SVG](http://www.w3.org/TR/SVG/coords.html#TransformAttribute), [Canvas](http://www.w3.org/TR/2dcontext/#transformations)) to change the origin.

<a name="_areaRadial" href="#_areaRadial">#</a> <i>areaRadial</i>(<i>data</i>)

Equivalent to [*area*](#_area).

<a name="areaRadial_angle" href="#areaRadial_angle">#</a> <i>areaRadial</i>.<b>angle</b>([<i>angle</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js#L13 "Source")

Equivalent to [*area*.x](#area_x), except the accessor returns the angle in radians, with 0 at -*y* (12 o’clock).

<a name="areaRadial_startAngle" href="#areaRadial_startAngle">#</a> <i>areaRadial</i>.<b>startAngle</b>([<i>angle</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js#L14 "Source")

Equivalent to [*area*.x0](#area_x0), except the accessor returns the angle in radians, with 0 at -*y* (12 o’clock). Note: typically [angle](#areaRadial_angle) is used instead of setting separate start and end angles.

<a name="areaRadial_endAngle" href="#areaRadial_endAngle">#</a> <i>areaRadial</i>.<b>endAngle</b>([<i>angle</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js#L15 "Source")

Equivalent to [*area*.x1](#area_x1), except the accessor returns the angle in radians, with 0 at -*y* (12 o’clock). Note: typically [angle](#areaRadial_angle) is used instead of setting separate start and end angles.

<a name="areaRadial_radius" href="#areaRadial_radius">#</a> <i>areaRadial</i>.<b>radius</b>([<i>radius</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js#L16 "Source")

Equivalent to [*area*.y](#area_y), except the accessor returns the radius: the distance from the origin ⟨0,0⟩.

<a name="areaRadial_innerRadius" href="#areaRadial_innerRadius">#</a> <i>areaRadial</i>.<b>innerRadius</b>([<i>radius</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js#L17 "Source")

Equivalent to [*area*.y0](#area_y0), except the accessor returns the radius: the distance from the origin ⟨0,0⟩.

<a name="areaRadial_outerRadius" href="#areaRadial_outerRadius">#</a> <i>areaRadial</i>.<b>outerRadius</b>([<i>radius</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js#L18 "Source")

Equivalent to [*area*.y1](#area_y1), except the accessor returns the radius: the distance from the origin ⟨0,0⟩.

<a name="areaRadial_defined" href="#areaRadial_defined">#</a> <i>areaRadial</i>.<b>defined</b>([<i>defined</i>])

Equivalent to [*area*.defined](#area_defined).

<a name="areaRadial_curve" href="#areaRadial_curve">#</a> <i>areaRadial</i>.<b>curve</b>([<i>curve</i>]) [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js#L24 "Source")

Equivalent to [*area*.curve](#area_curve). Note that [curveMonotoneX](#curveMonotoneX) or [curveMonotoneY](#curveMonotoneY) are not recommended for radial areas because they assume that the data is monotonic in *x* or *y*, which is typically untrue of radial areas.

<a name="areaRadial_context" href="#areaRadial_context">#</a> <i>areaRadial</i>.<b>context</b>([<i>context</i>])

Equivalent to [*line*.context](#line_context).

<a name="areaRadial_lineStartAngle" href="#areaRadial_lineStartAngle">#</a> <i>areaRadial</i>.<b>lineStartAngle</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js#L19 "Source")
<br><a name="areaRadial_lineInnerRadius" href="#areaRadial_lineInnerRadius">#</a> <i>areaRadial</i>.<b>lineInnerRadius</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js#L21 "Source")

Returns a new [radial line generator](#lineRadial) that has this radial area generator’s current [defined accessor](#areaRadial_defined), [curve](#areaRadial_curve) and [context](#areaRadial_context). The line’s [angle accessor](#lineRadial_angle) is this area’s [start angle accessor](#areaRadial_startAngle), and the line’s [radius accessor](#lineRadial_radius) is this area’s [inner radius accessor](#areaRadial_innerRadius).

<a name="areaRadial_lineEndAngle" href="#areaRadial_lineEndAngle">#</a> <i>areaRadial</i>.<b>lineEndAngle</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js#L20 "Source")

Returns a new [radial line generator](#lineRadial) that has this radial area generator’s current [defined accessor](#areaRadial_defined), [curve](#areaRadial_curve) and [context](#areaRadial_context). The line’s [angle accessor](#lineRadial_angle) is this area’s [end angle accessor](#areaRadial_endAngle), and the line’s [radius accessor](#lineRadial_radius) is this area’s [inner radius accessor](#areaRadial_innerRadius).

<a name="areaRadial_lineOuterRadius" href="#areaRadial_lineOuterRadius">#</a> <i>areaRadial</i>.<b>lineOuterRadius</b>() [<>](https://github.com/d3/d3-shape/blob/master/src/areaRadial.js#L22 "Source")

Returns a new [radial line generator](#lineRadial) that has this radial area generator’s current [defined accessor](#areaRadial_defined), [curve](#areaRadial_curve) and [context](#areaRadial_context). The line’s [angle accessor](#lineRadial_angle) is this area’s [start angle accessor](#areaRadial_startAngle), and the line’s [radius accessor](#lineRadial_radius) is this area’s [outer radius accessor](#areaRadial_outerRadius).

### Curves

While [lines](#lines) are defined as a sequence of two-dimensional [*x*, *y*] points, and [areas](#areas) are similarly defined by a topline and a baseline, there remains the task of transforming this discrete representation into a continuous shape: *i.e.*, how to interpolate between the points. A variety of curves are provided for this purpose.

Curves are typically not constructed or used directly, instead being passed to [*line*.curve](#line_curve) and [*area*.curve](#area_curve). For example:

```dart
import 'package:d3_shape/curves.dart' as curves;

var line = shape.LineGenerator();
line.x = (d) { return x(d.date); };
line.y = (d) { return y(d.value); };
line.curve = curves.curveCatmullRom(alpha: 0.5);
```

<a name="curveBasis" href="#curveBasis">#</a> curves.<b>basisCurve</b>()(<i>context</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/basis.js#L12 "Source")

<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/basis.png" width="888" height="240" alt="basis">

Produces a cubic [basis spline](https://en.wikipedia.org/wiki/B-spline) using the specified control points. The first and last points are triplicated such that the spline starts at the first point and ends at the last point, and is tangent to the line between the first and second points, and to the line between the penultimate and last points.

<a name="curveBasisClosed" href="#curveBasisClosed">#</a> curves.<b>basisClosedCurve</b>()(<i>context</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/basisClosed.js "Source")

<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/basisClosed.png" width="888" height="240" alt="basisClosed">

Produces a closed cubic [basis spline](https://en.wikipedia.org/wiki/B-spline) using the specified control points. When a line segment ends, the first three control points are repeated, producing a closed loop with C2 continuity.

<a name="curveBasisOpen" href="#curveBasisOpen">#</a> curves.<b>basisOpenCurve</b>()(<i>context</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/basisOpen.js "Source")

<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/basisOpen.png" width="888" height="240" alt="basisOpen">

Produces a cubic [basis spline](https://en.wikipedia.org/wiki/B-spline) using the specified control points. Unlike [basis](#basis), the first and last points are not repeated, and thus the curve typically does not intersect these points.

<a name="bundleCurve" href="#bundleCurve">#</a> curves.<b>bundleCurve</b>(num beta = 1)(<i>context</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/bundle.js "Source")

<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/bundle.png" width="888" height="240" alt="bundle">

Produces a straightened cubic [basis spline](https://en.wikipedia.org/wiki/B-spline) using the specified control points, with the spline straightened according to the curve’s [*beta*](#curveBundle_beta), which defaults to 0.85. This curve is typically used in [hierarchical edge bundling](http://bl.ocks.org/mbostock/7607999) to disambiguate connections, as proposed by [Danny Holten](https://www.win.tue.nl/vis1/home/dholten/) in [Hierarchical Edge Bundles: Visualization of Adjacency Relations in Hierarchical Data](https://www.win.tue.nl/vis1/home/dholten/papers/bundles_infovis.pdf). This curve does not implement [*curve*.areaStart](#curve_areaStart) and [*curve*.areaEnd](#curve_areaEnd); it is intended to work with [shape.LineGenerator](#lines), not [shape.AreaGenerator](#areas).

<a name="bundleCurve_beta" href="#bundleCurve_beta">#</a> <i>bundle</i>.<b>beta</b>(<i>beta</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/bundle.js#L51 "Source")

Returns a bundle curve with the specified *beta* in the range [0, 1], representing the bundle strength. If *beta* equals zero, a straight line between the first and last point is produced; if *beta* equals one, a standard [basis](#basis) spline is produced. For example:

```dart
var line = shape.LineGenerator();
line.curve = curves.bundleCurve(beta: 0.5);
```

<a name="cardinalCurve" href="#cardinalCurve">#</a> curves.<b>cardinalCurve</b>(num tension = 0)(<i>context</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/cardinal.js "Source")

<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/cardinal.png" width="888" height="240" alt="cardinal">

Produces a cubic [cardinal spline](https://en.wikipedia.org/wiki/Cubic_Hermite_spline#Cardinal_spline) using the specified control points, with one-sided differences used for the first and last piece. The default [tension](#curveCardinal_tension) is 0.

<a name="cardinalClosedCurve" href="#cardinalClosedCurve">#</a> curves.<b>cardinalClosedCurve</b>(num tension = 0)(<i>context</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/cardinalClosed.js "Source")

<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/cardinalClosed.png" width="888" height="240" alt="cardinalClosed">

Produces a closed cubic [cardinal spline](https://en.wikipedia.org/wiki/Cubic_Hermite_spline#Cardinal_spline) using the specified control points. When a line segment ends, the first three control points are repeated, producing a closed loop. The default [tension](#curveCardinal_tension) is 0.

<a name="cardinalOpenCurve" href="#cardinalOpenCurve">#</a> curves.<b>cardinalOpenCurve</b>(num tension = 0)(<i>context</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/cardinalOpen.js "Source")

<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/cardinalOpen.png" width="888" height="240" alt="cardinalOpen">

Produces a cubic [cardinal spline](https://en.wikipedia.org/wiki/Cubic_Hermite_spline#Cardinal_spline) using the specified control points. Unlike [curveCardinal](#curveCardinal), one-sided differences are not used for the first and last piece, and thus the curve starts at the second point and ends at the penultimate point. The default [tension](#curveCardinal_tension) is 0.

<a name="cardinalCurve_tension" href="#cardinalCurve_tension">#</a> <i>cardinal</i>.<b>tension</b>(<i>tension</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/cardinalOpen.js#L44 "Source")

Returns a cardinal curve with the specified *tension* in the range [0, 1]. The *tension* determines the length of the tangents: a *tension* of one yields all zero tangents, equivalent to [curveLinear](#curveLinear); a *tension* of zero produces a uniform [Catmull–Rom](#curveCatmullRom) spline. For example:

```dart
var line = shape.LineGenerator();
line.curve = curves.cardinalCurve(tension: 0.5);
```

<a name="catmullRomCurve" href="#catmullRomCurve">#</a> curve.<b>catmullRomCurve</b>(num alpha = 0.5)(<i>context</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/catmullRom.js "Source")

<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/catmullRom.png" width="888" height="240" alt="catmullRom">

Produces a cubic Catmull–Rom spline using the specified control points and the parameter [*alpha*](#curveCatmullRom_alpha), which defaults to 0.5, as proposed by Yuksel et al. in [On the Parameterization of Catmull–Rom Curves](http://www.cemyuksel.com/research/catmullrom_param/), with one-sided differences used for the first and last piece.

<a name="catmullRomClosedCurve" href="#catmullRomClosedCurve">#</a> curves.<b>catmullRomClosedCurve</b>(num alpha = 0.5)<i>context</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/catmullRomClosed.js "Source")

<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/catmullRomClosed.png" width="888" height="330" alt="catmullRomClosed">

Produces a closed cubic Catmull–Rom spline using the specified control points and the parameter [*alpha*](#curveCatmullRom_alpha), which defaults to 0.5, as proposed by Yuksel et al. When a line segment ends, the first three control points are repeated, producing a closed loop.

<a name="catmullRomOpenCurve" href="#catmullRomOpenCurve">#</a> curves.<b>catmullRomOpenCurve</b>(num alpha = 0.5)<i>context</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/catmullRomOpen.js "Source")

<img src="https://raw.githubusercontent.com/d3/d3-shape/master/img/catmullRomOpen.png" width="888" height="240" alt="catmullRomOpen">

Produces a cubic Catmull–Rom spline using the specified control points and the parameter [*alpha*](#curveCatmullRom_alpha), which defaults to 0.5, as proposed by Yuksel et al. Unlike [curveCatmullRom](#curveCatmullRom), one-sided differences are not used for the first and last piece, and thus the curve starts at the second point and ends at the penultimate point.

<a name="catmullRomCurve_alpha" href="#catmullRomCurve_alpha">#</a> <i>catmullRom</i>.<b>alpha</b>(<i>alpha</i>) [<>](https://github.com/d3/d3-shape/blob/master/src/curve/catmullRom.js#L83 "Source")

Returns a cubic Catmull–Rom curve with the specified *alpha* in the range [0, 1]. If *alpha* is zero, produces a uniform spline, equivalent to [cardinalCurve](#cardinalCurve) with a tension of zero; if *alpha* is one, produces a chordal spline; if *alpha* is 0.5, produces a [centripetal spline](https://en.wikipedia.org/wiki/Centripetal_Catmull–Rom_spline). Centripetal splines are recommended to avoid self-intersections and overshoot. For example:

```dart
var line = shape.LineGenerator();
line.curve = curves.catmullRomCurve(alpha: 0.5);
```
