// dog_hole_cap example
//
// Three variants of the flush fitting bench dog hole cap.
// Left:   blanking cap, no holes
// Centre: cable notch, the default
// Right:  centre bore, a grommet for something to pass through

include <../interesting_shapes.scad>

$fn = 96;

// Left: plain blank
translate([-30, 0, 0])
    dog_hole_cap(offset_hole = false);

// Centre: default, with the cable notch
dog_hole_cap();

// Right: bored through the middle
translate([30, 0, 0])
    dog_hole_cap(centre_hole = true,
                 centre_hole_diameter = 13,
                 offset_hole = false);
