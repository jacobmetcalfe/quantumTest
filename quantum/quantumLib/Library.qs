namespace quantumLib {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;


    operation GenerateRandomBit() : Bool {
        use qubit = Qubit();

        H(qubit);
        let measuredBit = M(qubit);
        return measuredBit == One;
    }
}
