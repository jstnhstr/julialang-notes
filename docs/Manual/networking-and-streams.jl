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

# # Networking and Streams

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Basic Stream I/O
# -

write(stdout, "Hello World");

read(stdin, Char)

x = zeros(UInt8, 4)

read!(stdin, x)

read(stdin, 4)

readline(stdin)

?eachline

for line in eachline(stdin)
    print("Found $line")
end

while !eof(stdin)
    x = read(stdin, Char)
    println("Found: $x")
end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Text I/O
# -

write(stdout, 0x61);

print(stdout, 0x61)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## IO Output Contextual Properties
# -

?IOContext

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Working with Files
# -

f = open("hello.txt");

typeof(f)

readlines(f)

f = open("hello.txt", "w")

write(f,"Hello again.")

close(f)

function read_and_capitalize(f::IOStream)
    return uppercase(read(f, String))
end

open(read_and_capitalize, "hello.txt")

open("hello.txt") do f
    uppercase(read(f, String))
end

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## A simple TCP example
# -

using Sockets

errormonitor(@async begin
    server = listen(2000)
    while true
        sock = accept(server)
        println("Hello World\n")
    end
end)

connect(2000)

errormonitor(@async begin
    server = listen(2001)
    while true
        sock = accept(server)
        @async while isopen(sock)
            write(sock, readline(sock, keep=true))
        end
    end
end)

clientside = connect(2001)

errormonitor(@async while isopen(clientside)
    write(stdout, readline(clientside, keep=true))
end)

println(clientside,"Hello World from the Echo Server")

close(clientside)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Resolving IP Addresses
# -

connect("google.com", 80)

?getaddrinfo

getaddrinfo("google.com")

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ## Asynchronous I/O
# -

task = @async open("foo.txt", "w") do io
    write(io, "Hello, World!")
end;

wait(task)

readlines("foo.txt")

?@sync

@sync for hostname in ("google.com", "github.com", "julialang.org")
    @async begin
        conn = connect(hostname, 80)
        write(conn, "GET / HTTP/1.1\r\nHost:$(hostname)\r\n\r\n")
        readline(conn, keep=true)
        println("Finished connection to $(hostname)")
    end
end

# ## Multicast

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Receiving IP Multicast Packets
# -

?recv

?join_multicast_group

?leave_multicast_group

group = ip"228.5.6.7"
socket = Sockets.UDPSocket()
bind(socket, ip"0.0.0.0", 6789)
join_multicast_group(socket, group)
println(String(recv(socket)))
leave_multicast_group(socket, group)
close(socket)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### Sending IP Multicast Packets
# -

group = ip"228.5.6.7"
socket = Sockets.UDPSocket()
send(socket, group, 6789, "Hello over IPv4")
close(socket)

# + [markdown] jp-MarkdownHeadingCollapsed=true tags=[]
# ### IPv6 Example
# -

group = Sockets.IPv6("ff05::5:6:7")
socket = Sockets.UDPSocket()
bind(socket, Sockets.IPv6("::"), 6789)
join_multicast_group(socket, group)
println(String(recv(socket)))
leave_multicast_group(socket, group)
close(socket)

group = Sockets.IPv6("ff05::5:6:7")
socket = Sockets.UDPSocket()
send(socket, group, 6789, "Hello over IPv6")
close(socket)
