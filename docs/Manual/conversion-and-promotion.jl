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

# # Conversion and Promotion

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Conversion
# -

x = 12

typeof(x)

xu = convert(UInt8, x)

typeof(xu)

xf = convert(AbstractFloat, x)

typeof(xf)

a = Any[1 2 3; 4 5 6]

convert(Array{Float64}, a)

convert(AbstractFloat, "foo")

?parse

# + [markdown] tags=[]
# ### When is `convert` called?

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Conversion vs. Construction
# -

# #### Constructors for types unrelated to their arguments

# #### Mutable collections

# #### Wrapper types

# #### Constructors that don't return instances of their own type

# ### Defining New Conversions

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Promotion
# -

promote(1, 2.5)

promote(1, 2.5, 3)

promote(2, 3//4)

promote(1, 2.5, 3, 3//4)

promote(1.5, im)

promote(1 + 2im, 3//4)

x = Rational(Int8(15),Int32(-5))

typeof(x)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Defining Promotion Rules
# -

?promote_rule

?promote_type

# ### Case Study: Rational Promotions
