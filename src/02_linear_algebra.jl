using LinearAlgebra

A = [4 9 2; 3 5 7;8 1 6]
tr(A)
det(A)
inv(A)

diagvec = diag(A)  # Vector of diagnoal element
diagm(diagvec) # Dense diagonal matrix