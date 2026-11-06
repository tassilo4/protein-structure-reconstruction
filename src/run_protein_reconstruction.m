% Protein structure reconstruction experiment
% Tassilo Armleder and Tomas Etlin, Tufts University, December 2025
%
% This archival driver expects the project data at the paths below and the
% following functions on the MATLAB path:
%   - load_ca_plddt
%   - alternating_completion
%   - BBGradient
%
% The latter two functions were written by Abiy Tasissa and Rongjie Lai:
% https://github.com/abiy-tasissa/Nonconvex-Euclidean-Distance-Geometry-Problem-Solver

Weight = readmatrix("out/matrices/Q9WXC7_truePDB_weights_d.txt");
Dist = readmatrix("out/matrices/Q9WXC7_truePDB_dists.csv");
Dist = Dist .* Dist;

% Augmented Lagrangian options
opts.r = 1;
opts.printenergy = 1;
opts.printerror = 1;
opts.rank = 3;
opts.maxit = 40;
opts.tol = 1e-5;

% Barzilai-Borwein gradient method with nonmonotone line search
lsopts.maxit = 20;
lsopts.xtol = 1e-8;
lsopts.gtol = 1e-8;
lsopts.ftol = 1e-10;
lsopts.alpha = 1e-3;
lsopts.rho = 1e-4;
lsopts.sigma = 0.1;
lsopts.eta = 0.8;

% Initialize from centered AlphaFold C-alpha coordinates.
[~, coords_af, ~] = load_ca_plddt('data/AFDB/Q9WXC7.pdb', 'A', [1 284]);
pointInitial = coords_af - mean(coords_af, 1);

[recoveredCoordinates, reconstructedGramMatrix, output] = ...
    alternating_completion(Dist, Weight, pointInitial, opts, lsopts);

