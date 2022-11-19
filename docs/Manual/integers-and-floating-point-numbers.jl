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
#     display_name: Julia 1.8.2
#     language: julia
#     name: julia-1.8
# ---

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# # Integers and Floating-Point Numbers

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Integers
# -

1

typeof(1)

Sys.WORD_SIZE

?Sys

Int

UInt

typeof(3000000000)

2^31-1

2^63-1

"""
2147483647
3000000000
"""

x = 0x1

typeof(x)

x = 0x1234567

typeof(x)

x = 0x1234567abcdef

typeof(x)

x = 0x11112222333344445555666677778888

typeof(x)

x = 0b10

typeof(x)

x = 0o010

typeof(x)

x = 0x01

typeof(x)

x = 0x0001

typeof(x)

-0x2

typeof(0x2), typeof(-0x2)

-0x0002

typeof(0x0002), typeof(-0x0002)

(typemin(Int32), typemax(Int32))

typemin(Int32), typemax(Int32)

for T in [Int8,Int16,Int32,Int64,Int128,UInt8,UInt16,UInt32,UInt64,UInt128]
    println("$(lpad(T,7)): [$(typemin(T)),$(typemax(T))]")
end

# + jupyter={"outputs_hidden": true} tags=[]
?lpad
# -

T

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Overflow behavior
# -

x = typemax(Int64)

x + 1

x + 1 == typemin(Int64)

10^19

big(10)^19

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Division errors

# + jupyter={"outputs_hidden": true} tags=[]
?div

# + jupyter={"outputs_hidden": true} tags=[]
4 ÷ 0

# + jupyter={"outputs_hidden": true} tags=[]
typemin(Int) ÷ -1

# + jupyter={"outputs_hidden": true} tags=[]
?rem

# + jupyter={"outputs_hidden": true} tags=[]
2 % 0

# + jupyter={"outputs_hidden": true} tags=[]
?mod

# + jupyter={"outputs_hidden": true} tags=[]
mod(1, 0)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Floating-Point Numbers
# -

1.0

1.

0.5

.5

x = -1.23

typeof(x)

1e10

x = 2.5e-4

typeof(x)

x = 0.5f0

typeof(x)

Float32(-1.5)

0x1p0

0x1.8p3

x = 0x.4p-1

typeof(x)

sizeof(Float16(4.))

2*Float16(4.)

10_000, 0.000_000_005, 0xdead_beef, 0b1011_0010
