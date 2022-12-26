# -*- coding: utf-8 -*-
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

# # Interfaces

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Iteration
# -

struct Squares
    count::Int
end

Base.iterate(S::Squares, state=1) = state > S.count ? nothing : (state*state, state+1)

for item in Squares(7)
    println(item)
end

25 in Squares(10)

using Statistics

mean(Squares(100))

std(Squares(100))

Base.eltype(::Type{Squares}) = Int

Base.length(S::Squares) = S.count

collect(Squares(4))

Base.sum(S::Squares) = (n = S.count; return n*(n+1)*(2n+1)÷6)

sum(Squares(1803))

Base.iterate(rS::Iterators.Reverse{Squares}, state=rS.itr.count) = state < 1 ? nothing : (state*state, state-1)

collect(Iterators.reverse(Squares(4)))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Indexing
# -

function Base.getindex(S::Squares, i::Int)
    1 <= i <= S.count || throw(BoundsError(S, i))
    return i*i
end

Squares(100)[23]

Base.firstindex(S::Squares) = 1

Base.lastindex(S::Squares) = length(S)

Squares(23)[end]

Base.getindex(S::Squares, i::Number) = S[convert(Int, i)]

Base.getindex(S::Squares, I) = [S[i] for i in I]

Squares(10)[[3,4.,5]]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Abstract Arrays
# -

struct SquaresVector <: AbstractArray{Int, 1}
    count::Int
end

Base.size(S::SquaresVector) = (S.count,)

Base.IndexStyle(::Type{<:SquaresVector}) = IndexLinear()

Base.getindex(S::SquaresVector, i::Int) = i*i

s = SquaresVector(4)

s[s .> 8]

s + s

sin.(s)

struct SparseArray{T,N} <: AbstractArray{T,N}
    data::Dict{NTuple{N,Int}, T}
    dims::NTuple{N,Int}
end

SparseArray(::Type{T}, dims::Int...) where {T} = SparseArray(T, dims);

SparseArray(::Type{T}, dims::NTuple{N,Int}) where {T,N} = SparseArray{T,N}(Dict{NTuple{N,Int}, T}(), dims)

Base.size(A::SparseArray) = A.dims

Base.similar(A::SparseArray, ::Type{T}, dims::Dims) where {T} = SparseArray(T, dims)

Base.getindex(A::SparseArray{T,N}, I::Vararg{Int,N}) where {T,N} = get(A.data, I, zero(T))

Base.setindex!(A::SparseArray{T,N}, v, I::Vararg{Int,N}) where {T,N} = (A.data[I] = v)

A = SparseArray(Float64, 3, 3)

fill!(A, 2)

A[:] = 1:length(A); A

A[1:2,:]

copy(A)

A[SquaresVector(3)]

sum(A)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Strided Arrays
# -

1:5

Vector(1:5)

A = [1 5; 2 6; 3 7; 4 8]

V = view(A, 1:2, :)

V = view(A, 1:2:3, 1:2)

V = view(A, [1,2,4], :)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Customizing broadcasting

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Broadcast Styles
# -

struct MyStyle <: Broadcast.BroadcastStyle end

Base.BroadcastStyle(::Type{<:MyType}) = MyStyle()

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Selecting an appropriate output array
# -

struct ArrayAndChar{T,N} <: AbstractArray{T,N}
    data::Array{T,N}
    char::Char
end

Base.size(A::ArrayAndChar) = size(A.data)

Base.getindex(A::ArrayAndChar{T,N}, inds::Vararg{Int,N}) where {T,N} = A.data[inds...]

Base.setindex!(A::ArrayAndChar{T,N}, val, inds::Vararg{Int,N}) where {T,N} = A.data[inds...] = val

Base.showarg(io::IO, A::ArrayAndChar, toplevel) = print(io, typeof(A), " with char '", A.char, "'")

function Base.similar(bc::Broadcast.Broadcasted{Broadcast.ArrayStyle{ArrayAndChar}}, ::Type{ElType}) where ElType
    A = find_aac(bc)
    ArrayAndChar(similar(Array{ElType}, axes(bc)), A.char)
end

find_aac(bc::Base.Broadcast.Broadcasted) = find_aac(bc.args)

find_aac(args::Tuple) = find_aac(find_aac(args[1]), Base.tail(args))

find_aac(x) = x

find_aac(::Tuple{}) = nothing

find_aac(a::ArrayAndChar, rest) = a

find_aac(::Any, rest) = find_aac(rest)

a = ArrayAndChar([1 2; 3 4], 'x')

a .+ 1

a .+ [5,10]

# ### Extending broadcast with custom implementations

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Extending in-place broadcasting
# -

# #### Working with `Broadcasted` objects

# ### Writing binary broadcasting rules
