# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .jl
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.14.1
#   kernelspec:
#     display_name: Julia (2 worker processes) 1.8.4
#     language: julia
#     name: julia-_2-worker-processes_-1.8
# ---

# + [markdown] tags=[]
# # Multi-processing and Distributed Computing
# -

using IJulia

?installkernel

installkernel("Julia (2 worker processes)", "-p 2")

r = remotecall(rand, 2, 2, 2)

s = @spawnat 2 1 .+ fetch(r)

fetch(s)

remotecall_fetch(r -> fetch(r)[1, 1], 2, r)

remotecall_fetch(getindex, 2, r, 1, 1)

r = @spawnat :any rand(2,2)

s = @spawnat :any 1 .+ fetch(r)

fetch(r)

fetch(s)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Code Availability and Loading Packages
# -

function rand2(dims...)
    return 2*rand(dims...)
end

rand2(2,2)

fetch(@spawnat :any rand2(2,2))

@everywhere include("DummyModule.jl")

using .DummyModule

MyType(7)

fetch(@spawnat 2 MyType(7))

fetch(@spawnat 2 DummyModule.MyType(7))

put!(RemoteChannel(2), MyType(7))

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Starting and managing worker processes
# -

using Distributed

addprocs(2)

workers()

rmprocs(4, 5)

workers()

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Data Movement
# -

A = rand(1000,1000);

Bref = @spawnat :any A^2;

fetch(Bref);

Bref = @spawnat :any rand(1000,1000)^2;

fetch(Bref);

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Global variables
# -

A = rand(10,10)

remotecall_fetch(()->sum(A), 2)

A = rand(10,10)

remotecall_fetch(()->sum(A), 3)

A = nothing



A = rand(10,10);

remotecall_fetch(()->A, 2)

B = rand(10,10);

let B = B
    remotecall_fetch(()->B, 2)
end

using InteractiveUtils

@fetchfrom 2 InteractiveUtils.varinfo()

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Parallel Map and Loops
# -

?include_string

@everywhere include_string(Main, $(read("count_heads.jl", String)), "count_heads.jl")

a = @spawnat :any count_heads(100000000)

b = @spawnat :any count_heads(100000000)

fetch(a)+fetch(b)

nheads = @distributed (+) for i = 1:200000000
    Int(rand(Bool))
end

using SharedArrays

a = SharedArray{Float64}(10)
@distributed for i = 1:10
    a[i] = i
end

a = randn(1000)
@distributed (+) for i = 1:100000
    DummyModule.f(a[rand(1:end)])
end

M = Matrix{Float64}[rand(1000,1000) for i = 1:10];

using LinearAlgebra

pmap(svdvals, M);

# ## Remote References and AbstractChannels

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Channels and RemoteChannels
# -

addprocs(2);

workers()

const jobs = RemoteChannel(()->Channel{Int}(32));

const results = RemoteChannel(()->Channel{Tuple}(32));

?myid

@everywhere function do_work(jobs, results)
    while true
        job_id = take!(jobs)
        exec_time = rand()
        sleep(exec_time)
        put!(results, (job_id, exec_time, myid()))
    end
end

function make_jobs(n)
    for i in 1:n
        put!(jobs, i)
    end
end;

n = 12;

errormonitor(@async make_jobs(n));

?remote_do

for p in workers()
    remote_do(do_work, p, jobs, results)
end

?where

@elapsed while n > 0
    job_id, exec_time, worker = take!(results)
    println("$job_id finished in $(round(exec_time; digits=2)) seconds on worker $worker")
    global n = n - 1
end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Remote References and Distributed Garbage Collection
# -

?finalize

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Local invocations
# -

using Distributed;

rc = RemoteChannel(()->Channel(3));

v = [0];

for i in 1:3
    v[1] = i
    put!(rc, v)
end;

result = [take!(rc) for _ in 1:3];

println(result);

println("Num Unique objects : " , length(unique(map(objectid, result))));

workers()[1]

rc = RemoteChannel(()->Channel(3), workers()[1]);

v = [0];

for i in 1:3
    v[1] = i
    put!(rc, v)
end;

result = [take!(rc) for _ in 1:3];

println(result);

println("Num Unique objects : " , length(unique(map(objectid, result))));

v = [0];

v2 = remotecall_fetch(x->(x[1] = 1; x), myid(), v);

println("v=$v, v2=$v2, ", v === v2);

v = [0];

v2 = remotecall_fetch(x->(x[1] = 1; x), workers()[1], v);

println("v=$v, v2=$v2, ", v === v2);

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Shared Arrays
# -

?isbits

?isbitstype

using Distributed

@everywhere using SharedArrays

?localindices

S = SharedArray{Int,2}((3,4), init = S -> S[localindices(S)] = repeat([myid()], length(localindices(S))))

S[3,2] = 7

S

?procs

S = SharedArray{Int,2}((3,4), init = S -> S[indexpids(S):length(procs(S)):length(S)] = repeat([myid()], length( indexpids(S):length(procs(S)):length(S))))

@everywhere function myrange(q::SharedArray)
    idx = indexpids(q)
    if idx == 0
        return 1:0, 1:0
    end
    nchunks = length(procs(q))
    splits = [round(Int, s) for s in range(0, stop=size(q,2), length=nchunks+1)]
    1:size(q,1), splits[idx]+1:splits[idx+1]
end

@everywhere function advection_chunk!(q, u, irange, jrange, trange)
    @show (irange, jrange, trange)
    for t in trange, j in jrange, i in irange
        q[i,j,t+1] = q[i,j,t] + u[i,j,t]
    end
    q
end

@everywhere advection_shared_chunk!(q, u) = advection_chunk!(q, u, myrange(q)..., 1:size(q,3)-1)

advection_serial!(q, u) = advection_chunk!(q, u, 1:size(q,1), 1:size(q,2), 1:size(q,3)-1);

function advection_parallel!(q, u)
    for t = 1:size(q,3)-1
        @sync @distributed for j = 1:size(q,2)
            for i = 1:size(q,1)
                q[i,j,t+1] = q[i,j,t] + u[i,j,t]
            end
        end
    end
    q
end;

function advection_shared!(q, u)
    @sync begin
        for p in procs(q)
            @async remotecall_wait(advection_shared_chunk!, p, q, u)
        end
    end
    q
end;

q = SharedArray{Float64,3}((500,500,500));

u = SharedArray{Float64,3}((500,500,500));

advection_serial!(q, u);

advection_parallel!(q, u);

advection_shared!(q, u);

@time advection_serial!(q, u);

@time advection_parallel!(q, u);

@time advection_shared!(q, u);

# ### Shared Arrays and Distributed Garbage Collection

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## ClusterManagers
# -

# ### Cluster Managers with Custom Transports

# ### Network Requirements for LocalManager and SSHManager

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Cluster Cookie
# -

?cluster_cookie

# ## Specifying Network Topology (Experimental)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Noteworthy external packages
# -

using Distributed

addprocs()

workers()

@everywhere using DistributedArrays
