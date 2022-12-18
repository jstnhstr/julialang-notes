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

# # Scope of Variables

# ### Scope constructs

module Bar
    x = 1
    foo() = x
end;

import .Bar

x

x = -1;

Bar.foo()

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Global Scope
# -

module A
    a = 1
end;

module B
    module C
        c = 2
    end
    b = C.c
    import ..A
    d = A.a
end;

B.b

B.C.c

B.d

B.A.a

module D
    b = a
end;

module E
    import ..A
    A.a = 2
end;

?@show

x = 1
begin
    local x = 0
    @show x
end
@show x;

Main.x

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Local Scope
# -

s = 123

function greet()
    s = "hello"
    println(s)
end

greet()

s

function sum_to(n)
    s = 0
    for i = 1:n
        s = s + i
    end
    return s
end

sum_to(10)

s

function sum_to_def(n)
    s = 0
    for i = 1:n
        t = s + i
        s = t
    end
    return s, @isdefined(t)
end

sum_to_def(10)

t = 7

sum_to_def(10)

function sum_to_def_closure(n)
    function loop_body(i)
        v = s + i
        s = v
    end
    s = 0
    for i = 1:n
        loop_body(i)
    end
    return s, @isdefined(v)
end

sum_to_def_closure(10)

v

for i = 1:3
    v = "hello"
    println(v)
end

v

s = 0

for i = 1:10
    w = s + i
    s = w
end

s

@isdefined(w)

code = """
       s = 0 # global
       for i = 1:10
           t = s + i # new local `t`
           s = t # new local `s` with warning
       end
       s, # global
       @isdefined(t) # global
       """;

?include_string

include_string(Main, code)

# ### On Soft Scope

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Let Blocks
# -

var1 = let x
    for i in 1:5
        (i == 4) && (x = i; break)
    end
    x
end

var1

x, y, z = -1, -1, -1;

let x = 1, z
    println("x: $x, y: $y")
    println("z: $z")
end

?undef

Fs = Vector{Any}(undef, 2); i = 1;

Fs

while i <= 2
    Fs[i] = ()->i
    global i += 1
end

Fs[1]()

Fs[2]()

i

Fs = Vector{Any}(undef, 2); i = 1;

while i <= 2
    let i = i
        Fs[i] = ()->i
    end
    global i += 1
end

Fs[1]()

Fs[2]()

let
    local x = 1
    let
        local x = 2
    end
    x
end

let x = 1
    let x = 2
    end
    x
end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Loops and Comprehensions
# -

Fs = Vector{Any}(undef, 2);

for j = 1:2
    Fs[j] = ()->j
end

Fs[1]()

Fs[2]()

function f()
    i = 0
    for i = 1:3
    end
    return i
end;

f()

function f()
    i = 0
    for outer i = 1:3
    end
    return i
end;

f()

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Constants
# -

const e  = 2.71828182845904523536;

const Pi = 3.14159265358979323846;

const a, b = 1, 2

const x = 1.0

const w = 1.0

w = 1

const v = 1.0

v = 2.0

v

const u = 100

u = 100

const s1 = "1"

s2 = "1"

?pointer

pointer.([s1, s2], 1)

s1 = s2

# s1's address did not change like in the manual example.
pointer.([s1, s2], 1)

const d = [1]

d = [1]

const g = 1

f() = g

f()

g = 2

f()

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Typed Globals
# -

h::Float64 = 2.718

f() = h

Base.return_types(f)

global k::Int

k = 1.0

k

k = 3.14

x = 1

typeof(x)

global x::Int
