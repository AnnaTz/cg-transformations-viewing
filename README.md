
This project was developed for the 'Computer Graphics' course, part of the MEng in Electrical and Computer Engineering at the Aristotle University of Thessaloniki in 2018. The project is divided into three main tasks, focusing on different aspects of computer graphics, including triangle filling, transformations and projections, and viewing with lighting and shading.

## Task 1: Triangle Filling

### Objective

Implement triangle filling algorithms using the polygon filling method. Adapt the algorithm to handle triangles specifically, and apply two color rendering techniques.

### Functions

- `triPaintFlat(X, V, C)`:
  - Implements flat coloring for triangles.
  - **Parameters**:
    - `X`: Image (MxNx3) with any pre-existing triangles.
    - `V`: 3x2 matrix containing the coordinates of a triangle's vertices.
    - `C`: 3x3 matrix with each row containing the RGB color (values in [0,1]) of a vertex.
    - **Returns**: `Y`, an MxNx3 matrix with color components for all triangle points and pre-existing triangles.

- `triPaintGouraud(X, V, C)`:
  - Implements Gouraud shading for triangles.
  - **Parameters**: Same as `triPaintFlat`.
  - **Returns**: `Y`, similar to `triPaintFlat`, with Gouraud shading applied.

### Demo Files

- `demoGouraud.m`
- `demoFlat.m`

## Task 2: Transformations and Projections

### Objective

Implement functions to perform geometric transformations and projections in 3D graphics.

### Functions

- `rotmat(i, u)`: Computes a rotation matrix around an axis.
- `affinetrans(cp, R, ct)`: Applies affine transformation to a point or set of points.
- `systemtrans(cp, b1, b2, b3, c0)`: Transforms coordinates between two coordinate systems.
- `projectCamera(w, cv, cx, cy, p)`: Projects 3D points to 2D using a perspective camera model.
- `projectKu(w, cv, cK, cu, p)`: Similar to `projectCamera` but with specific target and up vector.
- `rasterize(P, M, N, H, W)`: Converts point coordinates to pixel positions on an image.
- `photographObject(p, M, N, H, W, w, cv, cK, cu)`: Implements the entire pipeline of photographing an object.

### Demo File

- `demo.m`

## Task 3: Viewing

### Objective

Utilize algorithms from previous tasks to create a comprehensive framework for generating virtual scene photographs, incorporating different lighting and shading models.

### Functions

- `ambientLight(ka, Ia)`: Calculates illumination from ambient light.
- `diffuseLight(P, N, kd, S, I0)`: Computes illumination from diffuse reflection.
- `specularLight(P, N, C, ks, ncoeff, S, I0)`: Determines illumination from specular reflection.
- `findVertNormals(R, F)`: Finds normal vectors for each vertex of a 3D object.
- `photographObjectPhong(...)`: Creates a colored photograph of a 3D object using Phong shading model.
- `shadeGouraud(...)`: Applies Gouraud shading to a triangle.
- `shadePhong(...)`: Applies Phong shading to a triangle, interpolating normal vectors and reflection coefficients.

### Demo File

- `demo.m`
