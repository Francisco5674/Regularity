# Regularity check :school_satchel:
This repository saves the code which can solve an info design problem based on beliefs. In order to do so, the main tool is a new bisection algorithm that is capable of solving multiple equations simultaneously. 

## Coder personal data :octocat:

| Name | Mail UC |
| :-: | :-: |
| {Francisco Fuentes} | {francisco.fuentes@uc.cl} |

## Execution :computer:
There are three relevant files to run.

|"Check_intercept.m"|"Comparative_stats.m"|
| :-: | :-: |
| This check if the $\mu$ which marks the difference between the Indiference curve (IC) slope of high type and the low type is decreasing in $\kappa$. This file looks for the intercept of the line found in "Check_decreasing.m" and the IC of the low type. | The main objective of this script is to build the vectors of $\mu$ founded in "Check_intercept.m" as a function of "C" or "L". |

# Principal Inputs and outputs

## Check_intercept.m
### Inputs
| Variable | Description                                  | Size of the vector in the grid |
|----------|----------------------------------------------|--------------------------------|
| L        | Vector of l components in [0,H)              |               nl               |
| H        | 0.8 by default              |               :no_entry_sign:              |
| C        | Vector of c components in [2,20] |               nc               |
| Tau      | Vector of tau components in (0,1)            |              ntau              |
| I      | Number of equations to be solved ($\mu$ and $\kappa$ grid size)           |    :no_entry_sign:                       |

### Output
The file "Regular_intercept.csv" is the main output, it has all the possible combinations of parameters and their respective interception $\mu$ and $\kappa$. Moreover, it is included two additional dummy variables:

| H_bigger_Int | Intercept |
| :-: | :-: |
| 1 if and only if h is bigger than Intercept_Mu | 1 if and only if there is interception |

There are two auxiliar outputs which filter "Regular_intercept.csv" by "L" ("Stat_L.csv") or "C"("Stat_C.csv") to study comparative statics.

## Check_intercept.m
### Inputs
This file has no inputs, the only relevant inputs are the outputs of "Check_intercept.m".
### Outputs
Results in a csv file called "Comp_C.csv" or "Comp_L.csv" with the parameters behind the respective behavior. The last column always reports 0 when there is at least one non increasing zone, otherwise, it reports 1.
