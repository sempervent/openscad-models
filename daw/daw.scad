include <wood.scad>

keyboard_shelf_height = 30.25 * inch;
second_shelf_height = 12.25 * inch;
third_shelf_height = second_shelf_height + 14 * inch;

width = 56 * inch;
depth = 34 * inch;
height = keyboard_shelf_height + third_shelf_height;

rack_5u_height = 19.7 * inch;
rack_5u_depth = 9.3 * inch;
rack_5u_width = 5.9 * inch;

midi_pedal_keyboard_height = 13 * inch;


module base() {
  color("#a3d888")
  union() {
    translate([fourby/2, fourby / 2, fourby])
    plywoodhalf(depth / 2 - fourby, width - fourby);
    translate([0, 0, twoby])
    rotate([0, 0, 0])
    twobytwo(width);
    translate([depth/2, 0, fourby])
    fourbyfour(width);
  }
}

module supports() {
  color("#e3c2b9")
  rotate([90, 0, 0]) {
    translate([0, 0, -fourby])
    fourbyfour(keyboard_shelf_height);
    translate([0, 0, -width])
    fourbyfour(keyboard_shelf_height);
    translate([depth, 0, -fourby])
    fourbyfour(keyboard_shelf_height);
    translate([depth, 0, -width])
    fourbyfour(keyboard_shelf_height);
    translate([depth / 2, 0, -fourby])
    fourbyfour(keyboard_shelf_height);
    translate([depth / 2, 0, -width])
    fourbyfour(keyboard_shelf_height);
    translate([depth, 0, -width/2])
    fourbyfour(height);
    // midi pedal support
  }
}
module shelf(w, l) {
  union() {
    plywoodhalf(l, w);
    rotate([0, 90, 0])
    translate([-onehalf-twoby, 0, 0])
    onebytwo(w);
  }
}
module midi_pedal_board() {
  translate([depth / 2 - 3 * inch, twoby, 8 * inch])
  rotate([0, -30, 0])
  shelf(width - fourby, 12 * inch);
}

module midi_pedal_support() {
  translate([depth / 2, width/2, midi_pedal_keyboard_height])
  rotate([90, 180, 90])
    union() {
      difference() {
            fourbyfour(midi_pedal_keyboard_height);
            translate([0, -16, -80])
            rotate([30, 0, 0])
            cube([5 * inch, 5 * inch, 8 *inch]);
        }
    }
}
module second_supports() {
  rotate([90, 0, 0]) {
    color("#a2e4f6")
    translate([depth / 2, 0, -width + width/8])
    union() {
      difference() {
        fourbyfour(second_shelf_height + fourby);
        rotate([-24, 90, 0])
        translate([-3.6 * inch, second_shelf_height - 1.4 * inch, 0])
        cube([8 * inch, 5 * inch, 10 * inch]);
      }
    }
    color("#a2e4f6")
    translate([depth / 2, 0, -fourby - width/8])
    union() {
      difference() {
        fourbyfour(second_shelf_height + fourby);
        rotate([-24, 90, 0])
        translate([-3.6 * inch, second_shelf_height - 1.4 * inch, 0])
        cube([8 * inch, 5 * inch, 10 * inch]);
      }
    }
    color("#3e2b6f")
    translate([depth, 0, -width])
    fourbyfour(third_shelf_height);
    color("#3e2b6f")
    translate([depth, 0, -fourby])
    fourbyfour(third_shelf_height);
  }
  rotate([0, -24, 0])
  translate([(depth / 2), 0, fourby])
  shelf(width, depth / 2 + fourby * 2);
  // TODO - cut out the necessary space for a monitor stand
}

module rack_5u() {
  rotate([0, 90, 0])
  cube([rack_5u_width, rack_5u_depth, rack_5u_height]);
}


module model() {
  base();
  color("#def4c2") {
    translate([depth, 0, second_shelf_height])
    twobyfour(width / 2);
    translate([depth, 0, second_shelf_height + fourby * 2])
    twobyfour(width / 2);
    translate([depth, 0, second_shelf_height - fourby * 2])
    twobyfour(width / 2);
  }
  supports();
  rotate([0, 90, 0])
  translate([-keyboard_shelf_height, 0, 0])
  color("#cae3b3") {
    twobyfour(width);
    translate([0, 0, depth])
    fourbyfour(width);
    translate([0, 0, depth / 2])
    fourbyfour(width);
  }
  midi_pedal_board();
  midi_pedal_support();
  back_shelf_h = 20 * inch;
  translate([depth / 2 + twoby, 0, back_shelf_h]) {
    union() {
      /*difference() {*/
        shelf(width, depth / 2);
        translate([depth / 2 - fourby * 3 + 3.8 * inch, fourby * 2, -20 * inch + 1 * inch])
        rack_5u();
        // todo difference this out with the 5U rack
        // linear extrude a rounded rectangle
      /*}*/
    }
  }
  color("#e39b3a")
  rotate([0, 0, 90]) {
    translate([0, -depth, keyboard_shelf_height - fourby])
    fourbyfour(depth);
    translate([width - fourby, -depth, keyboard_shelf_height - fourby])
    fourbyfour(depth);
  }
  color("#3e4d8f")
  rotate([0, 0, 90]) {
    translate([0, -13.5 * inch - fourby, 13 * inch])
    fourbyfour(depth / 2);
    translate([width - fourby, -13.5 * inch - fourby, 13 * inch])
    fourbyfour(depth / 2);
  }
  translate([depth / 2, 0, back_shelf_h])
  color("#e2ca91") {
    rotate([0, 0, 90])
    translate([0, -depth / 2 - fourby / 2, 0])
    fourbyfour(depth / 2);
    rotate([0, 0, 90])
    translate([width - fourby, -depth / 2, 0])
    fourbyfour(depth / 2);
  }
  translate([0, 0, keyboard_shelf_height])
  shelf(width, depth / 2 + fourby);
  translate([0, 0, keyboard_shelf_height])
  second_supports(); // TODO - add divets for objects and cutout for monitor stand
  translate([depth, 0, keyboard_shelf_height + third_shelf_height]) 
  fourbyfour(width);
}
model();

/*rack_5u();*/
