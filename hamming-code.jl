# hamming - code
G = [1 0 0 0
    0 1 0 0
    0 0 1 0
    0 0 0 1
    0 1 1 1
    1 0 1 1
    1 1 0 1]

enc = x -> (G * x) .% 2

distance(x, y) = sum(abs.(x - y))
d = distance

weight(x) = distance(x, zeros(size(x)))
w = weight
# random vector generator
rg = () -> abs.(rand(Int64, 4)) .% 2

# debug enc
_enc(x) = begin
    println(x)
    result = enc(x)
    println("->")
    println(result)
    println()
    return result
end


distance(_enc(rg()), _enc(rg()))

# Observation 1: the distance between an all-zero code and an all-1 code is 4.
# Therefore the maximum distance is at least 4.
# What is the maximum distance of hamming code?

# encode 0 to 15 using 4-element vector
v(x) = begin
    @assert(x < 16)
    return [x & 1, (x >> 1) & 1, (x >> 2) & 1, (x >> 3) & 1]
end
# generate the entire code space
codespace = [enc(v(x)) for x in collect(1:15)]
# find the min and max distance
all_distances() = begin
    result = []
    for a in codespace
        for b in codespace
            if a != b
                pushfirst!(result, d(a, b))
            end
        end
    end
    return result
end

all_dist = all_distances()
println("Hamming 7 3 4 code")
println("minimum distance ", minimum(all_dist))
println("maximum distance ", maximum(all_dist))

# Observation 2: the xor is often written as ⊕, because it is equivalent to addition modulo 2.

# Observation 3
# Hamming 7 4 3 code, 7 is block length, 4 is the number of basis vectors, 3
# is the minimum distance.
# minimum distance 3
# maximum distance 7

# Concept of Relative distance
# The relative distance of a code is the minimum distance over block length 
# For example, the relative distance of hamming code is 3/7
