# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .jl
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.14.1
#   kernelspec:
#     display_name: Julia 1.8.3
#     language: julia
#     name: julia-1.8
# ---

# # Methods

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Defining Methods
# -

f(x::Float64, y::Float64) = 2x + y

f(2.0, 3.0)

f(2.0, 3)

f(Float32(2.0), 3.0)

f(2.0, "3.0")

f("2.0", "3.0")

f(x::Number, y::Number) = 2x - y

f(2.0, 3)

f(2, 3.0)

f(2, 3)

f("foo", 3)

f()

f

methods(f)

f(x,y) = println("Whoa there, Nelly.")

methods(f)

f("foo", 1)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Method Ambiguities
# -

g(x::Float64, y) = 2x + y

g(x, y::Float64) = x + 2y

g(2.0, 3)

g(2, 3.0)

g(2.0, 3.0)

g(x::Float64, y::Float64) = 2x + 2y

g(2.0, 3)

g(2, 3.0)

g(2.0, 3.0)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Parametric Methods
# -

same_type(x::T, y::T) where {T} = true

same_type(x,y) = false

same_type(1, 2)

same_type(1, 2.0)

same_type(1.0, 2.0)

same_type("foo", 2.0)

same_type("foo", "bar")

same_type(Int32(1), Int64(2))

myappend(v::Vector{T}, x::T) where {T} = [v..., x]

myappend([1,2,3],4)

myappend([1,2,3],2.5)

myappend([1.0,2.0,3.0],4.0)

myappend([1.0,2.0,3.0],4)

mytypeof(x::T) where {T} = T

mytypeof(1)

mytypeof(1.0)

same_type_numeric(x::T, y::T) where {T<:Number} = true

same_type_numeric(x::Number, y::Number) = false

same_type_numeric(1, 2)

same_type_numeric(1, 2.0)

same_type_numeric(1.0, 2.0)

same_type_numeric("foo", 2.0)

same_type_numeric("foo", "bar")

same_type_numeric(Int32(1), Int64(2))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Redefining Methods
# -

function tryeval()
    @eval newfun() = 1
    newfun()
end

tryeval()

newfun()

tryeval()

newfun()

function tryeval2()
    @eval newfun2() = 2
    Base.invokelatest(newfun2)
end

tryeval2()

f(x) = "original definition"

g(x) = f(x)

?@async

t = @async f(wait()); yield();

f(x::Int) = "definition for Int"

f(x::Type{Int}) = "definition for Type{Int}"

f(1)

g(1)

# + jupyter={"outputs_hidden": true} tags=[]
?fetch

# + jupyter={"outputs_hidden": true} tags=[]
?schedule
# -

fetch(schedule(t, 1))

t = @async f(wait()); yield();

fetch(schedule(t, 1))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Design Patterns with Parametric Methods

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Extracting the type parameter from a super-type
# -

?AbstractArray

?eltype

eltype_wrong(::Type{A}) where {A<:AbstractArray} = A.parameters[1]

?BitVector

struct BitVector <: AbstractArray{Bool, 1}; end

eltype_wrong(::Type{AbstractArray{T}}) where {T} = T

eltype_wrong(::Type{AbstractArray{T, N}}) where {T, N} = T

eltype_wrong(::Type{A}) where {A<:AbstractArray} = eltype_wrong(supertype(A))

eltype_wrong(Union{AbstractArray{Int}, AbstractArray{Float64}})

# ### Building a similar type with a different type parameter

# + jupyter={"outputs_hidden": true} tags=[]
?convert
# -

Eltype = Int64

input = [1.0, 2.0, 3.0];

input = convert(AbstractArray{Eltype}, input)

# + jupyter={"outputs_hidden": true} tags=[]
?similar
# -

output = similar(input, Eltype)

copy_with_eltype(input, Eltype) = copyto!(similar(input, Eltype), input)

input = [1.0, 2.0, 3.0];

copy_with_eltype(input, Eltype)

# ### Iterated dispatch

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Trait-based dispatch
# -

?Base.IndexStyle

# ### Output-type computation

# ### Separate convert and kernel logic

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Parametrically-constrained Varargs methods
# -

bar(a,b,x::Vararg{Any,2}) = (a,b,x)

bar(1,2,3)

bar(1,2,3,4)

bar(1,2,3,4,5)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Note on Optional and keyword Arguments
# -

f(a=1,b=2) = a+2b

methods(f)

f(a::Int,b::Int) = a-2b

f()

f(1,2)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Function-like objects
# -

struct Polynomial{R}
    coeffs::Vector{R}
end

function (p::Polynomial)(x)
    v = p.coeffs[end]
    for i = (length(p.coeffs)-1):-1:1
        v = v*x + p.coeffs[i]
    end
    return v
end

(p::Polynomial)() = p(5)

p = Polynomial([1,10,100])

p(3)

p()

p(5)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Empty generic functions
# -

function emptyfunc end

methods(emptyfunc)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Method design and the avoidance of ambiguities

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Tuple and NTuple arguments
# -

f(x::NTuple{N,Int}) where {N} = 1

f(x::NTuple{N,Float64}) where {N} = 2

f(x::Tuple{}) = 3

f(x::Tuple{Float64, Vararg{Float64}}) = 2

# ### Orthogonalize your design

# ### Dispatch on one argument at a time

# ### Abstract containers and element types

# ### Complex method "cascades" with default arguments
