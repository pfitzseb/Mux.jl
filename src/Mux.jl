module Mux

export mux, stack

# This might be the smallest core ever.

mux(f) = f
mux(m, f) = x -> m(f, x)
mux(ms...) = foldr(mux, ms)

stack(m) = m
stack(m, n) = (f, x) -> m(mux(n, f), x)
stack(ms...) = foldl(stack, ms)

branch(p, t) = (f, r) -> (p(r) ? t : f)(r)

# May as well provide a few conveniences, though.

include("server.jl")
include("basics.jl")
include("routing.jl")
include("implementations.jl")

defaults = stack(todict, basiccatch, splitquery, toresponse)

end
