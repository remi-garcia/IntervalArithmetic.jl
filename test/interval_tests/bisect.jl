using IntervalArithmetic
using Test


@testset "`bisect` function" begin
    TypesForTests = [Float16, Float32, Float64]
    for T in TypesForTests
        X = 0..1
        @test bisect(X, T(0.5)) == (T(0)..T(0.5), T(0.5)..T(1))
        @test bisect(X, T(0.25)) == (T(0)..T(0.25), T(0.25)..T(1))

        @test bisect(X) == (interval(T(0.0), T(0.49609375)), interval(T(0.49609375), T(1.0)))

        X = T(-∞)..T(∞)
        @test bisect(X, T(0.5)) == (T(-∞)..T(0), T(0)..T(∞))
        B = bisect(X, T(0.75))
        @test B[1].hi > 0
        @test B[1].hi == B[2].lo
        B = bisect(X, T(0.25))
        @test B[1].hi < 0
        @test B[1].hi == B[2].lo

        X = (T(0)..T(1)) × (T(0)..T(2))
        @test bisect(X, T(0.5)) == ( (T(0)..T(1)) × (T(0)..T(1)), (T(0)..T(1)) × (T(1)..T(2)) )
        @test bisect(X, T(0.25)) == ( (T(0)..T(1)) × (T(0)..T(0.5)), (T(0)..T(1)) × (T(0.5)..T(2)) )
        @test bisect(X, T(1), T(0.5)) == ( (T(0)..T(0.5)) × (T(0)..T(2)), (T(0.5)..T(1)) × (T(0)..T(2)) )
        @test bisect(X, T(1), T(0.25)) == ( (T(0)..T(0.25)) × (T(0)..T(2)), (T(0.25)..T(1)) × (T(0)..T(2)) )

        @test bisect(X) ==  (IntervalBox(T(0)..T(1), interval(T(0.0), T(0.9921875))),
                             IntervalBox(T(0)..T(1), Interval(T(0.9921875), T(2.0))))

        X = (T(-∞)..T(∞)) × (T(-∞)..T(∞))
        @test bisect(X, T(0.5)) == ( (T(-∞)..T(0)) × (T(-∞)..T(∞)), (T(0)..T(∞)) × (T(-∞)..T(∞)))
    end
end
