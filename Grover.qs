namespace SmP
{
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation GroverAND() : Int
    {
        using (qs = Qubit[2])
        {
            ApplyToEach(H, qs);
            using (c = Qubit()) {
                within {
                    X(c);
                    H(c);
                } apply {
                    CCNOT(qs[0], qs[1], c);
                }
            }
            within {
                ApplyToEachA(BoundCA([H, X]), qs);
            } apply {
                CZ(qs[0], qs[1]);
            }
            return MeasureInteger(LittleEndian(qs));
        }
    }
}
