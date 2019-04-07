using EnvelopedArrays
using Base.Test

@testset "EnvelopedArrays.jl" begin
   # Write your own tests here.
   a = [1.0 2.0 3.0; 4.0 5.0 6.0]
   x = EnvelopedArray(1.0,a)
   x_vcat = vcat(1.0,a)
   @test all( x .== x_vcat)
   @test x[1] == x_vcat[1]
   @test x[2] == x_vcat[2]
   @test x[end] == x_vcat[end]
   @test x[2,2] == x_vcat[2,2]
   @test all(x[1:3,1] .== x_vcat[1:3,1])
   
   
   y = EnvelopedArray(1,a)
   @test x == y
   
   @test envelope(x) == 1.0
   @test parent(x) == a
end
