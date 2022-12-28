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

# # Modules

?include

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Namespace management

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Qualified names
# -

parentmodule(UnitRange)

Base.:+

Base.:(==)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Export lists
# -

?export

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Standalone `using` and `import`
# -

include("./NiceStuff.jl")

using .NiceStuff

nice("dog")

Dog

import .NiceStuff

NiceStuff.nice("box")

using LinearAlgebra, Statistics

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### `using` and `import` with specific identifiers, and adding methods
# -

using .NiceStuff: nice, DOG

using .NiceStuff: nice, DOG, NiceStuff

using .NiceStuff: nice

struct Cat end

nice(::Cat) = "nice 😺"

NiceStuff.nice(::Cat) = "nice 😺"

import .NiceStuff: nice

nice(::Cat) = "nice 😺"

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Renaming with `as`
# -

import CSV: read as rd

?rd

import BenchmarkTools as BT

using CSV: read as rd

using CSV as C

# ### Mixing multiple `using` and `import` statements

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Handling name conflicts
# -

module A
export f
f() = 1
end

module B
export f
f() = 2
end

using .A, .B

f

A.f()

B.f()

using .A: f as f

using .B: f as g

f()

g()

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Default top-level definitions and bare modules
# -

?baremodule

# ### Standard modules

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Submodules and relative paths

# +
module ParentModule

module SubA
export add_D
const D = 3
add_D(x) = x + D
end

using .SubA
export add_D

module SubB
import ..SubA: add_D
struct Infinity end
add_D(x::Infinity) = x
end

end;
# -

import .ParentModule.SubA: add_D

add_D(4)

add_D(ParentModule.SubB.Infinity())

# +
module TestPackage

export x, y

x = 0

module Sub
using ..TestPackage
z = y
end

y = 1

end

# +
module D

module B
using ..C
end

module C
using ..B
end

end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Module initialization and precompilation
# -

?Base.compilecache

?include_dependency

?__precompile__

?__init__

?ccall

?IdDict

@__MODULE__

@__FILE__
