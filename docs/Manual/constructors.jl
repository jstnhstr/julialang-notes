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
#     display_name: Julia 1.8.3
#     language: julia
#     name: julia-1.8
# ---

# # Constructors

struct Foo
    bar
    baz
end

foo = Foo(1, 2)

foo.bar

foo.baz

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Outer Constructor Methods
# -

Foo(x) = Foo(x,x)

Foo(1)

Foo() = Foo(0)

Foo()

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Inner Constructor Methods
# -

?new

struct OrderedPair
    x::Real
    y::Real
    OrderedPair(x,y) = x > y ? error("out of order") : new(x,y)
end

OrderedPair(1, 2)

OrderedPair(2, 1)

struct T1
    x::Int64
end

struct T2
    x::Int64
    T2(x) = new(x)
end

T1(1)

T2(1)

T1(1.0)

T2(1.0)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Incomplete Initialization
# -

mutable struct SelfReferential
    obj::SelfReferential
end

mutable struct SelfReferential2
    obj::SelfReferential2
    SelfReferential2() = (x = new(); x.obj = x)
end

x = SelfReferential2();

x === x

x === x.obj

x === x.obj.obj

mutable struct Incomplete
    data
    Incomplete() = new()
end

z = Incomplete();

z.data

struct HasPlain
    n::Int
    HasPlain() = new()
end

HasPlain()

mutable struct Lazy
    data
    Lazy(v) = complete_me(new(), v)
end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Parametric Constructors
# -

struct Point{T<:Real}
    x::T
    y::T
end

Point(1,2)

Point(1.0,2.5)

Point(1,2.5)

Point{Int64}(1, 2)

Point{Int64}(1.0,2.5)

Point{Float64}(1.0, 2.5)

Point{Float64}(1,2)

Point(x::Int64, y::Float64) = Point(convert(Float64,x),y);

p = Point(1,2.5);

typeof(p)

Point(1.5,2)

Point(x::Real, y::Real) = Point(promote(x,y)...);

Point(1.5,2)

Point(1,1//2)

Point(1.0,1//2)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Case Study: Rational
# -

?flipsign

struct OurRational{T<:Integer} <: Real
    num::T
    den::T
    function OurRational{T}(num::T, den::T) where T<:Integer
        if num == 0 && den == 0
            error("invalid rational: 0//0")
        end
        num = flipsign(num, den)
        den = flipsign(den, den)
        g = gcd(num, den)
        num = div(num, g)
        den = div(den, g)
        new(num, den)
    end
end

OurRational(n::T, d::T) where {T<:Integer} = OurRational{T}(n,d)

# + active=""
# OurRational(n::Integer, d::Integer) = OurRational(promote(n,d)...)
# -

?one

OurRational(n::Integer) = OurRational(n, one(n))

?⊘

⊘(n::Integer, d::Integer) = OurRational(n,d)

⊘(x::OurRational, y::Integer) = x.num ⊘ (x.den*y)

⊘(x::Integer, y::OurRational) = (x*y.den) ⊘ y.num

⊘(x::Complex, y::Real) = complex(real(x) ⊘ y, imag(x) ⊘ y)

?'

⊘(x::Real, y::Complex) = (x*y') ⊘ real(y*y')

function ⊘(x::Complex, y::Complex)
    xy = x*y'
    yy = real(y*y')
    complex(real(xy) ⊘ yy, imag(xy) ⊘ yy)
end

z = (1 + 2im) ⊘ (1 - 2im);

typeof(z)

typeof(z) <: Complex{<:OurRational}

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Outer-only constructors
# -

struct SummedArray{T<:Number,S<:Number}
    data::Vector{T}
    sum::S
end

SummedArray(Int32[1; 2; 3], Int32(6))

struct SummedArray2{T<:Number,S<:Number}
    data::Vector{T}
    sum::S
    function SummedArray2(a::Vector{T}) where T
        S = widen(T)
        new{T,S}(a, sum(S, a))
    end
end

SummedArray2(Int32[1; 2; 3], Int32(6))

SummedArray2(Int32[1; 2; 3])
