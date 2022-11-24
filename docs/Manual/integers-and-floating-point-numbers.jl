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

# + [markdown] tags=[]
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
# ### Overflow behavior
# -

x = typemax(Int64)

x + 1

x + 1 == typemin(Int64)

10^19

big(10)^19

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Division errors

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

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Float-point zero
# -

0.0 == -0.0

bitstring(0.0)

bitstring(-0.0)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Special floating-point values
# -

Inf16, Int32, Inf

-Inf16, -Inf32, -Inf

NaN16, NaN32, NaN

1/Inf

1/0

-5/0

0.000001/0

0/0

500 + Inf

500 - Inf

500 * Inf

Inf + Inf

Inf - Inf

Inf * Inf

Inf / Inf

0 * Inf

NaN == NaN

NaN != NaN

NaN < NaN

NaN > NaN

typemin(Float16), typemax(Float16)

typemin(Float32), typemax(Float32)

typemin(Float64), typemax(Float64)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Machine epsilon
# -

eps(Float32)

2.0^-23

eps(Float64)

eps()

2.0^-52

eps(1.0)

eps(1000.)

eps(1e-27)

eps(0.0)

x = 4.5

eps(x)

x + eps(x)

nextfloat(x)

x = 1.25f0

nextfloat(x)

prevfloat(x)

x - eps(x)

bitstring(prevfloat(x))

bitstring(x)

bitstring(nextfloat(x))

bitstring(prevfloat(x))

# ### Round modes

# + jupyter={"outputs_hidden": true} tags=[]
?RoundNearest

# + jupyter={"outputs_hidden": true} tags=[]
?RoundDown

# + jupyter={"outputs_hidden": true} tags=[]
?round
# -

# ### [Background and References](https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/#Background-and-References)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Arbitrary Precision Arithmetic
# -

BigInt(typemax(Int64)) + 1

big"123456789012345678901234567890" + 1

parse(BigInt, "123456789012345678901234567890") + 1

string(big"2"^200, base=16)

0x100000000000000000000000000000000-1 == typemax(UInt128)

0x000000000000000000000000000000000

typeof(ans)

3+1

ans

big"1.23456789012345678901"

parse(BigFloat, "1.23456789012345678901")

BigFloat(2.0^66) / 3

factorial(BigInt(40))

# + jupyter={"outputs_hidden": true} tags=[]
?factorial
# -

x = typemin(Int64)

x = x - 1

typeof(x)

y = BigInt(typemin(Int64))

y = y - 1

typeof(y)

# + jupyter={"outputs_hidden": true} tags=[]
?setprecision

# + jupyter={"outputs_hidden": true} tags=[]
?setrounding
# -

setrounding(BigFloat, RoundUp) do
   BigFloat(1) + parse(BigFloat, "0.1") 
end

setrounding(BigFloat, RoundDown) do
   BigFloat(1) + parse(BigFloat, "0.1") 
end

setprecision(40) do
   BigFloat(1) + parse(BigFloat, "0.1") 
end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Numeric Literal Coefficients
# -

x = 3

2x^2 - 3x + 1

1.5x^2 - .5x + 1

2^2x

2x

-2x

√2

√2x

(√2)x

√(2x)

2^3x

2^(3x)

(2^3)x

2x^3

2*(x^3)

(2*x)^3

2(x-1)^2 - 3(x-1) + 1

1 / 2im

6 // 2(2 + 1)

(x-1)x

(x-1)(x+1)

x(x+1)

2 x

(x+1) x

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Syntax Conflicts
# -

0xff

xff = -0.0

0 * -0.0

0xff

0 * xff

1e100

1E100

F22 = 2

1.5F22

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Literal zero and one
# -

zero(Float32)

zero(1.0)

one(Int32)

one(BigFloat)
