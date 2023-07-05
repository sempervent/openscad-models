/*
 This file provides simple modules for dealing with complex shapes
 */


module rounded_rectangle(
  w = 5,
  l = 20,
  h = 5,
) {
  translate([w/2, 0, h/2])
  linear_extrude(height=h, center=true) {
    union() {
      translate([0, 0, 0])
      circle(d=w, $fn=50);
      translate([w*2, 0, 0])
      square([l, w], center=true);
      translate([l, 0, 0])
      circle(d=w, $fn=50);
    }
  }
}

difference() {
  rounded_rectangle();
  translate([1.5, 0, 0])
  rounded_rectangle(w=4, l=18, h=5);
}
