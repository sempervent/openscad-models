include <wood.scad>

// table parameters
width = 51 * inch - fourby;
depth = 32 * inch - fourby;
height = 38 * inch;
middle = 18 * inch + fourby;
btm_height = fourby;
laser_printer_height = 14 * inch - fourby;
cricut_height = 18 * inch;

module crossbar(length) {
  cube([length, fourby, fourby]);
}
module leg(length) {
  cube([fourby, fourby, length]);
}
module support(length) {
  cube([fourby, length, fourby]);
}
module tabletop(length, width) {
  cube([length, width, fourby]);
}

module left_frame() {
  union() {
    leg(height);
    translate([0, depth, 0])
    leg(height);
    translate([0, 0, fourby])
    support(depth);
    translate([0, 0, laser_printer_height])
    support(depth);
    translate([0, 0, height - 3 * fourby])
    support(depth);
  }
}

module middle_frame() {
  translate([middle, 0, 0])
  union() {
    leg(height);
    translate([0, depth, 0])
    leg(height);
    translate([0, 0, fourby])
    support(depth);
    translate([0, 0, laser_printer_height])
    support(depth);
    translate([0, 0, cricut_height])
    support(depth);
    translate([0, 0, height - 3 * fourby])
    support(depth);
  }
}

module right_frame() {
  translate([width, 0, 0])
  union() {
    leg(height);
    translate([0, depth, 0])
    leg(height);
    translate([0, 0, fourby])
    support(depth);
    translate([0, 0, cricut_height])
    support(depth);
    translate([0, 0, height - 3 * fourby])
    support(depth);
  }
}

module front_supports() {
  color("green")
  union() {
    translate([0, 0, twoby])
    crossbar(width);
  }
}
module back_supports() {
  color("blue")
  union() {
    translate([0, 0, height - fourby])
    crossbar(width);
    translate([0, 0, height - 4 * fourby])
    crossbar(width);
    translate([0, 0, 2 * fourby + twoby])
    crossbar(width);
  }
}

left_frame();
middle_frame();
right_frame();
// bottom shelf
translate([0, 0, fourby])
  difference() {
  plywood3quarters(width, depth - twoby);
  color("yellow")
  linear_extrude(threequarters) {
    translate([2*fourby, depth - 2 * fourby, 0])
    square([width / 6, depth / 8]);
    translate([width - 2 * fourby, depth - 2 * fourby, 0])
    square([width / 6, depth / 8]);
  }
}
translate([0, depth, 0])
back_supports();
translate([0, 0, 0])
front_supports();
// printer shelf
translate([0, fourby / 2, laser_printer_height + twoby])
plywood3quarters(middle, depth - fourby);
translate([middle, 9 * inch, cricut_height + twoby])
plywood3quarters(width - middle, 18 * inch);
translate([0, 0, height])
tabletop(width + fourby, depth + fourby);

