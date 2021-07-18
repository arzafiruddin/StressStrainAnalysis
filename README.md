# StressStrainAnalysis

## Description
Imports .xlsx data of a tension test on a ductile metal, reports proportional, yield, utlimate, and fracture stress of material, and plots stress-strain curve.

## Methods
The .xlsx holds displacement (<img src="https://latex.codecogs.com/svg.image?\Delta&space;l&space;" title="\Delta l " />, m) and tensile force (<img src="https://latex.codecogs.com/svg.image?F" title="F" />, N) from a tension test conducted in a load frame and the user provides the gage length (<img src="https://latex.codecogs.com/svg.image?l" title="l" />, mm) and circular cross-section redius (<img src="https://latex.codecogs.com/svg.image?r" title="r" />, mm) of tested material. The tension test data is imported and the tensile force data is smoothed with a 25-point span moving average. Stress (<img src="https://latex.codecogs.com/svg.image?\sigma&space;" title="\sigma " />, MPa) and strain (<img src="https://latex.codecogs.com/svg.image?\epsilon&space;" title="\epsilon " />) are calculated using the following equations:

<img src="https://latex.codecogs.com/svg.image?\sigma&space;=&space;\frac{F}{A}&space;=&space;\frac{F}{\pi&space;r^{2}}" title="\sigma = \frac{F}{A} = \frac{F}{\pi r^{2}}" />
<img src="https://latex.codecogs.com/svg.image?\epsilon=\frac{\Delta&space;l}{l}" title="\epsilon=\frac{\Delta l}{l}" />
