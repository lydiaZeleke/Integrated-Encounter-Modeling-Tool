# Integrated Encounter Modeling Tool

## Description

This repository hosts the Integrated Encounter Modeling Tool, an open-source simulation platform designed for robust Detect-and-Avoid (DAA) system evaluations. Developed at North Carolina Agricultural and Technical State University, this tool facilitates the generation of realistic encounter scenarios between various aircraft classes to test and improve DAA systems. Leveraging extensive geospatial data and multiple flight models, the tool supports a comprehensive analysis of UAS integration into the National Airspace System.

## Setup Instructions

**Environment Setup:**

After cloning the project, establish a persistent system environment named `INTEGRATED_ENC_DIR`.

**Dependencies Installation:**

Install the following packages according to the instructions provided in their respective repositories. Each package may require setting up additional environment variables:

1. **em-core**: Core library, necessary for the next packages. [GitHub Repository](https://github.com/Airspace-Encounter-Models/em-core)
2. **em-manned-bayes**: Supports the generation of manned aircraft trajectories. [GitHub Repository](https://github.com/Airspace-Encounter-Models/em-model-manned-bayes)
3. **em-model-geospatial**: Provides geospatial context for trajectory simulations. [GitHub Repository](https://github.com/Airspace-Encounter-Models/em-model-geospatial)

**Project Configuration:**

Before activating the encounter generation process, execute the following command in the main directory to configure the project settings:

```bash
matlab -r "run setup_tool.m"

**Python Setup**

Ensure Python 3.7 or higher is installed. Run the setup.py file located in the specified directory to install the required Python packages:

python setup.py install

## Encounter Generation


To start generating encounters, execute the Own_LUAS.m script located in the root directory. This script facilitates pairwise encounter simulations between an 'ownship' and an 'intruder' aircraft, which can be chosen from small UAS (sUAS), large UAS, or manned aircraft models. The tool is capable of exploring over 600 tradespace combinations of encounter parameters.

## Tool Versatility Assessment

After generating a sufficient encounter dataset, compare it with the baseline data using these steps:

For baseline dataset versatility assessment:
matlab -r "run /path/to/rn_versatility_assessment.m"

For custom dataset versatility assessment:
matlab -r "run /path/to/rn_versatility_assessment_custom.m"

Results, including statistical metrics of the ownship and intruder speed, altitude, and closing speed parameters, are saved in metricsTable.csv or metricsTable_custom.csv in the output subdirectory. Additional details about each encounter's parameters and geometry class are documented in statsTable.csv or statsTable_custom.csv. Visual representations of the probability distributions for these parameters and geometries are also available.

