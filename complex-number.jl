# rectangular form 
c = 2 + 1im
cbar = conj(c)

# alternative polar representation of c
polar(r, θ) = r * (cos(θ) + sin(θ)im)
@assert(c == polar(abs(c), angle(c)))

# inverse of c, derived from z*zbar = |z|²
inverse = c -> conj(c) / abs2(c)
@assert(c * inverse(c) == 1)

# easy multiplication of complex number by adding their angles and multiplying lengths
@assert(angle(c * c) == angle(c) + angle(c))
# @assert(abs(c * c) == abs(c) * abs(c)) # False, due to precision issue of abs

# some exercises
w = polar(1, π / 6)
@assert(angle(w * w) == π / 3)

# complex multiplication using matrix
_multiply(x, y) = begin
    xr = real(x)
    xi = imag(x)
    yr = real(y)
    yi = imag(y)
    m = [xr -xi
        xi xr]
    v = m * [yr, yi]
    return v[1, 1] + v[2, 1]im
end

@assert(_multiply(c, c) == c * c)
println("DONE")