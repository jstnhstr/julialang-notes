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

# # Metaprogramming

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Program representation
# -

prog = "1 + 1"

?Meta.parse

ex1 = Meta.parse(prog)

typeof(ex1)

?Expr

ex1.head

ex1.args

ex2 = Expr(:call, :+, 1, 1)

ex1 == ex2

?dump

dump(ex2)

ex3 = Meta.parse("(4 + 4) / 2")

dump(ex3)

?Meta.show_sexpr

Meta.show_sexpr(ex3)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Symbols
# -

s = :foo

typeof(s)

:foo == Symbol("foo")

Symbol("func",10)

Symbol(:var,'_', "sym")

:(:)

:(::)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Expressions and evaluation

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Quoting
# -

ex = :(a+b*c+1)

typeof(ex)

?Meta.@dump

dump(ex)

:(a + b*c + 1) ==
Meta.parse("a + b*c + 1") ==
Expr(:call, :+, :a, Expr(:call, :*, :b, :c), 1)

?quote

ex = quote
    x = 1
    y = 2
    x + y
end

typeof(ex)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Interpolation
# -

a = 1;

ex = :($a + b)

$a + b

ex = :(a in $:((1,2,3)))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Splatting interpolation
# -

args = [:x, :y, :z];

:(f(1, $(args...)))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Nested quote
# -

x = :(1 + 2);

e = quote quote $x end end

eval(e)

eval(eval(e))

e = quote quote $$x end end

eval(e)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### QuoteNode
# -

dump(Meta.parse(":(1+2)"))

?Meta.quot

?QuoteNode

eval(Meta.quot(Expr(:$, :(1+2))))

eval(QuoteNode(Expr(:$, :(1+2))))

dump(Meta.parse(":x"))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Evaluating expressions
# -

ex1 = :(1 + 2)

eval(ex1)

ex = :(a + b)

eval(ex)

a = 1; b = 2;

eval(ex)

ex = :(y = 1)

y

eval(ex)

y

a = 1;

ex = Expr(:call, :+, a, :b)

a = 0; b = 2;

eval(ex)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Functions on `Expr`essions
# -

function math_expr(op, op1, op2)
    expr = Expr(:call, op, op1, op2)
    return expr
end

ex = math_expr(:+, 1, Expr(:call, :*, 4, 5))

eval(ex)

function make_expr2(op, opr1, opr2)
    opr1f, opr2f = map(x -> isa(x, Number) ? 2*x : x, (opr1, opr2))
    retexpr = Expr(:call, op, opr1f, opr2f)
    return retexpr
end

make_expr2(:+, 1, 2)

ex = make_expr2(:+, 1, Expr(:call, :*, 5, 8))

eval(ex)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Macros

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Basics
# -

macro sayhello()
    return :( println("Hello, world!") )
end

@sayhello()

macro sayhello(name)
    return :( println("Hello, ", $name) )
end

@sayhello("human")

?macroexpand

ex = macroexpand(Main, :(@sayhello("human")) )

typeof(ex)

?@macroexpand

@macroexpand @sayhello "human"

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Hold up: why macros?
# -

macro twostep(arg)
    println("I execute at parse time. The argument is: ", arg)
    return :(println("I execute at runtime. The argument is: ", $arg))
end

ex = macroexpand(Main, :(@twostep :(1, 2, 3)) );

typeof(ex)

ex

eval(ex)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Macro invocation
# -

?show

macro showarg(x)
    show(x)
end

@showarg(a)

@showarg(1+1)

@showarg(println("Yo!"))

macro __LOCATION__(); return QuoteNode(__source__); end

dump(
    @__LOCATION__(
))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Building an advanced macro
# -

@assert 1 == 1.0

@assert 1 == 0

@macroexpand @assert a == b

@macroexpand @assert a==b "a should equal b!"

typeof(:("a should equal b"))

typeof(:("a ($a) should equal b ($b)!"))

dump(:("a ($a) should equal b ($b)!"))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Hygiene
# -

?time_ns

macro ⏲️(ex)
    return quote
        local t0 = time_ns()
        local val = $ex
        local t1 = time_ns()
        println("elapsed time: ", (t1-t0)/1e9, " seconds")
        val
    end
end

?esc

