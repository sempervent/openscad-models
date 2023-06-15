// PARAMETERS {{{1
// units are in mm 
inch = 25.4;
// base parameters
oneby = 19;
twoby = 21;
fourby = 90;
// plywood thickness
threequarters = 23 / 32 * inch;
onehalf = 15 / 32 * inch;
onequarter = 7 / 32 * inch;
// 1}}}
// MODULES {{{1
// wood definitions {{{2
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
module plywood3quarters(length, width) {
  cube([length, width, threequarters]);
}
module plywoodhalf(length, width) {
  cube([length, width, onehalf]);
}
module plywoodquarter(length, width) {
  cube([length, width, onequarter]);
}
// 2}}}
// wood working modules
module tenon(width, depth, height) {
    difference() {
        cube([width, depth, height]);
        translate([width/4, depth/4, -1])
        cube([width/2, depth/2, height+2]);
    }
}

module mortise(width, depth, height = twoby) {
  rotate([90, 0, 0])
    union() {
        cube([width, depth, height]);
        translate([width/4, depth/4, height])
        cube([width/2, depth/2, height/2]);
    }
}
// 2}}}
// applied modules
module mortised4x4(length) {
  union() {
    translate([0, fourby, 0])
    fourbyfour(length - fourby * 2);
    // tenon at one end
    translate([fourby - twoby, fourby + twoby, 0])
    mortise(twoby, fourby, fourby);
    // end of fourbyfour
    translate([0, length - fourby, fourby])
    rotate([180, 0, 0])
    mortise(fourby, fourby, fourby);
  }
}
// 1}}}
//
/*mortise(fourby, fourby, fourby);*/
// mortised4x4(23 * inch);
/*tenon2x4x4(13 * inch);*/
/*color("#3434bc")*/
/*translate([0, 0, 100])*/
/*tenon(10, 10, 10);*/
