namespace Quantum.Samples {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    // Maximum is max value to run against
    operation GenerateRandomBit (maximum: Int) : Int  {

        // Number of bits needed to make max number
        let bitSize = BitSizeI(maximum);

        // Set params
        mutable resultArray = [Zero, size = 0];
        mutable randomNumber = 0;

        // Used as a catch statement just in case the number generated is too large.
        repeat
        {
            set resultArray = [Zero, size = 0];

            // max int = 10, bitsize = 4, max number is 16 this creates 0001 or whatever binary may bay
            for (index in 0..bitSize - 1)
            {
                // Generate Random Number
                using (qubit = Qubit())
                {
                    H(qubit);
                    set resultArray += [M(qubit)];

                    // Debugs the position
                    DumpMachine("position.txt");
                    Reset(qubit);
                }
            }

            set randomNumber = ResultArrayAsInt(resultArray);
        }
        // If number too high restart
        until(randomNumber < maximum);
        return (randomNumber);
    }

    @EntryPoint()
    // Maximum is max value to run against
    operation DumpReg() : Unit  {
        use (qMessage, q1, q2) = (Qubit(), Qubit(), Qubit());

        // arbitrary rotation, calculates to 75%, 25% prob
        // q1, q2 just in initial state
        Ry( 2.0 * PI() / 3.0, qMessage);
        DumpRegister("qMessage-before.txt", [qMessage]);
        DumpRegister("q1-before.txt", [q1]);
        DumpRegister("q2-before.txt", [q2]);

        // Entanglement between q1, q2
        H(q1);
        CNOT(q1,q2);

        CNOT(qMessage, q1);
        H(qMessage);

        // Measurement
        let b1 = M(q1);

        if (b1 == One) {
            X(q2);
        }

        // Teleportation function
        let bMessage = M(qMessage);
        if (bMessage == One) {
            Z(q2);
        }

        DumpRegister("qMessage-after.txt", [qMessage]);
        DumpRegister("q1-after.txt", [q1]);
        DumpRegister("q2-after.txt", [q2]);

        Reset(qMessage);
        Reset(q1);
        Reset(q2);
	}
}
