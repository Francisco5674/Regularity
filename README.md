# Regularity check :school_satchel:

### Figueroa, N., & Guadalupi, C. (2023). Signaling through tests. The Quarterly Review of Economics and Finance, 92, 25-34.

This repository saves the code which can solve a single crossing problem based on beliefs. In order to do so, the main tool is a new bisection algorithm that is capable of solving multiple equations simultaneously. 

I am going to copy a relevant extract of the paper just to give the context I need to explain my code.

## The model :scroll:

A firm (sender) sells a product of initially unknown quality, which can be either good ($v = 1$) or bad ($v = 0$). The firm is privately informed about his type $\theta \in \{H,L\}$, the probability of producing a good-quality product, i.e. $\theta = \mathbb{P}(v = 1)$, with $0 \leq L \leq H \leq 1$. Therefore, a high-type firm is more likely to produce good-quality products, but cannot be sure about it. We assume that quality is exogenous and marginal costs of production are zero for both types.

The firm might subject the product to a public test before launch. Tests return a binary result $d \in \{ P, F \}$, where $P$ is a pass and $F$ is a fail. Let denote by $Q_{d|v}$ the probability of result $d$ given quality $v$. Passing a test is good news about product quality, so that $Q_{P|1}− Q_{P|0} = Q_{F|0} − Q_{F|1} \geq 0$. Following Gill and Sgroi (2012), we define test toughness and expertise as follows. Test toughness is defined as the probability that a good-quality product fails the test: $\tau ∶= Q_{F|1} = 1 − Q_{P|1} > 0$, which we assume exogenous. On the other hand, we allow the firm to choose test expertise $\kappa ∶= Q_{P|1} − Q_{P|0} = Q_{F|0} − Q_{F|1} \in [0, 1 − \tau]$ at a cost $c(\kappa)$, increasing and type-independent.

The market (receiver) observes the firm’s choice of test expertise and result. It forms beliefs about product quality accordingly, and pays a price equal to the expected product quality.

#### Beliefs and payoffs

We denote by $z ∶= \mathbb{P}(\theta = H)$ beliefs about firm’s type being high and $\mu ∶= \mathbb{P}(v = 1) = zH + (1 − z) L$ beliefs about product quality being good. Prior beliefs are given by $z_0 \in [0, 1]$ and $\mu_0 \in [L, H]$, respectively. After observing expertise $\kappa$, the market forms interim beliefs $z(\kappa) ∶= \mathbb{P}(\theta = H|\kappa)$ and $\mu(\kappa) = \mathbb{P} (v = 1|\kappa) = z(\kappa)H + (1 − z(\kappa))L$. From now on we write interim beliefs $\mu(\kappa)$ as $\mu$ to save notation. Given $\mu$, posteriors are calculated via Bayes rule after observing the result $d$:
$$\lambda_d(\mu, \kappa) = \frac{\mu Q_{d|1}(\kappa)}{\mu Q_{d|1}(\kappa) + (1-\mu) Q_{d|0}(\kappa)}$$

After a tyest pass ($d = P$), posteriors are given by:
$$\lambda_P(\mu, \kappa) = \frac{\mu (1 -\tau)}{\mu(1 -\tau) + (1-\mu) (1 - \tau -\kappa)}$$
And after a test fail ($d = F$)
$$\lambda_F(\mu, \kappa) = \frac{\mu \tau}{\mu\tau + (1-\mu) (\tau +\kappa)}$$

### This repository most important task
Given the next expressions:

1) Expected Quality of the product.
$$V(\theta, \mu, \kappa) = [1 - \tau - (1 - \theta)\kappa] \Delta(\mu,\kappa) + \lambda_F (\mu, \kappa)$$

Where:

$$\Delta(\mu,\kappa) =  \lambda_P(\mu, \kappa) - \lambda_F(\mu, \kappa)$$

2) Expected profits of the firm:

$$\pi(\theta, \mu, \kappa) = V(\theta, \mu, \kappa) - c(\kappa)$$

3) The slope of the indifference curve, obtained by implicitly differentiating is:

$$\mu'_\theta = \frac{c'(\kappa) - \frac{\partial V(\theta, \mu, \kappa)}{\partial\kappa}}{\frac{\partial V(\theta, \mu, \kappa)}{\partial\mu}}$$

Let $\tilde{\mu}(\kappa)$ be the solution to the equation $\mu'_L = \mu'_H$. The main objective is the proof to:

| Lemma 4.         |
|:---------------------------|
| If $c(\kappa) = c\kappa$, with $c\leq20$, then the function $\tilde{\mu}(\kappa)$ is decreasing in $\kappa$. |

