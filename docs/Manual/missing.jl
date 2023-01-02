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

# # Missing Values

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Propagation of Missing Values
# -

missing + 1

"a" * missing

abs(missing)

import Missings: passmissing

?passmissing

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Equality and Comparison Operators
# -

missing == 1

missing == missing

missing < 1

2 >= missing

ismissing(missing)

missing === 1

isequal(missing, 1)

missing === missing

isequal(missing, missing)

isless(1, missing)

isless(missing, Inf)

isless(missing, missing)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Logical operators
# -

true | true

true | false

false | true

true | missing

missing | true

false | true

true | false

false | false

false | missing

missing | false

false & false

false & true

false & missing

true & true

true & false

true & missing

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Control Flow and Short-Circuiting Operators
# -

if missing
    println("here")
end

missing || false

missing && false

true && missing && false

true && missing

false && missing

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Arrays with Missing Values
# -

[1, missing] 

Array{Union{Missing, String}}(missing, 2, 3)

x = Union{Missing, String}["a", "b"]

convert(Array{String}, x)

y = Union{Missing, String}[missing, "b"]

convert(Array{String}, y)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Skipping Missing Values
# -

sum([1, missing])

?skipmissing

sum(skipmissing([1, missing]))

x = skipmissing([3, missing, 2, 1])

maximum(x)

import Statistics: mean

mean(x)

mapreduce(sqrt, +, x)

x[1]

x[2]

findall(==(1), x)

findfirst(!iszero, x)

argmax(1)

collect(x)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Logical Operations on Arrays
# -

[1, missing] == [2, missing]

[1, missing] == [1, missing]

[1, 2, missing] == [1, missing, 2]

isequal([1, missing], [1, missing])

isequal([1, 2, missing], [1, missing, 2])

all([true, missing])

all([false, missing])

any([true, missing])

any([false, missing])
