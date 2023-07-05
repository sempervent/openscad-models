/*
 This file provides simple modules for dealing with complex shapes
 */


module rounded_rectangle(
  w = 5,
  l = 20,
  h = 5,
  res = 50,
) {
  translate([w/2, 0, h/2])
  linear_extrude(height=h, center=true) {
    union() {
      translate([0, 0, 0])
      circle(d=w, $fn=res);
      translate([l/2, 0, 0])
      square([l, w], center=true);
      translate([l, 0, 0])
      circle(d=w, $fn=res);
    }
  }
}

// Define the 45° text
module text45(
  h = 1,
  s = 5,
) {
  linear_extrude(height = h) text("45°", size = s, halign = "center", valign = "center");
}

module block45(
  w = 15.5,
  d = 10,
  h = 10,
) {
  cube([w, d, h], center=true);
  // create a larger, rotated cube to subtract
  // this will create the 45 degree angle at the bottom
  difference() {
    cube([w, d, h], center=true);
    translate([0, 0, -h]) 
    rotate([45, 0, 0]) {
      cube([w * 3/2, d * 3/2, h * 3/2], center=true);
    }
  }
  // Define the 45° text
  // add the symbol to the front face
  translate([0, d / 2, 0])
  rotate([0, 90, 0]) 
  text45();
  // add to the back face, rotated 180 degrees
  translate([0, - d / 2, 0])
  rotate([0, 90, 180]) 
  text45();
}
