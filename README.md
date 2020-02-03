![Characterizing Noise](https://raw.githubusercontent.com/ashwinkk23/Characterizing_noise/master/.fig.jpg)
# Characterizing_noise

Pairwise Model SDE: 
>![equation](https://latex.codecogs.com/svg.latex?\Large&space;\frac{dm}{dt}%20=%20-2r_1m+\frac{1}{\sqrt{N}}\sqrt{2r_1+(1-m^2)r_2%20}\eta(t))

Ternary Model SDE:
> ![equation](https://latex.codecogs.com/svg.latex?\Large&space;\frac{dm}{dt}%20=%20-2r_1m%20+\frac{r_3}{2}m(1-m^2)+\frac{1}{\sqrt{N}}\sqrt{2r_1+r_2+\frac{r_3}{2}(1-m^2)}\eta(t)) 

### This repository contains codes and data used for analysis in the article "Noise-Induced Effects in Collective Dynamics and Inferring Interactions from Data".

### To generate the data required to plot the figures, run GenerateData.m.  PlotData.m plots and generates subplots containing all sub figures.

## Overview of codes
### ``Gillespie_stochastic_process.m``
>This code simulates a stochastic process using the standard algorithm presented by Sir D Gillespie, 1976. The process simulates the evolution of temporal dynamics of consensus in a population that contains individuals in two states. These individuals switch between their states via. different kinds of reactions/interactions.
### ``GS_runner1D.m``
>This contains function that runs Gillespie stochastic process.
### ``driftAndDiffusion_const_time.m``
>This code calculates the drift and diffusion constant between the expected and simulated data for a given  
&#x394;t.   
### ``SDE_continuous_Dt.m``
>This code uses a time series data and calculates the underlying deterministic and the stochastic coefficients for continuous time scales.
### ``SDE_different_Dt.m``
>This code uses a time series data and calculates the underlying deterministic and the stochastic coefficients for different time scales.

### ``optDt_changing_r1.m``
>Similar to ``Gillespie_stochastic_process.m`` and ``GS_runner1D.m``, this code simulates the stochastic process using the same standard algorithm. Following this, we also derive the underlying SDE from data and compare the reconstructed functions with the expected ones by varying the pairwise interaction rates.
### ``optDt_changing_N.m``
>This code does a similar analysis like the one done by the above mentioned code for ternary interaction by varying the system size (N).
### ``varying_resolution.m``
>The code simulates the Gillespie process for a given system by varying the time interval &#948;t, and returns the RMS mean of the difference between the expected drift and that for simulated data.
### `` underlyingNoise.m`` 
>A function that calculates the underlying noise in the given signal, based on the using the stochastic part of the derived SDE. This is done to verify if the noise in the signal is Gaussian in nature.

