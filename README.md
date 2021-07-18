# StressStrainAnalysis

## Description
Imports .xlsx data of a tension test on a ductile metal, reports proportional, yield, utlimate, and fracture stress of material, and plots stress-strain curve.

## Methods
The .xlsx holds displacement (<img src="https://latex.codecogs.com/svg.image?\Delta&space;l&space;" title="\Delta l " />, m) and tensile force (F, N) from a tension test conducted in a load frame and the user provides the gage length (l, mm) and circular cross-section redius (mm) of tested material. The tension test data is imported and the tensile force data is smoothed with a 25-point span moving average. Stress (MPa) and strain are calculated using the following equations:
<img src="https://latex.codecogs.com/svg.image?\sigma&space;=&space;\frac{F}{A}" title="\sigma = \frac{F}{A}" />
<img src="https://latex.codecogs.com/svg.image?\epsilon=\frac{\Delta&space;l}{l}" title="\epsilon=\frac{\Delta l}{l}" />

∆l
