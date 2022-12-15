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

# ## Tuples

# ## Named Tuples

# ## Destructuring Assignment and Multiple Return Values

# ## Property destructuring

# ## Argument destructuring

# ## Varargs Functions

# ## Optional Arguments

# ## Keyword Arguments

# ## Evaluation Scope of Default Values

# ## Do-Block Syntax for Function Arguments

# ## Function composition and piping

# ## Dot Syntax for Vectorizing Functions

# ## Further Reading


