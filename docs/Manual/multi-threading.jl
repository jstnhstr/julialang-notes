# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .jl
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.14.1
#   kernelspec:
#     display_name: Julia (4 threads) 1.8.4
#     language: julia
#     name: julia-_4-threads_-1.8
# ---

# # Multi-Threading

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Starting Julia with multiple threads
# -

Threads.nthreads()

using IJulia

installkernel("Julia (4 threads)", env=Dict("JULIA_NUM_THREADS"=>"4"))

installkernel("Julia (auto threads)", env=Dict("JULIA_NUM_THREADS"=>"auto"))

Threads.nthreads()

Threads.threadid()

# ## Data-race freedom

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## The `@threads` Macro
# -

a = zeros(10)

Threads.@threads for i = 1:10
    a[i] = Threads.threadid()
end

a



# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Atomic Operations
# -

i = Threads.Atomic{Int}(0);

ids = zeros(4);

old_is = zeros(4);

?Threads.atomic_add!

Threads.@threads for id in 1:4
    old_is[id] = Threads.atomic_add!(i, id)
    ids[id] = id
end

old_is

i[]

ids

using Base.Threads

nthreads()

acc = Ref(0)

@threads for i in 1:1000
    acc[] += 1
end

acc[]

acc = Atomic{Int64}(0)

@threads for i in 1:1000
    atomic_add!(acc, 1)
end

acc[]

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Per-field atomics
# -

?@atomic

?@atomicswap

?@atomicreplace

# ## Side effects and mutable function arguments

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## @threadcall
# -

?@threadcall

# ## Caveats

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Safe use of Finalizers
# -

?islocked

?trylock

?finalizer

?unlock

?Base.InvasiveLinkedListSynchronized
