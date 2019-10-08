namespace SmP
{
    open Microsoft.Quantum.Intrinsic;

    operation BellPair(a : Qubit, b : Qubit) : Unit is Adj {
        H(a);
        CNOT(a, b);
    }

    operation BellStateExperiment() : Unit {
        using ((a, b) = (Qubit(), Qubit())) {
            BellPair(a, b);

            if (M(a) == One) {
                X(a);
                X(b);
            }
        }
    }
}
