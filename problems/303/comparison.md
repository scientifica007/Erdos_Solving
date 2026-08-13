# Historical Comparison — Erdős Problem #303

## Blind result

The blind attempt was closed as incomplete after a genuine structural reduction but without a justified coloring theorem. The record was not rewritten after reference access.

Established independently:
- `(b-a)(c-a)=a^2`.
- The two-parameter solution family `(a,b,c)=(AB,A(A+B),B(A+B))`.
- The special identity `1/n = 1/(n+1) + 1/(n(n+1))`.

The bottleneck was proving a finite-coloring configuration from these families.

## Reference result

Brown and Rödl (1991) prove a substantially more general theorem: if a system of homogeneous equations `G(x_1,...,x_n)=0` is partition-regular on the positive integers with distinct monochromatic solutions, then the reciprocal system `G(1/z_1,...,1/z_n)=0` is also partition-regular with distinct monochromatic solutions.

Their proof is a compactness + least-common-multiple argument:

1. For a fixed number of colours, compactness gives a finite `T` such that every colouring of `[1,T]` has the required monochromatic solution to the homogeneous system.
2. Let `S = lcm(1,...,T)`.
3. Given a colouring of `[1,S]`, induce a colouring of `[1,T]` by `\bar c(x)=c(S/x)`.
4. Take the guaranteed monochromatic solution `y_i` to `G(y_1,...,y_n)=0`.
5. Set `z_i=S/y_i`. The `z_i` remain monochromatic and distinct, while homogeneity gives `G(1/z_1,...,1/z_n)=0`.

For #303, take the homogeneous linear equation

`x_0 = x_1 + x_2`.

Rado's theorem gives a monochromatic solution in distinct positive integers. Brown–Rödl's reciprocal-transfer theorem therefore gives distinct monochromatic `z_0,z_1,z_2` satisfying

`1/z_0 = 1/z_1 + 1/z_2`.

This proves #303.

## Comparison with our blind attempt

Our attempt stayed on the reciprocal equation itself and tried to force a monochromatic member of a rational/polynomial parametrized family. The reference method instead removes the reciprocal difficulty first and transfers a known partition-regular homogeneous equation through inversion.

The decisive missing insight was therefore **problem transformation**, not a more elaborate search inside the original equation.

## Methodological classification

- Blind proof: FAILED / INCOMPLETE.
- Reference proof: VALID and independently attributed to Brown–Rödl (1991).
- Main reusable idea: when an equation contains reciprocals of variables, test whether its reciprocal form comes from a homogeneous partition-regular equation.
- Benchmark assessment: #303 is not a shallow benchmark. Its one-line statement hides a compactness/Rado argument. It should be classified as an intermediate Ramsey-theoretic benchmark, not an elementary one.

## Sources

Brown, T. C. and Rödl, V., *Monochromatic solutions to equations with unit fractions*, Bull. Austral. Math. Soc. 43 (1991), 387–392.
