namespace SmP
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation GHZStateExperiment(n : Int) : Unit {
        using ((a, qs) = (Qubit(), Qubit[n - 1])) {
            H(a);
            ApplyToEach(CNOT(a, _), qs);

            if (M(a) == One) {
                ApplyToEach(X, [a] + qs);
            }
        }
    }
}
