# Regularity check :school_satchel:

### Figueroa, N., & Guadalupi, C. (2023). Signaling through tests. The Quarterly Review of Economics and Finance, 92, 25-34.

This repository saves the code which can solve an single crossing problem based on beliefs. In order to do so, the main tool is a new bisection algorithm that is capable of solving multiple equations simultaneously. 

I am going to copy a relevant extract of the paper just to give the context I need to explain my code.

## The model

A firm (sender) sells a product of initially unknown quality, which can be either good ($v = 1$) or bad ($v = 0$). The firm is privately informed about his type $\theta \in \{H,L\}$, the probability of producing a good-quality product, i.e. $\theta = \mathbb{P}(v = 1)$, with $0 \leq L \leq H \leq 1$. Therefore, a high-type firm is more likely to produce good-quality products, but cannot be sure about it. We assume that quality is exogenous and marginal costs of production are zero for both types.

The firm might subject the product to a public test before launch. Tests return a binary result $d \in \{ P, F \}$, where $P$ is a pass and $F$ is a fail. Let denote by $Q_{d|v}$ the probability of result $d$ given quality $v$. Passing a test is good news about product quality, so that $Q_{P|1}− Q_{P|0} = Q_{F|0} − Q_{F|1} \geq 0$. Following Gill and Sgroi (2012), we define test toughness and expertise as follows. Test toughness is defined as the probability that a good-quality product fails the test: $\tau ∶= Q_{F|1} = 1 − Q_{P|1} > 0$, which we assume exogenous. On the other hand, we allow the firm to choose test expertise $\kappa ∶= Q_{P|1} − Q_{P|0} = Q_{F|0} − Q_{F|1} \in [0, 1 − \tau]$ at a cost $c(\kappa)$, increasing and type-independent.

The market (receiver) observes the firm’s choice of test expertise and result. It forms beliefs about product quality accordingly, and pays a price equal to the expected product quality.

#### Beliefs and payoffs

We denote by $z ∶= \mathbb{P}(\theta = H)$ beliefs about firm’s type being high and $\mu ∶= \mathbb{P}(v = 1) = zH + (1 − z) L$ beliefs about product quality being good. Prior beliefs are given by $z_0 \in [0, 1]$ and $\mu_0 \in [L, H]$, respectively. After observing expertise $\kappa$, the market forms interim beliefs $z(\kappa) ∶= \mathbb{P}(\theta = H|\kappa)$ and $\mu(\kappa) = \mathbb{P} (v = 1|\kappa) = z(\kappa)H + (1 − z(\kappa))L$. From now on we write interim beliefs $\mu(\kappa)$ as $\mu$ to save notation. Given $\mu$, posteriors are calculated via Bayes rule after observing the result $d$:
$$\lambda(\mu, \kappa) = \frac{\mu Q_{d|1}(\kappa)}{\mu Q_{d|1}(\kappa) + (1-\mu) Q_{d|0}(\kappa)}$$

After a tyest pass ($d = P$), posteriors are given by:
$$\lambda(\mu, \kappa) = \frac{\mu (1 -\tau)}{\mu(1 -\tau) + (1-\mu) (1 - \tau -\kappa)}$$
And after a test fail ($d = F$)
$$\lambda(\mu, \kappa) = \frac{\mu \tau}{\mu\tau + (1-\mu) (\tau +\kappa)}$$

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
