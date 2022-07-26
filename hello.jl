textfile = open("text.txt", "w")
A = [1 0
    0 1]
println(textfile, A)

# What I learn about Julia in the first day?

# Let a and b be a basis of 2 dimensional real space
a = [1
    0]
b = [0
    1]

# any vector in R2 is a linear combination of v and w 
α = 0.5
β = 0.5
v = α * a + β * b

println(textfile, a)
println(textfile, b)
println(textfile, v)

# w = Av
println(textfile, A * v)

close(textfile)
