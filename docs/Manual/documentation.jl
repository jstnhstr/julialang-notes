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

# # Documentation

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Accessing Documentation
# -

?cos

?@time

?r""

# ## Writing Documentation

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Functions & Methods
# -

?catdoc

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Advanced Usage
# -

?@doc

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Dynamic documentation
# -

?Docs.getdoc

struct MyType
    value::Int
end

Docs.getdoc(t::MyType) = "Documentation for MyType with value $(t.value)"

x = MyType(1)

y = MyType(2)

?x

?y

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Syntax Guide
# -

# ### `$` and `\` characters

# ### Functions and Methods

# ### Macros

# ### Types

# ### Modules

# ### Global Variables

# ### Multiple Objects

# ### Macro-generated code

?@enum
