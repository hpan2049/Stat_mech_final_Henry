# Monte Carlo Simulation for Self-Avoiding Random Walk (SAW)

This repository contains MATLAB code for running Monte Carlo simulations of self-avoiding random walks (SAWs). The simulations are designed to explore critical exponents and efficiency comparisons between different methods, including Simple SAW, Dimerization, and Pivot.

## Getting Started

### Prerequisites
- MATLAB installed on your system (preferably R2020a or later).
- Basic familiarity with MATLAB for running `.m` files.

### Installation
1. Clone this repository or download the `.zip` file:
   ```bash
   git clone https://github.com/hpan2049/Stat_mech_final_Henry.git
   ```
2. Ensure all `.m` files are downloaded and stored in the same directory.

### Running the Simulation
To execute the Monte Carlo simulation:
1. Open MATLAB and set the directory to the location of the downloaded `.m` files.
2. Run the simulation by executing one of the following scripts:
   - `SAW_final.m` 
   - `SAW.m`

   These scripts serve as entry points for running the simulation and analyzing results.

### Output
- Simulations will generate numerical and graphical outputs based on the chosen SAW method (Simple SAW, Dimerization, or Pivot).
- Outputs include critical exponents and efficiency metrics.

## Repository Structure
- **Core scripts**:
  - `SAW_final.m`: Main script for running the finalized Monte Carlo simulation.
  - `SAW.m`: Alternate script for executing the simulation.
- **Supporting functions**: Individual `.m` files used for implementing simulation methods and analyses.

## License
[MIT License](LICENSE)
