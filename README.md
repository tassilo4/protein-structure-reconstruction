# Protein Structure Reconstruction from Sparse Distances

A computational mathematics research project by **Tassilo Armleder** and **Tomas Etlin** at Tufts University (December 2025).

[Read the paper](paper/protein-structure-reconstruction.pdf)

## Overview

This project studies whether a three-dimensional protein structure can be reconstructed from a sparse subset of pairwise residue distances. It formulates the task as a Euclidean distance geometry problem, represents the structure through a low-rank positive-semidefinite Gram matrix, and uses an augmented Lagrangian method with Barzilai-Borwein gradient steps to fit the observed constraints.

After optimization, the recovered Gram matrix is centered and reduced to three dimensions through eigendecomposition. The resulting coordinates are aligned with the reference structure using Procrustes analysis.

## Reported experiments

| Distance cutoff | Constraint coverage | RMSD after alignment |
| --- | ---: | ---: |
| 9 Angstrom | 4.3% | 0.000 Angstrom |
| 6 Angstrom | 1.9% | 22.900 Angstrom |

These values are the results reported for a single experiment on PDB 1IXC. The comparison illustrates sensitivity to the number and geometric distribution of available constraints; it does not establish general performance across proteins.

## Repository contents

- `paper/protein-structure-reconstruction.pdf`: edited project paper.
- `src/run_protein_reconstruction.m`: recovered project-specific MATLAB driver.

The original distance matrices, PDB inputs, and local `load_ca_plddt` helper were not available when this repository was reconstructed. The source snapshot is therefore archival rather than a turnkey reproducibility package.

## Solver attribution

The project-specific driver calls `alternating_completion` and `BBGradient`, which were written by Abiy Tasissa and Rongjie Lai for their Euclidean distance geometry solver. Their implementation is available in the upstream repository:

- [Nonconvex Euclidean Distance Geometry Problem Solver](https://github.com/abiy-tasissa/Nonconvex-Euclidean-Distance-Geometry-Problem-Solver)

The algorithm is described in:

> Abiy Tasissa and Rongjie Lai. "Exact Reconstruction of Euclidean Distance Geometry Problem Using Low-rank Matrix Completion." *IEEE Transactions on Information Theory*, 2019. [arXiv:1804.04310](https://arxiv.org/abs/1804.04310)

