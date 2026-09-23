/*
 * interesting_shapes.scad
 * Reusable OpenSCAD shape library
 *
 * Shapes:
 *   capsule(radius, length) -- cylinder with hemispherical ends
 *   dog_hole_cap(...)       -- flush cap for a 20mm bench dog hole
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


/*
 * dog_hole_cap -- flush fitting cap for a bench dog hole
 *
 * Plugs a 20mm dog hole in an MFT style worktop. The cap is a cone that seats
 * in the eased edge of the hole rather than a disc that sits on the surface,
 * so the top finishes flush with the worktop and a workpiece slides over it.
 *
 * Parameters:
 *   dog_hole             -- bore diameter (20 for a standard dog hole)
 *   dog_depth            -- how far the plug body reaches into the bore
 *   cap_height           -- height of the seating cone. See "Setting
 *                           cap_height" below, this is the parameter that
 *                           decides whether the cap sits flush
 *   centre_hole          -- true to bore the cap through on its axis
 *   centre_hole_diameter -- diameter of that axial bore
 *   offset_hole          -- true to cut a cable notch through the wall
 *   offset_hole_diameter -- diameter of that notch
 *   base_chamfer         -- lead in at the far end of the plug body
 *
 * Setting cap_height
 *   The cone rises at 45 degrees from the bore wall, so it fills an eased
 *   edge exactly cap_height deep and ends up cap_height * 2 wider than the
 *   bore at the face. Set cap_height to the DEPTH of the chamfer on your
 *   holes, measured down from the worktop surface to where the bore goes
 *   parallel:
 *
 *     cap_height  = chamfer depth        cap face diameter = dog_hole + 2 * cap_height
 *     1.76        proven on 20mm holes   23.52
 *     1.0                                22.00
 *     0.5                                21.00
 *
 *   Too small and the cone bottoms on the lip, leaving the cap proud by the
 *   shortfall. Too large and the cone never touches, leaving the cap loose
 *   and low. Measure the chamfer, do not guess it.
 *
 *   The default 1.76 is the figure proven on a printed and fitted part, and
 *   it is one initial layer under 2mm, so the cone finishes on a clean layer
 *   boundary when printed cap face down at 0.2mm.
 *
 * Print orientation: cap face down on the bed, plug body rising. No supports.
 */
module dog_hole_cap(dog_hole             = 20,
                    dog_depth            = 10,
                    cap_height           = 1.76,
                    centre_hole          = false,
                    centre_hole_diameter = 13,
                    offset_hole          = true,
                    offset_hole_diameter = 5,
                    base_chamfer         = 1)
{
    difference() {
        rotate_extrude() {
            difference() {
                // Main body of the plug, solid or sleeved
                if (centre_hole)
                    translate([centre_hole_diameter / 2, 0])
                        square([(dog_hole - centre_hole_diameter) / 2, dog_depth],
                               center = false);
                else
                    square([dog_hole / 2, dog_depth], center = false);

                // Lead in at the far end
                translate([dog_hole / 2, 0])
                    polygon([[0, 0], [0, base_chamfer], [-base_chamfer, 0]]);
            }

            // Seating cone, 45 degrees, filling the eased edge of the hole
            translate([dog_hole / 2, dog_depth - cap_height])
                polygon([[0, 0], [0, cap_height], [cap_height, cap_height]]);
        }

        // Cable notch through the wall
        if (offset_hole) {
            translate([(dog_hole / 2) - (offset_hole_diameter / 3), 0, 0])
                cylinder(h = dog_depth, d = offset_hole_diameter, center = false);
            // Open the notch out through the cone so a cable can drop in
            translate([(dog_hole / 2) - (offset_hole_diameter / 3),
                       -offset_hole_diameter / 2, 0])
                cube([offset_hole_diameter, offset_hole_diameter, dog_depth],
                     center = false);
        }
    }
}
