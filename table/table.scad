// units are in mm
inch = 25.4;
// base parameters
oneby = 19;
twoby = 21;
fourby = 90;
// table parameters
length = 51 * inch;
height = 38 * inch;
width = 32 * inch; // 32 min
// inner dimensions
middle = 18 * inch + fourby;
// bottom shelf settings
btm_height = 4 * inch;



module onebytwo(length) {
    cube([oneby, length, twoby]);
}
module twobyfour(length) {
    cube([twoby, length, fourby]);
}
module twobytwo(length) {
    cube([twoby, length, twoby]);
}
module fourbyfour(length) {
    cube([fourby, length, fourby]);
}
module tabletop(length, width) {
    cube([length, width, fourby]);
}
module crossbar(length) {
    cube([length, fourby, fourby]);
}

module leg() {
    rotate([90, 0, 0])
    fourbyfour(height);
}

module back_legs() {
    leg();
    translate([fourby, -fourby, height / 2 + 3.5 * fourby])
    crossbar(middle);
    translate([fourby, -fourby, fourby * 2])
    crossbar(middle);
    translate([middle, 0, 0])
    leg();
    translate([middle, -fourby, height / 2 + 2 *  fourby])
    crossbar(length - middle);
    translate([middle, -fourby, fourby])
    crossbar(length - middle);
    translate([length - fourby, 0, 0])
    leg();
}

module front_legs() {
    leg();
    translate([middle, 0, 0])
    leg();
    translate([length - fourby, 0, 0])
    leg();
    translate([0, -fourby, fourby * 2])
    crossbar(middle);
    translate([0, -fourby, height - fourby * 2])
    crossbar(middle);
    translate([middle, -fourby, height / 2 + 2 * fourby])
    crossbar(length - middle);
    translate([middle, -fourby, fourby])
    crossbar(length - middle);
}

module legs() {
  union() {
    front_legs();
    translate([0, width - fourby, 0])
    back_legs();
    translate([fourby, -fourby, height - 5 * fourby])
    rotate([0, 0, 90])
    crossbar(width);
    translate([fourby, -fourby, fourby])
    rotate([0, 0, 90])
    crossbar(width);
    translate([length, -fourby, height - 5 * fourby])
    rotate([0, 0, 90])
    crossbar(width);
    translate([length, -fourby, fourby])
    rotate([0, 0, 90])
    crossbar(width);
    translate([middle + fourby, -fourby, height - 5 * fourby])
    rotate([0, 0, 90])
    crossbar(width);
    translate([middle + fourby, -fourby, fourby])
    rotate([0, 0, 90])
    crossbar(width);
  }
}

module bottom_shelf() {
    translate([0, -fourby, btm_height])
    cube([length, width, oneby]);
}

module printer_shelf() {
    cube([middle, width, oneby]);
}

module cricut_shelf() {
    cube([length - middle, 15 * inch, oneby]);
    rotate([90, 0, 0])
    translate([0, -height + 18 * inch, -oneby])
    twobytwo(height - 18 * inch);
    rotate([90, 0, 0])
    translate([length - middle - oneby, -height + 18 * inch, -oneby])
    twobytwo(height - 18 * inch);
}
    
module table() {
    legs();
    bottom_shelf();
    translate([0, -fourby, height])
    tabletop(length, width);
    translate([0, -fourby, 15 * inch])
    printer_shelf();
    translate([middle, width - 20 * inch - fourby, height - 18 * inch])
    cricut_shelf();
}

// onebytwo(200);
// twobyfour(300);
// translate([0, height, 0])
// tabletop(300, 200);
// legs();
table();
