module ValidatedNumerics


(VERSION < v"0.4-") && using Docile

using Compat
#using FactCheck

import Base:
    in, zero, one, abs, real, show,
    sqrt, exp, log, sin, cos, tan, inv,
    asin, acos, atan,
    union, intersect, isempty,
    convert, promote_rule, eltype,
    BigFloat, float,
    set_rounding, widen,
    ⊆, eps,
    floor, ceil


export
    Interval,
    @interval, @biginterval, @floatinterval, @make_interval,
    get_interval_rounding, set_interval_rounding,
    diam, mid, mag, mig, hull, isinside,
    emptyinterval, ∅, isempty, ⊊,
    widen,
    set_interval_precision, get_interval_precision,
    with_interval_precision,
    interval_parameters, eps, dist, roughly,
    get_pi,
    midpoint_radius, interval_from_midpoint_radius

## Root finding
export
    newton, krawczyk,
    differentiate, D, # should these be exported?
    Root, is_unique,
    find_roots,
    find_roots_midpoint



## Fix some issues with MathConst:
import Base.MPFR.BigFloat
BigFloat(a::MathConst) = big(a)

<(a::MathConst, b::MathConst) = float(a) < float(b)



## Includes


include("intervals/intervals.jl")
include("root_finding/root_finding.jl")



end # module ValidatedNumerics
