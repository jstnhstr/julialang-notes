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

# # Functions

function f(x,y)
    x + y
end

f(x,y) = x + y

f(2,3)

g = f;

g(2,3)

Σ(x,y) = x + y

Σ(2,3)

# + [markdown] tags=[]
# ## Argument Passing Behavior

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Argument-type declarations
# -

fib(n::Integer) = n ≤ 2 ? one(n) : fib(n-1) + fib(n-2)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## The `return` Keyword
# -

function g¹(x,y)
    return x * y
    x + y
end

f(2,3)

g¹(2,3)

function 📐(x,y)
    x = abs(x)
    y = abs(y)
    if x > y
        r = y/x
        return x*sqrt(1+r*r)
    end
    if y == 0
        return zero(x)
    end
    r = x/y
    return y*sqrt(1+r*r)
end

📐(3,4)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Return type
# -

function g²(x,y)::Int8
    return x * y
end;

typeof(g²(1,2))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Returning nothing
# -

function printx(x)
    println("x = $x")
    return nothing
end

typeof(println(1))

printx("top")

typeof(printx("bottom"))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Operators Are Functions
# -

1 + 2 + 3

+(1,2,3)

f¹ = +;

f¹(1,2,3)

1 f¹ 2 f¹ 3

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Operators With Special Names

# + tags=[]
?hcat
# -

?vcat

?hvcat

?adjoint

?getindex

?setindex!

?getproperty

?setproperty!

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Anonymous Functions
# -

x -> x^2 + 2x - 1

function (x)
    x^2 + 2x - 1
end

map(round, [1.2, 3.5, 1.7])

map(x -> x^2 + 2x - 1, [1, 3, -1])

?get

?time

dict = Dict("a"=>1, "b"=>2);
key = "a";

get(dict, key) do
    # default value calculated here
    time()
end

get(()->time(), dict, key)

get(()->time(), dict, "c")

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Tuples
# -

(1, 1+1)

(1,)

x = (0.0, "hello", 6*7)

x[2]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Named Tuples
# -

x = (a=2, b=1+2)

x[1]

x.a

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Destructuring Assignment and Multiple Return Values
# -

(a,b,c) = 1:3

b

function foo(a,b)
    a+b, a*b
end

foo(2,3)

x, y = foo(2,3)

x

y

y, x = x, y

x

y

_, _, _, d = 1:10

d

X = zeros(3);

X

X[1], (a,b) = (1, (2, 3))

X

a

b

a, b... = "hello"

a

b

a, b... = Iterators.map(abs2, 1:4)

a

b

?Base.rest

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Property destructuring
# -

(; b, a) = (a=1, b=2, c=3)

a

b

c

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Argument destructuring
# -

mnmx(x, y) = (y < x) ? (y, x) : (x, y)

gap((min, max)) = max - min

gap(mnmx(10, 2))

foo((; x, y)) = x + y

foo((x=1, y=2))

struct A
    x
    y
end

foo(A(3, 4))

map(((x,y),) -> x + y, [(1,2), (3,4)])

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Varargs Functions
# -

bar(a,b,x...) = (a,b,x)

bar(1,2)

bar(1,2,3)

bar(1,2,3,4)

bar(1,2,3,4,5,6)

x = (3, 4)

bar(1,2,x...)

x = (2, 3, 4)

bar(1,x...)

x = (1, 2, 3, 4)

bar(x...)

x = [3,4]

bar(1,2,x...)

x = [1,2,3,4]

bar(x...)

baz(a,b) = a + b;

args = [1,2]

baz(args...)

args = [1,2,3]

baz(args...)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Optional Arguments
# -

function 📅(y::Int64, m::Int64=1, d::Int64=1)
    err = validargs(📅, y, m, d)
    err === nothing || throw(err)
    return 📅(UTD(totaldays(y, m, d)))
end

?UTD

?UTInstant

?totaldays

📅(2022)

using Dates

?Date

Date(2000, 12, 12)

Date(2000, 12)

Date(2000)

methods(Date)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Keyword Arguments
# -

function plot(x, y; style="solid", width=1, color="black")
    ###
end

x, y = 1, 2

plot(x, y, width=2)

plot(x, y; width=2)

function f(;x::Int=1)
    ###
end

function plot(x...; style="solid")
    ###
end

function f(x; y=0, kwargs...)
    ###
end

function f(x; y)
    ###
end

f(3, y=5)

f(3)

plot(x, y; :width => 2)

struct options
    width
end

opt = options(4)

opt.width

function plot(x, y; width=2)
    println("width = $width")
end

methods(plot)

plot(x, y; opt.width)

plot(x, y; opt..., width=2)

plot(x, y; width=2, width=3)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Evaluation Scope of Default Values
# -

function f(x, a=b, b=1)
    println("x = $x, a = $a, b = $b")
end

f(3,4,5)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Do-Block Syntax for Function Arguments
# -

A¹, _, B, C = -2:1

map(x->begin
            if x < 0 && iseven(x)
                return 0
            elseif x == 0
                return 1
            else
                return x
            end
        end,
    [A¹, B, C])

map([A¹, B, C]) do x
    if x < 0 && iseven(x)
        return 0
    elseif x == 0
        return 1
    else
        return x
    end
end

open("outfile", "w") do io
    write(io, "hello")
end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Function composition and piping
# -

?∘

(sqrt ∘ +)(3, 6)

sqrt(+(3, 6))

map(first ∘ reverse ∘ uppercase, split("you can compose functions like this"))

?|>

1:10 |> sum |> sqrt

(sqrt ∘ sum)(1:10)

["a", "list", "of", "strings"] .|> [uppercase, reverse, titlecase, length]

1:3 .|> (x -> x^2) |> sum |> sqrt

1:3 .|> x -> x^2 |> sum |> sqrt

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Dot Syntax for Vectorizing Functions
# -

A² = [1.0, 2.0, 3.0]

sin.(A²)

f(x,y) = 3x + 4y;

A³ = [1.0, 2.0, 3.0];

B = [4.0, 5.0, 6.0];

methods(f)

f.(pi, A³)

f.(A³, B)

C = [7.0, 8.0];

f.(B, C)

x = [4.41123440, 9.18671, 3.84521, 5.5235];

round.(x, digits=3)

# + jupyter={"outputs_hidden": true} tags=[]
?broadcast
# -

broadcast(x -> round(x, digits=3), x)

X = 5:8;

sin.(cos.(X))

broadcast(x -> sin(cos(x)), X)

[sin(cos(x)) for x in X]

sin.(sort(cos.(X)))

Y = [1.0, 2.0, 3.0, 4.0];

?similar

X = similar(Y);

@. X = sin(cos(Y))

X .= sin.(cos.(Y))

broadcast!(sin ∘ cos, X, Y)

X

[1:5;] .|> [x->x^2, inv, x->2*3, -, isodd]

# # Further Reading
