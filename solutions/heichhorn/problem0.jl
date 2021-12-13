function period(a, μ)
    return 2π * sqrt(a^3 / μ)
end

using Test

# Test that the period function works
const a = 450e3 + 6371e3
const μ = 3.986004418e14
@test period(a, μ) ≈ 5606.386763415304

using SPICE: recsph

func = recsph

# Test that `func` is the correct function
xyz = [1.0, 2.0, 3.0]

act = func(xyz)
exp = (3.741657386773941, 0.6405223126794246, 1.1071487177940904)
@test act[1] ≈ exp[1]
@test act[2] ≈ exp[2]
@test act[3] ≈ exp[3]

using LinearAlgebra: norm

function rectangular_to_spherical(xyz)
    x, y, z = xyz
    r = norm(xyz)
    θ = acos(z / r)
    ϕ = atan(y, x)
    return r, θ, ϕ
end

act = rectangular_to_spherical(xyz)
@test act[1] ≈ exp[1]
@test act[2] ≈ exp[2]
@test act[3] ≈ exp[3]


