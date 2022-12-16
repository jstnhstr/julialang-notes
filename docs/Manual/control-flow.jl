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

# # Control Flow

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Compound Expressions
# -

z = begin
    x = 1
    y = 1
    x + y
end

x

z = (x = 1; y = 2; x + y)

begin x = 1; y = 2; x + y end

(x = 1;
 y = 2;
 x + y)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Conditional Evaluation
# -

if x < y
    println("x is less than y")
elseif x > y
    println("x is greater than y")
else
    println("x is equal to y")
end

function test(x, y)
    if x < y
        println("x is less than y")
    elseif x > y
        println("x is greater than y")
    else
        println("x is equal to y")
    end
end

test(1, 2)

test(2, 1)

test(1, 1)

 function test(x,y)
   if x < y
       relation = "less than"
   elseif x == y
       relation = "equal to"
   else
       relation = "greater than"
   end
   println("x is ", relation, " y.")
end

test(2, 1)

relation

 function test(x,y)
   if x < y
       relation = "less than"
   elseif x == y
       relation = "equal to"
   end
   println("x is ", relation, " y.")
end

test(1,2)

test(2,1)

x = 3

if x > 0
    "positive!"
else
    "negative..."
end

if 1
    println("true")
end

x = 1; y = 2;

println(x < y ? "less than" : "not less than")

x = 1; y = 0;

println(x < y ? "less than" : "not less than")

test(x, y) = println(x < y ? "x is less than y"    :
                     x > y ? "x is greater than y" : "x is equal to y")

test(1, 2)

test(2, 1)

test(1, 1)

v(x) = (println(x); x)

1 < 2 ? v("yes") : v("no")

1 > 2 ? v("yes") : v("no")

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Short-Circuit Evaluation
# -

t(x) = (println(x); true)

f(x) = (println(x); false)

t(1) && t(2)

t(1) && f(2)

f(1) && t(2)

f(1) && f(2)

t(1) || t(2)

t(1) || f(2)

f(1) || t(2)

f(1) || f(2)

function fact(n::Int)
   n >= 0 || error("n must be non-negative")
   n == 0 && return 1
   n * fact(n-1)
end

fact(5)

fact(0)

fact(-1)

f(1) & t(2)

t(1) | t(2)

1 && true

true && (x = (1, 2, 3))

false && (x = (1, 2, 3))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Repeated Evaluation: Loops
# -

i = 1;

while i <= 5
    println(i)
    global i += 1
end

for i = 1:5
    println(i)
end

for j = 1:5
    println(j)
end

j

for i in [1,4,0]
    println(i)
end

i

?∈

for s ∈ ["foo","bar","baz"]
    println(s)
end

i = 1;

while true
    println(i)
    if i >= 5
        break
    end
    global i += 1
end

for j = 1:1000
    println(j)
    if j >= 5
        break
    end
end

for i = 1:10
    if i % 3 != 0
        continue
    end
    println(i)
end

for i = 1:2, j = 3:4
    println((i, j))
end

for i = 1:2, j = 3:4
    println((i, j))
    i = 0
end

for i = 1:2
    for j = 3:4
        println((i, j))
        i = 0
    end
end

for (j, k) in zip([1 2 3], [4 5 6 7])
    println((j,k))
end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Exception Handling

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Built-in `Exceptions`
# -

?InvalidStateException

sqrt(-1)

?<:

struct MyCustomException <: Exception end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### The `throw` function
# -

f(x) = x>=0 ? exp(-x) : throw(DomainError(x, "argument must be nonnegative"))

f(1)

f(-1)

typeof(DomainError(nothing)) <: Exception

typeof(DomainError) <: Exception

typeof(DomainError)

?DataType

throw(UndefVarError(:x))

struct MyUndefVarError <: Exception
    var::Symbol
end

Base.showerror(io::IO, e::MyUndefVarError) = print(io, e.var, " not defined")

throw(MyUndefVarError(:x))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Errors
# -

fussy_sqrt(x) = x >= 0 ? sqrt(x) : error("negative x not allowed")

fussy_sqrt(2)

fussy_sqrt(-1)

function verbose_fussy_sqrt(x)
   println("before fussy_sqrt")
   r = fussy_sqrt(x)
   println("after fussy_sqrt")
   return r
end

verbose_fussy_sqrt(2)

verbose_fussy_sqrt(-1)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### The `try/catch` statement
# -

try
    sqrt("ten")
catch e
    println("You should have entered a numeric value")
end

sqrt_second(x) = try
        sqrt(x[2])
    catch y
        if isa(y, DomainError)
            sqrt(complex(x[2], 0))
        elseif isa(y, BoundsError)
            sqrt(x)
        end
    end

sqrt_second([1 4])

sqrt_second([1 -4])

sqrt_second(9)

sqrt_second(-9)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### `finally` Clauses
# -

f¹ = open("outfile")
try
    write(f¹, [1 4 5])
finally
    close(f¹)
end

# ## Tasks (aka Coroutines)
