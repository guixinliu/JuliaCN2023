using ITensors

let
  # For example:
  i = Index(2,"i")
  j = Index(3,"j")
  T = randomITensor(i,j)
  @show T
end
