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

# # Strings

?String

?transcode

?AbstractString

?AbstractChar

?Char

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Characters
# -

c = 'x'

typeof(c)

c = Int('x')

typeof(c)

Char(120)

c = Char(0x110000)

isvalid(Char, c)

'\u0', '\ud7ff'

'\ue000', '\U10ffff'

'\u0'

'\u78'

'\u2200'

'\U10ffff'

Int('\u0')

Int('\t')

Int('\n')

Int('\e')

Int('\x7f')

Int('\177')

'A' < 'a'

'A' <= 'a' <= 'Z'

'A' <= 'X' <= 'Z'

'x' - 'a'

'A' + 1

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Strings Basics
# -

str = "Hello, world.\n"

"""Contains "quote" characters"""

"This is a long \
line"

str[begin]

str[1]

str[6]

str[end]

firstindex(str)

lastindex(str)

length(str)

str[end-1]

str[end÷2]

str[begin-1]

str[end+2]

str[4:9]

str[4]

str[4:4]

str = "long string"

substr = SubString(str, 1, 4)

typeof(substr)

?chop

?chomp

?strip

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Unicode and UTF-8
# -

s = "\u2200 x \u2203 y"

s[1]

s[2]

s[3]

s[4]

nextind(s,1)

s[nextind(s,1)]

s[end-1]

s[end-2]

?prevind

s[prevind(s, end, 2)]

s[1:1]

s[1:2]

s[1:4]

s[1:nextind(s,1)]

length(s)

for c in s
    println(c)
end

?eachindex

?collect

typeof(eachindex(s))

?Base.EachStringIndex

collect(eachindex(s))

?codeunit

codeunit(s,1)

?ncodeunits

ncodeunits(s)

?codeunits

s = "\xc0\xa0\xe2\x88\xe2|"

length(s), ncodeunits(s)

codeunits(s)

?foreach

foreach(display, s) 

isvalid.(collect(s))

s2 = "\xf7\xbf\xbf\xbf"

foreach(display, s2)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Concatenation
# -

greet = "Hello"

whom = "world"

string(greet, ", ", whom, ".\n")

a, b = "\xe2\x88", "\x80"

c = string(a, b)

collect.([a, b, c])

length.([a, b, c])

greet * ", " * whom * ".\n"

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Interpolation
# -

"$greet, $whom.\n"

"1 + 2 = $(1 + 2)"

v = [1,2,3]

"v: $v"

c = 'x'

"hi, $c"

print("I have \$100 in my account.\n")

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Triple-Quoted String Literals
# -

str = """
        Hello,
        world.
    """

"""    This
    is
        a test"""

"""hello"""

"""
hello"""

"""

hello"""

"""
        Hello,
        world."""

"""
    Averylong\
    word"""

"""
    "emphasis"
"""

"a CRLF line ending\r\n"

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Common Operations
# -

"abracadabra" < "xylophone"

"abracadabra" == "xylophone"

"Hello, world." != "Goodbye, world."

"1 + 2 = 3" == "1 + 2 = $(1 + 2)"

s = "xylophone"

?findfirst

findfirst('o', s)

findlast('o', s)

findfirst('z', s)

?===

findfirst('z', s) === nothing

findnext('o', s, 1)

findnext('o', s, 5)

findprev('o', s, 5)

findnext('o', s, 8)

findnext('o', s, 8) === nothing

s = "Hello, world."

occursin("world", s)

s = "Xylophon"

occursin("o", s)

occursin("a", s)

occursin('o', s)

?repeat

repeat(".:Z:.", 10)

?join

join(["apples", "bananas", "pineapples"], ", ", " and ")

# ## Non-Standard String Literals

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Regular Expressions
# -

re = r"^\s*(?:#|$)"

typeof(re)

occursin(re, "not a comment")

occursin(re, "# a comment")

match(re, "not a comment")

match(re, "# a comment")

line = "not a comment"
m = match(re, line)
if m === nothing
    println("not a comment")
else
    println("blank or comment")
end

m = match(r"^\s*(?:#\s*(.*?)\s*$|$)", "# a comment ")

s = "aaaa1aaaa2aaaa3"

m = match(r"[0-9]",s,1)

m = match(r"[0-9]",s,6)

m = match(r"[0-9]",s,11)

m = match(r"(a|b)(c)?(d)", "acd")

m.match

m.captures

m.offset

m.offsets

m = match(r"(a|b)(c)?(d)", "ad")

m.match

m.captures

m.offset

m.offsets

first, second, third = m; first

m=match(r"(?<hour>\d+):(?<minute>\d+)","12:45")

m[:minute]

?Symbol

m[2]

replace("first second", r"(\w+) (?<agroup>\w+)" => s"\g<agroup> \1")

replace("a", r"." => s"\g<0>1")

re = r"a+.*b+.*?d$"ism

match(re, "Goodbye,\nOh, angry,\nBad world\n")

x = 10

r"$x"

"$x"

r"\X"

"\X"

using Dates

d = Date(1962,7,10)

typeof(d)

?TimeType

?day

regex_d = Regex("Day " * string(day(d)))

match(regex_d, "It happened on Day 10")

name = "Jon"

regex_name = Regex("[\"( ]\\Q$name\\E[\") ]")

match(regex_name, " Jon ")

match(regex_name, " [Jon] ") === nothing



# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Byte Array Literals
# -

b"DATA\xff\u2200"

isvalid("DATA\xff\u2200")

x = b"123"

x[1]

x[1] = 0x32

Vector{UInt8}(x)

b"\xff"

b"\uff"

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# # Version Number Literals
# -

v = v"0.2.1-rc1+win64"

v.major

v.minor

v.patch

v.prerelease

v.build

v"0.2" === v"0.2.0"

v"2" === "v.2.0.0"

VERSION

v"0.2" <= VERSION < v"0.3-"

VERSION > v"0.2-rc1+"

v"0.2-rc1+win64" > v"0.2-rc1+"

v"0.2-rc2" > v"0.2-rc1+"

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Raw String Literals
# -

println(raw"\\ \\\"")