macro zerox()
    return esc(:(x = 0))
end

function foo()
    x = 1
    @zerox
    return x
end

foo()

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Macros and dispatch
# -

macro m end

macro m(args...)
    println("$(length(args)) arguments")
end

macro m(x,y)
    println("Two arguments")
end

@m "asd"

@m 1 2

macro m(::Int)
    println("An Integer")
end

@m 2

x = 2

@m x

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Code Generation
# -

struct MyNumber
    x::Float64
end

for op = (:sin, :cos, :tan, :log, :exp)
    eval(quote
        Base.$op(a::MyNumber) = MyNumber($op(a.x))
    end)
end

x = MyNumber(π)

sin(x)

cos(x)

for op = (:sin, :cos, :tan, :log, :exp)
    eval(:(Base.$op(a::MyNumber) = MyNumber($op(a.x))))
end

for op = (:sin, :cos, :tan, :log, :exp)
    @eval Base.$op(a::MyNumber) = MyNumber($op(a.x))
end

# ## Non-Standard String Literals

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Generated functions
# -

?@generated

@generated function foo(x)
    Core.println(x)
    return :(x * x)
end

x = foo(2);

x

y = foo("bar");

y

foo(4)

f(x) = "original definition";

g(x) = f(x);

@generated gen1(x) = f(x);

@generated gen2(x) = :(f(x));

f(x::Int) = "definition for Int";

f(x::Type{Int}) = "definition for Type{Int}";

f(1)

g(1)

gen1(1)

gen2(1)

@generated gen1(x::Real) = f(x);

gen1(1)

@generated function bar(x)
    if x <: Integer
        return :(x ^ 2)
    else
        return :(x)
    end
end

bar(4)

bar("baz")

@generated function baz(x)
    if rand() < .9
        return :(x^2)
    else
        return :("boo!")
    end
end

baz(2)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### An advanced example
# -

function sub2ind_loop(dims::NTuple{N}, I::Integer...) where N
    ind = I[N] - 1
    for i = N-1:-1:1
        ind = I[i]-1 + dims[i]*ind
    end
    return ind + 1
end

sub2ind_loop((3, 5), 1, 2)

sub2ind_rec(dims::Tuple{}) = 1;

sub2ind_rec(dims::Tuple{}, i1::Integer, I::Integer...) =
    i1 == 1 ? sub2ind_rec(dims, I...) : throw(BoundsError());

sub2ind_rec(dims::Tuple{Integer, Vararg{Integer}}, i1::Integer) = i1;

sub2ind_rec(dims::Tuple{Integer, Vararg{Integer}}, i1::Integer, I::Integer...) =
    i1 + dims[1] * (sub2ind_rec(Base.tail(dims), I...) - 1);

sub2ind_rec((3, 5), 1, 2)

@generated function sub2ind_gen(dims::NTuple{N}, I::Integer...) where N
   ex = :(I[$N] - 1)
    for i = (N - 1):-1:1
       ex = :(I[$i] - 1 + dims[$i] * $ex) 
    end
    return :($ex + 1)
end

sub2ind_gen((3, 5), 1, 2)

@generated function sub2ind_gen(dims::NTuple{N}, I::Integer...) where N
    return sub2ind_gen_impl(dims, I...)
end

function sub2ind_gen_impl(dims::Type{T}, I...) where T <: NTuple{N,Any} where N
    length(I) == N || return :(error("partial indexing is unsupported"))
    ex = :(I[$N] - 1)
    for i = (N - 1):-1:1
        ex = :(I[$i] - 1 + dims[$i] * $ex)
    end
    return :($ex + 1)
end

sub2ind_gen_impl(Tuple{Int,Int}, Int, Int)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Optionally-generated functions
# -

function sub2ind_optgen(dims::NTuple{N}, I::Integer...) where N
    if N != length(I)
        throw(ArgumentError("Number of dimensions must match number of indices."))
    end
    if @generated
        ex = :(I[$N] - 1)
        for i = (N - 1):-1:1
            ex = :(I[$i] - 1 + dims[$i] * $ex)
        end
        return :($ex + 1)
    else
        ind = I[N] - 1
        for i = (N - 1):-1:1
            ind = I[i] - 1 + dims[i]*ind
        end
        return ind + 1
    end
end
