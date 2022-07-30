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
# Proposition: the minimum distance of a codespace is equal the minimum weight of all nonzero codes.
# Proof:
# Let W be the minimum weight of all nonzero code.
# Let D be the minimum distance.
# By way of contradiction, suppose W > D,
# Let x,y ∈ C, s.t. d(x,y) = D
# Since x-y ∈ C, we have d(x-y, 0) = D ≥ W 🚀
all_distances() = begin
    result = []
    z = zeros(7)
    for a in codespace
        if sum(a) != 0
            pushfirst!(result, d(a, z))
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

# Parity Check Matrix
H = [0 0 0 1 1 1 1
    0 1 1 0 0 1 1
    1 0 1 0 1 0 1]

print("H is a parity check matrix of G that kills every code.")
@assert(
    (H * G) .% 2 == [0 0 0 0
        0 0 0 0
        0 0 0 0])

# decode using parity check matrix
# corr = x -> (G * x) .% 2

# x = [1 0 1 0]
flip_bit0(c) = (c + Array([1, 0, 0, 0, 0, 0, 0])) .% 2
flip_bit1(c) = (c + Array([0, 1, 0, 0, 0, 0, 0])) .% 2
flip_bit2(c) = (c + Array([0, 0, 1, 0, 0, 0, 0])) .% 2
flip_bit3(c) = (c + Array([0, 0, 0, 1, 0, 0, 0])) .% 2
flip_bit4(c) = (c + Array([0, 0, 0, 0, 1, 0, 0])) .% 2
flip_bit5(c) = (c + Array([0, 0, 0, 0, 0, 1, 0])) .% 2
flip_bit6(c) = (c + Array([0, 0, 0, 0, 0, 0, 1])) .% 2

c = codespace[10]
y = flip_bit0(c)
correct0(y) = (H * y) .% 2
# RHS corresponds to the ith column of H, indicating bit flip occurs at ith bit of c.
@assert(correct0(y) == [0, 0, 1])

correct(y) = begin
    error_column = (H * y) .% 2
    for i in collect(1:7)
        if H[:, i] == error_column
            y[i] = (y[i] + 1) % 2
        end
    end
    return y
end

@assert(correct(flip_bit0(c)) == c)
@assert(correct(flip_bit1(c)) == c)
@assert(correct(flip_bit2(c)) == c)
@assert(correct(flip_bit3(c)) == c)
@assert(correct(flip_bit4(c)) == c)
@assert(correct(flip_bit5(c)) == c)
@assert(correct(flip_bit6(c)) == c)

