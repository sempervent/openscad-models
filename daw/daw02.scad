include <wood.scad>

// daw parameters
width = 56 * inch;
depth = 34 * inch;
height = (30.25 + 12.25 + 14) * inch;
// shelf heights
keyboard_shelf_height = 30.25 * inch;
second_shelf_height = 12.25 * inch;
third_shelf_height = second_shelf_height + 14 * inch;
// rack dimensions
rack_height = 19.7 * inch;
rack_depth = 9.3 * inch;
rack_width = 5.9 * inch;
rack_equipment_depth = 15 * inch;
// pedal board params
midi_pedal_height = 13 * inch;
midi_pedal_depth = 12 * inch;

module rack() {
  color("orange")
  cube([rack_height, rack_depth, rack_equipment_depth]);
}
module side(
  h = keyboard_shelf_height,
  d = depth,
  max_height = height,
  w = 0
  ) {
  color("#e32fca")
  translate([w, 0, -twoby]) {
    translate([0, 0, h - fourby - threequarters])
    support(d);
    translate([0, 0, midi_pedal_height])
    support(d);
    translate([0, 0, twoby])
    leg(h);
    translate([0, 0, fourby])
    support(d);
    translate([0, d, 0])
    leg(max_height);
  }
}
default_midi_pedal_height = midi_pedal_height - twoby - fourby;
module midi_pedal_support(
  h = default_midi_pedal_height,
) {
    translate([width / 2, depth / 2, twoby])
    mrotate(
      rotation=[90, 180, 180],
      origin=[depth, depth / 6 - fourby, depth / 3])
    {
        translate([0, 0, twoby])
        difference() {
              fourbyfour(h);
              translate([0, -16, -80])
              mrotate([30, 0, 0], [0, -16, -80]) {
                cube([5 * inch, 5 * inch, 8 *inch]);
              }
          }
    }
}
module supports() {
  // next batch of supports
  h = keyboard_shelf_height - fourby - threequarters;
  union() {
    color("yellow")
    translate([0, 0, twoby]) {
      crossbar(width);
      translate([width / 3, 0, 0])
      support(depth);
      translate([width - width / 3, 0, 0])
      support(depth);
      translate([width / 3, midi_pedal_depth, 0])
      crossbar(width / 3);
      translate([0, 8 * inch, keyboard_shelf_height - fourby - threequarters - twoby])
      crossbar(width);
      translate([width / 4, 8 * inch + twoby, keyboard_shelf_height - fourby - threequarters - twoby])
      support(depth - 8 * inch + twoby);
      translate([width - width / 4, 8 * inch + twoby, keyboard_shelf_height - fourby - threequarters - twoby])
      support(depth - 8 * inch + twoby);
    }
    midi_pedal_support();
    translate([0, depth, twoby])
    color("blue") {
      crossbar(width);
      translate([width / 2, 0, 0])
      leg(keyboard_shelf_height - fourby);
      translate([0, 0, 24 * inch])
      crossbar(width);
      translate([0, 0, height - fourby])
      crossbar(width + fourby);
      translate([0, 0, height - fourby * 5])
      crossbar(width);
    }
    color("#45c28f") {
      translate([width / 4, depth - depth * 2 / 3, h + twoby])
      midi_pedal_support(15 * inch);
      translate([-width / 4, depth - depth * 2 / 3, h + twoby])
      midi_pedal_support(15 * inch);
    }
    translate([width / 4, depth - depth / 3 - twoby, h + 7 * inch])
    cube([width / 2, twoby, fourby]);
  }
}
module midi_pedal_board() {
  translate([width + fourby / 2, twoby, 5.7 * inch + midi_pedal_height])
  rotate([0, 0, 90]) {
    mrotate(rotation=[0, -30, 0],
            origin=[depth / 2, midi_pedal_height, 8 * inch])
    shelf(width, 12 * inch);
  }
}

module daw() {
  side();
  supports();
  side(w=width);
  // the main pedal board base
  color("#e3c2a3")
  translate([twoby, 0, fourby + twoby])
  plywood3quarters(width, depth / 2);
  // midi pedal board
  color("#23bcf3")
  midi_pedal_board();
  // keyboard board
  translate([0, 0, keyboard_shelf_height - threequarters])
  plywoodhalf(width + fourby, 13 * inch);
  // top board
  color("#a23344")
  translate([1250, 400, 900])
  mrotate(
    rotation=[40, 0, 0],
    origin=[0, 0, 0]) {
      shelfHD(17 * inch, 40 * inch);
  }
  
}

daw();

// difference() {
     /*daw();*/
//   rack();
// }
