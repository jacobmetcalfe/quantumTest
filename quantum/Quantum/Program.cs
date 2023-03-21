using System;
using System.Threading.Tasks;
using Microsoft.Quantum.Simulation.Simulators;
using Quantum.Samples;

namespace Quantum.Actual
{
    class Program
    {
        static async Task Main(string[] args)
        {
            using var simulator = new QuantumSimulator();
            Console.WriteLine("Maximum: ");
            int maximum = Convert.ToInt32(Console.ReadLine());

            var result = await GenerateRandomBit.Run(simulator, maximum);
            Console.WriteLine(result);
            await DumpReg.Run(simulator);
        }
    }
}
