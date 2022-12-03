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

# # Mathematical Operations and Elementary Functions

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Arithmetic Operators
# -

x = 1; y = 2

+x

-x

x + y

x - y

x * y

x / y

x ÷ y

x // y

?//

x \ y

y / x

x ^ y

x % y

rem(x,y)

1 + 2 + 3

1 - 2

3 * 2 / 12

-x + 2

-false

NaN * false

false * Inf

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Boolean Operators
# -

x = true; y = false

!x

x && y

x || y

?Bool

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Bitwise Operators
# -

x = UInt8(1); y = UInt8(2)

bitstring(x)

bitstring(y)

~x

x & y

x | y

x ⊻ y

x ⊼ y

x ⊽ y

bitstring(x)

x >>> y

x >> y

bitstring(-2)

-2 >> 1

bitstring(-1)

bitstring(-2 >>> 3)

x << y

bitstring(x << y)

-2 << 3

bitstring(-2 << 3)

~123

bitstring(123)

bitstring(~123)

bitstring(234)

123 | 234

bitstring(123 | 234)

xor(123, 234)

123 ⊻ 234

nand(123, 123)

123 ⊼ 123

nor(123, 124)

123 ⊽ 124

~UInt32(123)

~UInt8(123)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Updating operators
# -

x = 1

x += 3

x = x + 3

?&=

x = 0x01; typeof(x)

x *= 2; typeof(x)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Vectorized "dot" operators
# -

x = [1,2,3]

x ^ 3

x .^ 3

.![false, true, false]

.√x

(^).(x,3)

A = [5,6,7]

2 .* A.^2 .+ sin.(A)

?@

@. 2A^2 + sin(A)

?⊗

⊗(A,B) = kron(A,B)

[A,A] .⊗ [A,A]

[A⊗A, A⊗A]

1.+x

1. + x

# + jp-MarkdownHeadingCollapsed=true tags=[]
1 .+ x
# -

@. 1 + x

(+).(1,x)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Numeric Comparisons
# -

1 == 1

1 == 2

1 != 2

1 == 1.0

1 < 2

1.0 > 3

1 >= 1.0

-1 <= 1

-1 <= -2

3 < -0.5

+0 > -0

Inf > NaN

-Inf < NaN

NaN == NaN, NaN < NaN, NaN > NaN

NaN != NaN

[1 NaN] == [1 NaN]

isequal(NaN, NaN)

isequal([1 NaN], [1 NaN])

isequal(NaN, NaN32)

-0.0 == 0.0

isequal(-0.0, 0.0)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Chaining comparisons
# -

1 < 2 <= 2 < 3 == 3 > 2 >= 1 == 1 < 3 != 5

A = [0.3, 0.5, 2.1, 1.1, 7.6]

0 .< A .< 1

@. 0 < A < 1

v(x) = (println(x); x)

v(1) < v(2) <= v(3)

v(1) > v(2) <= v(3)

v(1) < v(2) && v(2) <= v(3)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Elementary Functions
# -

sin.(A)

@. sin(A)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Operator Precedence and Associativity
# -

?:

Base.operator_precedence(:+), Base.operator_precedence(:*), Base.operator_precedence(:.)

Base.operator_precedence(:sin), Base.operator_precedence(:+=), Base.operator_precedence(:(=))

Base.operator_associativity(:-), Base.operator_associativity(:+), Base.operator_associativity(:^)

Base.operator_associativity(:⊗), Base.operator_associativity(:sin), Base.operator_associativity(:→)

?→

x = 3; 2x^2

2^2x

x = 3.0; y = 4

-x^y

-(x^y)

2x^y

2(x^y)

(2x)^y

x^-y

x^(-y)

x^2y

x^(2y)

(x^2)y

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Numerical Conversions
# -

Int8(127)

Int8(128)

Int8(3.14)

Int8(128.0)

127 % Int8

128 % Int8

bitstring(128)

bitstring(128 % Int8)

bitstring(-128)

round(Int8,127.4)

round(Int8,127.6)

# ### Rounding functions

# ### Division functions

# ### Sign and absolute value functions

# ### Powers, logs and roots

# ### Trigonometric and hyperbolic functions

# ### Special functions
