// Axisymmetric Jet Nozzle Mesh - 2D Version
D = 0.01;          // Nozzle diameter [m]
L_nozzle = 0.5*D;  // Nozzle length
L_down = 20*D;     // Downstream length
R_domain = 10*D;   // Domain radius

// Points (x,y,z)
Point(1) = {0, 0, 0, 1e-4};          // Origin
Point(2) = {L_nozzle, 0, 0, 1e-4};    // Nozzle exit center
Point(3) = {L_nozzle, 0.5*D, 0, 1e-4}; // Nozzle exit wall
Point(4) = {0, 0.5*D, 0, 1e-4};       // Nozzle inlet wall
Point(5) = {0, R_domain, 0, 5e-3};    // Farfield inlet
Point(6) = {L_nozzle+L_down, R_domain, 0, 5e-3}; // Farfield outlet
Point(7) = {L_nozzle+L_down, 0, 0, 1e-3};       // Outlet center

// Lines (connect points)
Line(1) = {1, 2};      // Centerline (symmetry)
Line(2) = {2, 3};      // Nozzle exit face
Line(3) = {3, 4};      // Nozzle wall
Line(4) = {4, 1};      // Inlet wall
Line(5) = {3, 7};      // Outlet
Line(6) = {7, 6};      // Farfield top
Line(7) = {6, 5};      // Inlet far
Line(8) = {5, 4};      // Inlet side

// Boundary Layer (only on nozzle wall)
Field[1] = BoundaryLayer;
Field[1].EdgesList = {3};
Field[1].hwall_n = 5e-6;  // y+≈1 for Re=50k
Field[1].ratio = 1.15;
Field[1].thickness = 0.002;
Field[1].Quads = 1;
Background Field = 1;

// Structured meshing
Transfinite Line {3} = 30 Using Bump 0.25;  // Nozzle wall
Transfinite Line {2,5} = 20;                // Exit/outlet
Transfinite Line {4,8} = 15;                // Inlet
Transfinite Line {6,7} = 25;                // Farfield

// Surface
Curve Loop(1) = {3, 4, 1, 2};  // Nozzle
Curve Loop(2) = {5, 6, 7, 8, -3}; // Domain
Plane Surface(1) = {1};  // Nozzle
Plane Surface(2) = {2};  // Outer domain

// Physical Groups
Physical Curve("inlet") = {4, 8};
Physical Curve("outlet") = {5};
Physical Curve("wall") = {3};
Physical Curve("symmetry") = {1};
Physical Curve("farfield") = {2, 6, 7};
Physical Surface("fluid") = {1, 2};

// Meshing parameters
Mesh.Algorithm = 6;       // Frontal-Delaunay
Mesh.RecombineAll = 1;    // Structured quads
Mesh.ElementOrder = 1;     // Linear elements
Mesh.SecondOrderLinear = 0;