## Coder personal data :octocat:

| Name | Mail UC |
| :-: | :-: |
| {Francisco Fuentes} | {francisco.fuentes@uc.cl} |

## Execution :computer:
There are two relevant files to run.

|```Check_intercept.m```|```Comparative_stats.m```|
| :-: | :-: |
| This check if the $\mu$ which marks the difference between the Indiference curve (IC) slope of high type and the low type is decreasing in $\kappa$. This file looks for the intercept of the line found in "Check_decreasing.m" and the IC of the low type. | The main objective of this script is to build the vectors of $\mu$ founded in "Check_intercept.m" as a function of "C" or "L". |

## Code Logic description :keyboard:

Solving an equation system to find a function is actually solving the same equation system with a dynamic parameter, in this case I have to find $\mu$ for different values of $\kappa$. Moreover, we have to check this for a big enough set of parameters such as $\tau$, $H$, $L$, and $c$. Of course, I will use a grid system and find the solution to every combination of parameters. 

However, if I use a loop for every possible combination it would be too slow and the process would take a lot of time. So, I created a bisection solving algorithm that is able to solve thousands of cases simultaneously, it is just a slight modification that will save us a lot of time.

``` BSvector.m ```

The natural way to expand a bisection algorithm would be using the norm of a vector, where each element belongs to a different equation. Then we have two vectors, we can call them $a$ and $b$, which represent the upper and lower bound we have chosen to find our solutions, as vectors, each element represents each upper and lower bound and they could potentially be different. 

Each bound is chosen carefully to use the intermediate value theorem, we take adventage of the fact that must be at least one solution to the problem if the function is continous and both bounds evaluated in the function ($f$) have opposite signs.

As usual, we have to take the middle point between each element of $a$ and $b$, this would be our first iteration. This new vector, we can call it $m$, is evaluated in the function we are trying to make zero and then we calculate the norm. If the norm is small enough (in this particular case, if it is smaller than $10^{-5}$) the process ends. If the vector is not close to the origin, then the process starts again but now $m$ takes the place of the bound that shares the same sign once evaluated in the function we are trying to solve.

``` updt.m ```

Abbreviating the word update, this functions is extremely important because it determines which element of each bound vector, $a$ and $b$, must be replaced by the element in $m$. Given $t$ as the iteration stage, it follows the next expression:

$$ a_{t+1} = a_{t} 1_{f(m) > 0} + m 1_{f(m) \leq 0}$$

$$ b_{t+1} = b_{t} 1_{f(m) \leq 0} + m 1_{f(m) > 0}$$

As you can see, I have chosen $a$ to save the non-positive values and $b$ the positive ones.

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

The file "Regular_case.csv" has columns 1-4 that report the parameters under which $\tilde{\mu}$ is computed (note that L and H do not change since they do not affect $\tilde{\mu}$). Column "Decreasing" reports 0 when there exists a non-decreasing zone, otherwise, it reports 1.

| L   | H   | C   | Tau  | Decreasing |
|-----|-----|-----|------|------------|
| 0   | 0.8 | 2   | 0.05 | 1          |
| 0   | 0.8 | 2   | 0.15 | 1          |
| 0   | 0.8 | 2   | 0.25 | 1          |
| ... | ... | ... | ...  | ...        |

> **Proof to Lemma 4**
```Regular_case.csv``` represents the proof to lemma 4, any additional output was used by the authors to study the scenario and deliver different answers.


The file "Regular_intercept.csv" has all the possible combinations of parameters and their respective interception of $\tilde{\mu}$ and indifference curve of the low type, $\mu$ and $\kappa$. Moreover, it is included two additional dummy variables:

| L   | H   | C   | Tau  | hat_mu | hat_kappa | Intercept |
|-----|-----|-----|------|--------|-----------|-----------|
| 0   | 0.8 | 2   | 0.05 | 0.827  | 0.342     | 1         |
| 0   | 0.8 | 2   | 0.15 | 0.783  | 0.345     | 1         |
| 0   | 0.8 | 2   | 0.25 | 0.766  | 0.346     | 1         |
| ... | ... | ... | ...  | ...    | ...       | ...       |

There are two auxiliar outputs which filter "Regular_intercept.csv" by "L" ("Stat_L.csv") or "C"("Stat_C.csv") to study comparative statics (Those are calculated with python).

## Comparative_stats.m
### Inputs
This file has no inputs, the only relevant inputs are the outputs of "Check_intercept.m".
### Outputs
Results in a csv file called "Comp_C.csv" or "Comp_L.csv" with the parameters behind the respective behavior. The last column always reports 0 when there is at least one non increasing zone, otherwise, it reports 1.
