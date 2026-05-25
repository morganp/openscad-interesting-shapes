# OpenSCAD Interesting Shapes -- Claude Instructions

Reusable OpenSCAD shape library. Pure OpenSCAD primitives only -- no BOSL2, no external deps.

## Project conventions

- All shapes live in `interesting_shapes.scad` as modules
- Each shape gets a runnable demo in `examples/<shape_name>_example.scad`
- Each shape gets a rendered PNG in `images/<shape_name>.png`
- README must be updated with new shape docs and screenshot when adding a shape

## Adding a new shape

1. Add module to `interesting_shapes.scad`
2. Create `examples/<shape_name>_example.scad` showing 2-3 variants
3. Render PNG: `openscad --camera=0,0,0,55,0,25,80 --imgsize=800,600 --render -o images/<shape_name>.png examples/<shape_name>_example.scad`
4. Add docs section to README with parameter table, image, and code example

## Code style

- `$fn = $fn > 0 ? $fn : 64;` at top of library (lets callers override)
- Module parameters have defaults
- `union()` for additive geometry, `difference()` for subtractive
- No BOSL2 primitives (`cyl`, `cuboid`, `spheroid` etc.) -- use `cylinder`, `cube`, `sphere`
- No em dashes in comments or docs

## Rendering

OpenSCAD CLI available at `/opt/homebrew/bin/openscad`.

Standard camera for preview renders: `--camera=0,0,0,55,0,25,80 --imgsize=800,600 --render`

## Versioning

Semantic Versioning 2.0.0 -- https://semver.org
