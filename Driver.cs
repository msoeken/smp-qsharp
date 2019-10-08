using System;
using System.Linq;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace SmP
{
    internal class Driver
    {
        static void Main(string[] args)
        {
            using (var qsim = new QuantumSimulator())
            {
                Console.WriteLine($"Running Bell state experiment");
                100.Times(() => {
                    BellStateExperiment.Run(qsim).Wait();
                });

                Console.WriteLine($"Running GHZ state experiment");
                100.Times(() => {
                    GHZStateExperiment.Run(qsim, 5).Wait();
                });

                Console.WriteLine($"Running Teleport experiment");
                var totalZeroes = 0;
                500.Times(() => {
                    var result = TeleportExperiment.Run(qsim).Result;
                    Console.Write(result ? "1" : "0");
                    if (!result) totalZeroes++;
                });
                Console.WriteLine();
                Console.WriteLine($"Got {totalZeroes} zeroes.");

                Console.WriteLine($"Running Grover experiment");
                var secret = GroverAND.Run(qsim).Result;
                Console.WriteLine($"Found element {secret}");
            }

            var est = new ResourcesEstimator();
            GroverAND.Run(est).Wait();
            Console.WriteLine(est.ToTSV());
        }
    }

    internal static class Extensions
    {
        public static void Times(this int n, Action act)
        {
            foreach (var _ in Enumerable.Range(0, n))
            {
                act();
            }
        }
    }
}
