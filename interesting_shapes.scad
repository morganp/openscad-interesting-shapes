/*
 * interesting_shapes.scad
 * Reusable OpenSCAD shape library
 *
 * Shapes:
 *   capsule(radius, length) -- cylinder with hemispherical ends
 */

$fn = $fn > 0 ? $fn : 64;

/*
 * capsule -- cylinder with hemispherical ends
 *
 * Parameters:
 *   radius -- radius of the capsule (spheres and cylinder share this radius)
 *   length -- total end-to-end length (must be >= 2 * radius)
 *
 * Geometry: two spheres joined by a cylinder, centered at origin, aligned on Z axis.
 * Minimum meaningful length = 2 * radius (pure sphere, zero-length cylinder).
 */
module capsule(radius = 5, length = 20) {
    cyl_h = length - 2 * radius;

    union() {
        // center cylinder
        if (cyl_h > 0)
            cylinder(h = cyl_h, r = radius, center = true);

        // top sphere
        translate([0, 0, cyl_h / 2])
            sphere(r = radius);

        // bottom sphere
        translate([0, 0, -cyl_h / 2])
            sphere(r = radius);
    }
}
