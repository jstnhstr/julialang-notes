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

# # Complex and Rational Numbers

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Complex Numbers
# -

im

1+2im

(1 + 2im)*(2 - 3im)

(1 + 2im)/(1 - 2im)

(1 + 2im) + (1 - 2im)

(-3 + 2im) - (5 - 1im)

(-1 + 2im)^2

(-1 + 2im)^2.5

(-1 + 2im)^(1 + 1im)

3(2 - 5im)

3(2 - 5im)^2

3(2 - 5im)^-1.0

2(1 - 1im)

(2 + 3im) - 1

(1 + 2im) + 0.5

(2 + 3im) - 0.5im

0.75(1 + 2im)

(2 + 3im) / 2

(1 - 3im) / (2 + 2im)

2im^2

1 + 3/4im

3/4im == 3/(4*im) == -(3/4*im)

z = 1 + 2im

real(z)

imag(z)

abs(z)

abs2(z)

angle(z)

k = 1im

sqrt(k)

sqrt(z)

cos(z)

exp(z)

sinh(z)

-1 == -1 + 0im

sqrt(-1)

sqrt(-1 + 0im)

a = 1; b = 2;

a + bim

a + b*im

# recommeneded over the multiplication operation
complex(a, b)

1 + Inf*im

complex(1, Inf)

1 + NaN*im

complex(1, NaN)

complex(NaN, NaN)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Rational Numbers
# -

2//3

6//9

-4//8

5//-15

-4//-12

numerator(2//3)

denominator(2//3)

2//3 == 6//9

2//3 == 9//27

3//7 < 1//2

3//4 > 2//3

2//4 + 1//6

5//12 - 1//4

5//8 * 3//12

6//5 / 10//7

float(3//4)

a = 1; b = 2;

isequal(float(a//b), a/b)

5//0

x = -3//0

typeof(x)

0//0

3//5 + 1

3//5 - 0.5

2//7 * (1 + 2im)

2//7 * (1.5 + 2im)

3//2 / (1 + 2im)

1//2 + 2im

1 + 2//3im

0.5 == 1//2

0.33 == 1//3

0.33 < 1//3

1//3 - 0.33
