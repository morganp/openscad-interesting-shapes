include <../interesting_shapes.scad>

// default capsule
capsule(radius = 5, length = 30);

// wider, shorter -- translate to show side by side
translate([20, 0, 0])
    capsule(radius = 8, length = 20);

// pure sphere (length == 2 * radius, zero cylinder)
translate([-20, 0, 0])
    capsule(radius = 7, length = 14);
