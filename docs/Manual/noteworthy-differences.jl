# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .jl
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.14.1
#   kernelspec:
#     display_name: Julia 1.8.2
#     language: julia
#     name: julia-1.8
# ---

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# # Noteworthy Differences from other Languages

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Noteworthy differences from Python

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Code Blocks
# -

if true
    print("true")

if true
    pass
end

if true
    print("true")
end

begin
   1 + 2
    + 3
end

begin
   (1 + 2
    + 3)
end

if "a"
    print("a")
end

if !isempty("abc")
    print("abc")
end

if !parse(Bool, "false")
    print("if")
end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Strings
# -

'text'

"text"

"""text"""

"abc" + "def"

"abc" * "def"

"s" * 3

"s" ^ 3

"ab" "cd"

# + [markdown] tags=[]
# ### Lists, Arrays & Matrices
# -

# Python Lists
L = Vector{UInt}

# NumPy Arrays
A = Array{Float64}

Array{Tuple{UInt64,Float64}}

list = [1,2,3,4,5]

list[1]

list[2:3]

list[end-1]

list[2:]

list[:end]

list[:]

list[2:end]

list[1:2:end]

list[end:-1:1]

1:5:20

for i in 1:5:20
    print(i,"\n")
end

for i in range(2,10)
    print(i,"\n")
end

for i in range(2,2,10)
    print(i,"\n")
end

for i in range(2,4,10)
    print(i,"\n")
end

X = [1 2 3; 4 5 6; 7 8 9]

X[[1,2], [1,3]]

X[[CartesianIndex(1,1), CartesianIndex(2,3)]]

# Column-major
X[1:end]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Operators
# -

A = [1, 1]

B = A

B += [3, 3]

B

A

B = B + 3

B = B .+ 3

B .+= 3

A

A = [1, 1]
B = A
B .+= 3
A

5 % 2

2**2

2^2

A = [1 2; 3 4]; B = [1 0; 0 1];

A*B

A.*B

A = [2:8]

A = [2:8; 9:10]

A'

A.T

-3 > 0 ? 1 : -1

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Functions
# -

f(x=rand()) = x

f()

f()

g(x=[1,2]) = push!(x,3)

g()

g()

readdir()

readdir(join=true)

readdir("..", join=true)

readdir(join=true, "..")

readdir("..", true)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Keywords
# -

j

im

sqrt(Complex(-1))

im == sqrt(Complex(-1))

None

nothing

typeof(nothing)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Math
# -

floor(Int, 3.7)

Int(floor(3.7))

round(Int, 3.7)

floor(3.7)

float("3.7")

parse(Float64, "3.7")
