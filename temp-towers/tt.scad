/*
 This is adapted from many and is configurable.
 If your Gcode goes by mm, each layer is 10, base is 1.5, so adjust from there
 */
include <modules.scad>

// base params
total_width = 90;
base_height = 1;
total_depth = 20.5;
// layer params
layer_height = 10;
layer_width = 80;
layer_depth = 10;
// temp params
temp = 185;
inc = 5;
steps = 8;

module base(
  w = total_width,
  d = total_depth,
  h = base_height
) {
  rounded_rectangle(
    l=total_width,
    w=total_depth,
    h=base_height);
}

module layer(
  t = temp,
  w = layer_width,
  d = layer_depth,
  h = layer_height,
) {
  block45(w=w,d=d,h=h);
}

base();
translate(
  [total_width - layer_width,
   total_depth - layer_depth,
   base_height])
layer();



