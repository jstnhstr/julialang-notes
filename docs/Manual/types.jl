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

# # Types

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Type Declarations
# -

(1+2)::AbstractFloat

(1+2)::Int

function foo()
    x::Int8 = 100
    x
end

x = foo()

typeof(x)

function sc(x)::Float64
    if x == 0
        return 1
    end
    return sin(pi*x)/(pi*x)
end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Abstract Types
# -

?abstract type

Integer <: Number

Integer <: AbstractFloat

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Primitive Types
# -

?primitive type

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Composite Types
# -

struct Foo
    bar
    baz::Int
    qux::Float64
end

f = Foo("Hello, world.", 23, 1.5)

typeof(f)

Foo((), 23.5, 1)

fieldnames(Foo)

f.bar

f.baz

f.qux

struct X
    a::Int
    b::Float64
end

X(1, 2) === X(1, 2)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Mutable Composite Types
# -

?mutable struct

mutable struct Bar
    baz
    qux::Float64
end

bar = Bar("Hello", 1.5);

bar.qux = 2.0

bar.baz = 1//2

mutable struct Baz
    a::Int
    const b::Float64
end

baz = Baz(1, 1.5);

baz.a = 2

baz.b = 2.0

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Declared Types
# -

typeof(Real)

typeof(Int)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Type Unions
# -

IntOrString = Union{Int,AbstractString}

1 :: IntOrString

"Hello" :: IntOrString

1.0 :: IntOrString

# ## Parametric Types

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Parametric Composite Types
# -

struct Point{T}
    x::T
    y::T
end

Point{Float64}

Point{AbstractString}

Point{Float64} <: Point

Point{AbstractString} <: Point

Float64 <: Point

AbstractString <: Point

Point{Float64} <: Point{Int64}

Point{Float64} <: Point{Real}

function norm(p::Point{Real})
    sqrt(p.x^2 + p.y^2)
end

norm(Point(3.4, 4.5))

function norm(p::Point{<:Real})
    sqrt(p.x^2 + p.y^2)
end

methods(norm)

norm(Point(3.4, 4.5))

p = Point{Float64}(1.0, 2.0)

typeof(p)

Point{Float64}(1.0)

Point{Float64}(1.0,2.0,3.0)

p1 = Point(1.0,2.0)

typeof(p1)

p2 = Point(1,2)

typeof(p2)

Point(1,2.5)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Parametric Abstract Types
# -

?abstract type

abstract type Pointy{T} end

Pointy{Int64} <: Pointy

Pointy{1} <: Pointy

Pointy{Float64} <: Pointy{Real}

Pointy{Real} <: Pointy{Float64}

Pointy{Float64} <: Pointy{<:Real}

Pointy{Real} <: Pointy{>:Int}

struct Pointʸ{T} <: Pointy{T}
    x::T
    y::T
end

Pointʸ{Float64} <: Pointy{Float64}

Pointʸ{Real} <: Pointy{Real}

Pointʸ{AbstractString} <: Pointy{AbstractString}

Pointʸ{Float64} <: Pointy{Real}

Pointʸ{Float64} <: Pointy{<:Real}

struct DiagPoint{T} <: Pointy{T}
    x::T
end

abstract type Pointy2{T<:Real} end

Pointy2{Float64}

Pointy2{Real}

Pointy2{AbstractString}

Pointy2{1}

struct Pointʸ²{T<:Real} <: Pointy{T}
    x::T
    y::T
end

# ### Tuple Types

struct Tuple2{A,B}
    a::A
    b::B
end

typeof((1,"foo",2.5))

Tuple{Int,AbstractString} <: Tuple{Real,Any}

Tuple{Int,AbstractString} <: Tuple{Real,Real}

Tuple{Int,AbstractString} <: Tuple{Real,}

# ### Vararg Tuple Types

mytupletype = Tuple{AbstractString,Vararg{Int}}

isa(("1",), mytupletype)

isa(("1",1), mytupletype)

isa(("1",1,2), mytupletype)

isa(("1",1,2,3.0), mytupletype)

isa(("1",1), Tuple{AbstractString,Vararg{Int,1}})

isa(("1",1), Tuple{AbstractString,Vararg{Int,2}})

isa((1,2), NTuple{2,Int})

isa((1,2), Tuple{Vararg{Int,2}})

