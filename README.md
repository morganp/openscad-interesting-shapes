# OpenSCAD Interesting Shapes

Reusable OpenSCAD shape library. Pure OpenSCAD primitives -- no external dependencies.

## Usage

```scad
include <interesting_shapes.scad>

capsule(radius = 5, length = 30);
```

---

## Shapes

### `capsule(radius, length)`

Cylinder with hemispherical ends. Built from two spheres joined by a cylinder, all sharing the same radius.

| Parameter | Type | Description |
|-----------|------|-------------|
| `radius` | number | Radius of the capsule (spheres and cylinder) |
| `length` | number | Total end-to-end length (must be >= 2 * radius) |

When `length == 2 * radius`, the cylinder height is zero and the result is a sphere.

![Capsule variants](images/capsule.png)

*Left: degenerate sphere (`radius=7, length=14`). Center: standard capsule (`radius=5, length=30`). Right: wide short capsule (`radius=8, length=20`).*

**Examples:**

```scad
include <interesting_shapes.scad>

// standard capsule
capsule(radius = 5, length = 30);

// wider, shorter
capsule(radius = 8, length = 20);

// degenerate -- pure sphere (length == 2 * radius)
capsule(radius = 7, length = 14);
```

See [`examples/capsule_example.scad`](examples/capsule_example.scad) for a runnable demo, or
**[▶ Open in SCAD Studio](https://lizard-spock.co.uk/openscad-gui/?github=morganp/openscad-interesting-shapes/examples/capsule_example.scad)** to view it in the browser, no install.

---

## File Structure

```
interesting_shapes.scad   -- library (include this in your projects)
examples/
  capsule_example.scad    -- runnable demo for capsule
images/
  capsule.png             -- rendered preview
```

## Versioning

Releases follow [Semantic Versioning 2.0.0](https://semver.org).
