mat = reshape(collect(1:16), (4,4))
vec_slice = mat[1, :]
vec_mat = reshape([1 9;5 13], :, 1)
vec_slice == vec_mat

##
typeof(mat)
typeof(vec_slice)
typeof(vec_mat)


##
for xi in  eachindex(A)
    println(A[xi])
end

for row_i in  eachrow(A)
    println(row_i)
end

for col_i in  eachcol(A)
    println(col_i)
end

