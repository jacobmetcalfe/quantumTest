using System;
using System.Threading.Tasks;
using Microsoft.Quantum.Simulation.Simulators;

namespace Host 
{
    class Program
    {
        static async Task Main(string[] args) 
        {
            using var simulator = new QuantumSimulator();
            var result = await quantumLib.Run(simulator);
            Console.WriteLine(result ? "0" : "0");
        }
    }
}