isa((1,2,3), NTuple{2,Int})

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Named Tuple Types
# -

typeof((a=1,b="Hello"))

@NamedTuple{a::Int, b::String}

@NamedTuple begin
    a::Int
    b::String
end

@NamedTuple{a::Float32,b::String}((1,""))

NamedTuple{(:a, :b)}((1,""))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Parametric Primitive Types
# -

?primitive type

primitive type Ptr{T} 32 end

Ptr{Float32} <: Ptr

Ptr{Int32} <: Ptr

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## UnionAll Types
# -

?where

const T1 = Array{Array{T, 1} where T, 1}

const T2 = Array{Array{T, 1}, 1} where T

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Singleton Types
# -

struct NoFields
end

NoFields() === NoFields()

Base.issingletontype(NoFields)

struct NoFieldsParam{T}
end

Base.issingletontype(NoFieldsParam)

NoFieldsParam{Int}() isa NoFieldsParam

NoFieldsParam{Bool}() isa NoFieldsParam

Base.issingletontype(NoFieldsParam{Int})

NoFieldsParam{Int}() === NoFieldsParam{Int}()

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Types of functions
# -

foo41(x) = x + 1

typeof(foo41)

T = typeof(foo41)

T <: Function

typeof(x -> x + 1)

addy(y) = x -> x + y

Base.issingletontype(addy(1))

addy(1) === addy(2)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## `Type{T}` type selectors
# -

isa(Float64, Type{Float64})

isa(Real, Type{Float64})

isa(Real, Type{Real})

isa(Float64, Type{Real})

struct TypeParamExample{T}
    x::T
end

TypeParamExample isa Type{TypeParamExample}

TypeParamExample{Int} isa Type{TypeParamExample}

TypeParamExample{Int} isa Type{TypeParamExample{Int}}

isa(Type{Float64}, Type)

isa(Float64, Type)

isa(Real, Type)

isa(1, Type)

isa("foo", Type)

struct WrapType{T}
    value::T
end

WrapType(Float64)

WrapType(::Type{T}) where T = WrapType{Type{T}}(T)

WrapType(Float64)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Type Aliases
# -

UInt

Float

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Operations on Types
# -

isa(1, Int)

isa(1, AbstractFloat)

typeof(Rational{Int})

typeof(Union{Real,String})

typeof(DataType)

typeof(Union)

?supertype

supertype(Float64)

supertype(Number)

supertype(AbstractString)

supertype(Any)

supertype(Union{Float64,Int64})

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Custom pretty-printing
# -

struct Polar{T<:Real} <: Number
    r::T
    θ::T
end

?promote

Polar(r::Real,θ::Real) = Polar(promote(r,θ)...)

Base.show(io::IO, z::Polar) = print(io, z.r, " * exp(", z.θ, "im)")

Base.show(io::IO, ::MIME"text/plain", z::Polar{T}) where {T} = print(io, "Polar{$T} complex number:\n   ", z)

Polar(3, 4.0)

[Polar(3, 4.0), Polar(4.0,5.3)]

Base.show(io::IO, ::MIME"text/html", z::Polar{T}) where {T} =
    println(io, "<code>Polar{$T}</code> complex number: ",
           z.r, " <i>e</i><sup>", z.θ, " <i>i</i></sup>")

show(stdout, "text/html", Polar(3.0,4.0))

a = Polar(3, 4.0)

print(:($a^2))

function Base.show_unquoted(io::IO, z::Polar, ::Int, precedence::Int)
   if Base.operator_precedence(:*) <= precedence
       print(io, "(")
       show(io, z)
       print(io, ")")
   else
       show(io, z)
   end
end

:($a^2)

:($a + 2)

:($a == 2)

function Base.show(io::IO, z::Polar)
   if get(io, :compact, false)
       print(io, z.r, "ℯ", z.θ, "im")
   else
       print(io, z.r, " * exp(", z.θ, "im)")
   end
end

show(IOContext(stdout, :compact=>true), Polar(3, 4.0))

[Polar(3, 4.0) Polar(4.0,5.3)]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## "Value types"
# -

struct Val{x}
end

Val(x) = Val{x}()

firstlast(::Val{true}) = "First"

firstlast(::Val{false}) = "Last"

firstlast(Val(true))

firstlast(Val(false))
