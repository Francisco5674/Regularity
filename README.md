# Regularity check :school_satchel:
This repository saves the code which can solve an info design problem based on beliefs. In order to do so, the main tool is a new bisection algorithm that is capable of solving multiple equations simultaneously. 

## Coder personal data :octocat:

| Name | Mail UC |
| :-: | :-: |
| {Francisco Fuentes} | {francisco.fuentes@uc.cl} |

## Execution :computer:
The main file to execute is "Main.m".

## Principal Inputs and outputs

### Regular case (C as a constant)
| Variable | Description                                  | Size of the vector in the grid |
|----------|----------------------------------------------|--------------------------------|
| L        | Vector of l components in [0,1]              |               nl               |
| H        | Vector of h components in [0,1]              |               nh               |
| C        | Vector of c components in [1,10], big enough |               nc               |
| Tau      | Vector of tau components in (0,1)            |              ntau              |
### Unregular case (C as funtion of k)
| Variable | Description                                                                                  | Size of the vector in the grid |
|----------|----------------------------------------------------------------------------------------------|--------------------------------|
| L        | Vector of l components in [0,1]                                                              |               nl               |
| H        | Vector of h components in [0,1]                                                              |               nh               |
| A        | Vector of A components in [1,10]. This is the  equivalent of "a" in the functional form of C |               nA               |
| Tau      | Vector of tau components in (0,1)                                                            |              ntau              |
| P        | Vector of p components                                                                       |         :no_entry_sign:        |

### Regular (Regular_case.csv) and Unregular (Unregular_case.csv) outputs

Both cases report their results in a csv file with the parameters behind the behavior. The last column always reports 0 when there is at least one non decreasing zone, otherwise, it reports 1.
