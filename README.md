# StressStrainAnalysis

## Description
Imports .xlsx data of a tension test on a ductile metal, reports resilience and toughness of material, and plots stress-strain curve with proportional, yield, ultimate, and fracture limits.

## Methods
The .xlsx holds displacement (<img src="https://latex.codecogs.com/svg.image?\Delta&space;l&space;" title="\Delta l " />, m) and tensile force (<img src="https://latex.codecogs.com/svg.image?F" title="F" />, N) from a tension test conducted in a load frame and the user provides the gage length (<img src="https://latex.codecogs.com/svg.image?l" title="l" />, mm) and circular cross-section redius (<img src="https://latex.codecogs.com/svg.image?r" title="r" />, mm) of tested material. The tension test data is imported and the tensile force data is smoothed with a 25-point span moving average. Stress (<img src="https://latex.codecogs.com/svg.image?\sigma&space;" title="\sigma " />, Pa) and strain (<img src="https://latex.codecogs.com/svg.image?\epsilon&space;" title="\epsilon " />) are calculated using the following equations:

> <img src="https://latex.codecogs.com/svg.image?\sigma&space;=&space;\frac{F}{A}&space;=&space;\frac{F}{\pi&space;r^{2}}" title="\sigma = \frac{F}{A} = \frac{F}{\pi r^{2}}" />

> <img src="https://latex.codecogs.com/svg.image?\epsilon=\frac{\Delta&space;l}{l}" title="\epsilon=\frac{\Delta l}{l}" />

The Proportional Limit occurs at the end of the most linear portion of the stress-strain curve, which is determined based on the series of data points that have the strongest correlation (the closest <img src="https://latex.codecogs.com/svg.image?r" title="r" /> value to 1). The slope of that line, the elastic modulus (<img src="https://latex.codecogs.com/svg.image?E" title="E" />), and a <img src="https://latex.codecogs.com/svg.image?\epsilon&space;" title="\epsilon " /> = 0.002 offset creates is used to create an intercept with the Yield Limit (the dotted line in *FIGURE #*). The Ultimate Limit occurs where <img src="https://latex.codecogs.com/svg.image?\sigma&space;" title="\sigma " /> reaches it's maximum and the Fracture Limit occurs where the material fails (the last data point on the curve). All the limits are visually represented on the stress-strain plot (as seen in *FIGURE #*).

The Resilience is calculated as the integral from <img src="https://latex.codecogs.com/svg.image?\epsilon&space;" title="\epsilon " /> = 0 to the yield strain (the region shaded red on *FIGURE #*). The Toughness is calculated as the integral of the entire stress-strain curve (the regions shaded red and cyan on *FIGURE #*).

The program also has an integrated custom search function, which will report the (<img src="https://latex.codecogs.com/svg.image?\sigma&space;" title="\sigma " /> (MPa) at a user-specified <img src="https://latex.codecogs.com/svg.image?\epsilon&space;" title="\epsilon " /> value (the orange point labelled "CUSTOM" on *FIGURE #*).
