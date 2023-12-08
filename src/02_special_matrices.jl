using BenchmarkTools

## SymTridiagonal
n=2000; a=rand(n); b=rand(n-1);
mat_tri = SymTridiagonal(a,b);
@btime eigmin(mat_tri)

mat_all = Matrix(mat_tri);
@btime eigmin(mat_all)


  
## Diagonal
I(4)  # identity matrix
n=1000; vec1 = rand(n); mat1 = randn(n,n);
diag_mat = diagm(vec1);
diagonal = Diagonal(vec1);
@btime diag_mat * mat1;
@btime diagonal * mat1;