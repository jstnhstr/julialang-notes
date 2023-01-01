# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .jl
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.14.1
#   kernelspec:
#     display_name: Julia 1.8.4
#     language: julia
#     name: julia-1.8
# ---

# # Multi-dimensional Arrays

# ## Basic Functions

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Construction and Initialization
# -

zeros(Int8, 2, 3)

zeros(Int8, (2, 3))

zeros((2, 3))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Array literals
# -

[1,2,3]

promote(1, 2.3, 4//5)

[1, 2.3, 4//5]

[]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Concatenation
# -

[1:2, 4:5]

[1:2; 4:5]

[1:2
 4:5
 6]

[1:2 4:5 7:8]

[[1,2] [4,5] [7,8]]

[1 2 3]

[1;; 2;; 3;; 4]

[1 2
 3 4]

[zeros(Int, 2, 2) [1; 2]
 [3 4] 5]

[[1 1]; 2 3; [4 4]]

[zeros(Int, 2, 2) ; [3 4] ;; [1; 2] ; 5]

[1:2; 4;; 1; 3:4]

[1; 2;; 3; 4;; 5; 6;;;
 7; 8;; 9; 10;; 11; 12]

[1 3 5
 2 4 6;;;
 7 9 11
 8 10 12]

[1 2;;; 3 4;;;; 5 6;;; 7 8]

[[1 2;;; 3 4];;;; [5 6];;; [7 8]]

[1 2 ;;
 3 4]

[1;;]

[2; 3;;;]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Typed array literals
# -

[[1 2] [3 4]]

Int8[[1 2] [3 4]]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Comprehensions
# -

x = rand(8)

[0.25*x[i-1] + 0.5*x[i] + 0.25*x[i+1] for i=2:length(x)-1 ]

Float32[0.25*x[i-1] + 0.5*x[i] + 0.25*x[i+1] for i=2:length(x)-1 ]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Generator Expressions
# -

sum(1/n^2 for n=1:1000)

map(tuple, 1/(i+j) for i=1:2, j=1:2, [1:4;])

map(tuple, (1/(i+j) for i=1:2, j=1:2), [1 3; 2 4])

[(i,j) for i=1:3 for j=1:i]

[(i,j) for i=1:3 for j=1:i if i+j == 4]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Indexing
# -

A = reshape(collect(1:16), (2, 2, 2, 2))

A[1, 2, 1, 1]

A[[1, 2], [1], [1, 2], [1]]

A[[1, 2], [1], [1, 2], 1]

A[[1 2; 1 2]]

A[[1 2; 1 2], 1, 2, 1]

X = reshape(1:16, 4, 4)

X[2:3, 2:end-1]

X[1, [2 3; 4 1]]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Indexed Assignment
# -

x = collect(reshape(1:9, 3, 3))

x[3, 3] = -9;

x[1:2, 1:2] = [-1 -4; -2 -5];

x

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Supported index types
# -

?to_indices

A = reshape(collect(1:2:18), (3, 3))

A[4]

A[[2, 5, 8]]

A[[1 4; 3 8]]

A[[]]

A[1:2:5]

A[2, :]

A[:, 3]

A[:, 3:3]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Cartesian indices
# -

A = reshape(1:32, 4, 4, 2);

A[3, 2, 1]

A[CartesianIndex(3, 2, 1)] == A[3, 2, 1] == 7

page = A[:,:,1]

page[[CartesianIndex(1,1),
      CartesianIndex(2,2),
      CartesianIndex(3,3),
      CartesianIndex(4,4)]]  

A[CartesianIndex.(axes(A, 1), axes(A, 2)), 1]

A[CartesianIndex.(axes(A, 1), axes(A, 2)), :]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Logical indexing
# -

?findall

x = reshape(1:16, 4, 4)

x[[false, true, true, false], :]

?ispow2

mask = map(ispow2, x)

x[mask]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Number of indices
# -

# #### Cartesian indexing

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# #### Linear indexing
# -

?vec

A = [2 6; 4 7; 3 1]

A[5]

vec(A)[5]

CartesianIndices(A)[5]

LinearIndices(A)[2, 2]

?eachindex

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# #### Omitted and extra indices
# -

A = reshape(1:24, 3, 4, 2, 1)

A[1, 3, 2]

A[1, 3]

A[19]

A[]

A = [8,6,7]

A[2,1]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Iteration
# -

A = rand(4,3);

B = view(A, 1:3, 2:3);

for i in eachindex(B)
    @show i
end

# ## Array traits

# ## Array and Vectorized Operators and Functions

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Broadcasting
# -

a = rand(2,1); A = rand(2,3);

repeat(a,1,3)+A

?broadcast

broadcast(+, a, A)

b = rand(1,2)

broadcast(+, a, b)

convert.(Float32, [1, 2])

ceil.(UInt8, [1.2 3.4; 5.6 6.7])

string.(1:3, ". ", ["First", "Second", "Third"])

([1, 2, 3], [4, 5, 6]) .+ ([1, 2, 3],)

([1, 2, 3], [4, 5, 6]) .+ tuple([1, 2, 3])

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Implementation
# -

A = rand(5,7,2);

stride(A,1)

strides(A)

V = @view A[1:3:4, 2:2:6, 2:-1:1];

stride(V, 1)

stride(V, 2)

stride(V, 3)
