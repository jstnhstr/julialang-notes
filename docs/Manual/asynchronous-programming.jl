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

# # Asynchronous Programming

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Basic `Task` operations
# -

?Task

t = @task begin; sleep(5); println("done"); end

?schedule

schedule(t);

schedule(t); wait(t)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Communicating with Channels
# -

function producer(c::Channel)
    put!(c, "start")
    for n=1:4
        put!(c, 2n)
    end
    put!(c, "stop")
end;

chnl = Channel(producer);

take!(chnl)

for x in Channel(producer)
    println(x)
end

?bind

?schedule

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### More on Channels
# -

c = Channel(2);

put!(c, 1)

close(c);

put!(c, 2)

fetch(c)

fetch(c)

take!(c)

take!(c)

const jobs = Channel{Int}(32);

const results = Channel{Tuple}(32);

function do_work()
    for job_id in jobs
        exec_time = rand()
        sleep(exec_time)
        put!(results, (job_id, exec_time))
    end
end;

function make_jobs(n)
    for i in 1:n
        put!(jobs, i)
    end
end;

n = 12;

errormonitor(@async make_jobs(n));

for i in 1:4
    errormonitor(@async do_work())
end

@elapsed while n > 0
    job_id, exec_time = take!(results)
    println("$job_id finished in $(round(exec_time; digits=2)) seconds")
    global n = n - 1
end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## More task operations
# -

?yieldto

?current_task

?istaskdone

?istaskstarted

?task_local_storage

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Tasks and events
# -

?Condition

?notify
