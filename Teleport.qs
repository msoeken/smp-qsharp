namespace SmP
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    operation Teleport(alice : Qubit, bob : Qubit) : Unit {
        using (anc = Qubit()) {
            Reset(bob);
            BellPair(anc, bob);
            Adjoint BellPair(alice, anc);
            ApplyIfOne(MResetZ(anc), (X, bob));
            ApplyIfOne(MResetZ(alice), (Z, bob));
        }
    }

    operation HadamardExperiment() : Bool {
        using (alice = Qubit()) {
            H(alice);
            return ResultAsBool(MResetZ(alice));
        }
    }

    operation TeleportExperiment() : Bool {
        using ((alice, bob) = (Qubit(), Qubit())) {
            H(alice);
            Teleport(alice, bob);
            return ResultAsBool(MResetZ(bob));
        }
    }
}
