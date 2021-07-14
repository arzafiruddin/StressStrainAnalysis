% Ameen Rasheed Zafiruddin
% ameenrz@email.unc.edu
% 06/09/2021
% PA6_Zafiruddin.m
%
% Imports data from a tension tension test on a metal, extract various
% material properties, and plots the stress-strain analysis.

clear
clc
close all

%% Declarations
% VARIABLES
testResults = xlsread('aluminum.xlsx'); % displacement (m) and tensile
                                        % force (N) of ductile metal from
                                        % tension test
l = 38; % gage length (mm)
r = 1.5; % circular cross section radius (mm)
findEps = 0.100000000000000; % strain custom search value (dimensionless)

% INITIALIZATIONS
c = []; % initializes correlation array

%% Calculations
dL = testResults(:,1); % assigns displacement (m) from tension test results
F = testResults(:,2); % assigns tensile force (N) from tension test results
F = smooth(F,25); % smooths force data w/ 25-point span moving average

epsilon = dL ./ (l*1e-3); % calculates strain (dimensionless)
sigma = F ./ (pi * (r*1e-3)^2); % calculates stress (Pa or N/m^2)
sigma = sigma ./ 1e6;           % converts stress from Pa to MPa

% calculates the correlations between the first data point and every single
% following data point
for k = 3:length(dL)
    c = [c corr(epsilon(1:k),sigma(1:k))]; %#ok<AGROW> - supresses error
end

[cMax, cMaxI] = max(c); % assigns the [value, index] of highest correlation

propEps = epsilon(cMaxI); % assigns the proportional strain (dimensionless)
propSig = sigma(cMaxI);   % assigns the proportional stress (MPa)

% creates a "line of best fit" for the data points between the first data
% point and the proportional limit data point (poly1 --> y = mx+b, linear)
propF = fit(epsilon(1:cMaxI),sigma(1:cMaxI),'poly1');

Em = propF.p1;       % assigns elastic modulus (MPa), slope of 'propF'
Eg = propF.p1 / 1e3; % assigns elastic modulus (GPa), slope of 'propF'

% creates a new line of slope E w/ an x-intercept of 0.002
yInt = -(Em)*(0.002); % solves for y-intercept
xDataYield = epsilon; % sets x vals to same x vals/index as 'sigma' curve
                      % (this ensure that each point subtracted from
                      % 'sigma' is actually at the same x-point in 
                      % 'yDataYield')
yDataYield = Em .* xDataYield + yInt; % creates col array y vals based on x
                                      % vals/index (y = mx + b, linear)

% calculates the difference (distance) between the 'sigma' and 'yDataYield'
% curves at every point
diffYield = abs(yDataYield - sigma);
    % plot(xDataYield,diffYield); %Debugging plot (uncomment to view)

[dMin, dMinI] = min(diffYield); % assigns the [value, index] of smallest
                                % difference (where they intersect)

yieldEps = epsilon(dMinI); % assigns the yield strain (dimensionless)
yieldSig = sigma(dMinI);   % assigns the yield stress (MPa)

[uMax, uMaxI] = max(sigma); % finds the [value, index] of largest stress

ultimEps = epsilon(uMaxI); % assigns the ultimate strain (dimensionless)
ultimSig = sigma(uMaxI);   % assigns the utlimate stress (MPa)

fractEps = epsilon(end); % assigns the fracture strain (dimensionless)
fractSig = sigma(end);   % assigns the fracture stress (MPa)

findSig = spline(epsilon,sigma,findEps); % finds the exact stress at strain
                                         % 'findEps' using cubic-spline/
                                         % smooth interpolation (MPa)

% calculates resilience and toughness using trapezoidal numerical 
% integration technique
R = trapz(epsilon(1:dMinI),sigma(1:dMinI)); % resilience (MJ/m^3)
T = trapz(epsilon(dMinI:end),sigma(dMinI:end)); % toughness (MJ/m^3)

%% Outputs
% COMMAND WINDOW OUTPUTS
fprintf("STRESS-STRAIN ANALYSIS\n")
fprintf("----------------------------\n")
fprintf("Proportional Limit\n")
fprintf("     Stress: %.2f MPa\n",propSig)
fprintf("     Strain: %.4f\n",propEps)
fprintf("----------------------------\n")
fprintf("Yield Limit\n")
fprintf("     Stress: %.2f MPa\n",yieldSig)
fprintf("     Strain: %.4f\n",yieldEps)
fprintf("----------------------------\n")
fprintf("Ultimate Limit\n")
fprintf("     Stress: %.2f MPa\n",ultimSig)
fprintf("     Strain: %.4f\n",ultimEps)
fprintf("----------------------------\n")
fprintf("Fracture Limit\n")
fprintf("     Stress: %.2f MPa\n",fractSig)
fprintf("     Strain: %.4f\n",fractEps)
fprintf("----------------------------\n")
fprintf("Elastic Modulus: %.2f GPa\n", Eg)
fprintf("----------------------------\n")
fprintf("Resilience: %.2f MJ/m^2\n",R)
fprintf(" Toughness: %.2f MJ/m^2\n",T)
fprintf("----------------------------\n")
fprintf("CUSTOM SEARCH\n")
fprintf("     Stress: %.2f MPa\n",findSig)
fprintf("     Strain: %.4f\n",findEps)
fprintf("----------------------------\n")

% FIGURE PREPARATION
% restricts yield intercept line between horizontal axis and curve
xDataYieldP = xDataYield(1:dMinI);
yDataYieldP = yDataYield(1:dMinI);
xDataYieldP = xDataYieldP(yDataYieldP >= 0);
yDataYieldP = yDataYieldP(yDataYieldP >= 0);

% compiles stresses and strains for all limits
allEps = [propEps,yieldEps,ultimEps,fractEps];
allSig = [propSig,yieldSig,ultimSig,fractSig];

% FIGURE OUTPUT
figure(1)
hold on

% shades are under curve before (resilience) and after (toughness) yield
% limit two different colors
area(epsilon(1:dMinI),sigma(1:dMinI),'FaceColor','#EB4034')
area(epsilon(dMinI:end),sigma(dMinI:end),'FaceColor','#4DBEEE')

plot(epsilon,sigma,'k-') % plots stress-strain curve
plot(xDataYieldP,yDataYieldP,'k--') % plots yield-intercept line

% plots all critical points and user-selected (custom) point
scatter(allEps,allSig,'k','filled')
scatter(findEps,findSig,'o','filled','MarkerFaceColor','#D95319')

% labels critical points and user-selected (custom) point on figure
text(propEps,propSig,'\itProportional','Position',[propEps+0.003,propSig])
text(yieldEps,yieldSig,'\itYield','Position',[yieldEps+0.003,yieldSig])
text(ultimEps,ultimSig,'\itUltimate','Position',[ultimEps+0.003,ultimSig])
text(fractEps,fractSig,'\itFracture','Position',[fractEps+0.003,fractSig])
text(findEps,findSig,'\itCUSTOM','Position',[findEps-0.006,findSig-25],...
    'FontSize',7,'Color','#D95319')

% adds legend to figure
legend('Resilience','Toughness','Stress-Strain Curve',...
    'Yield-Intercept Line','Critical Limits','Custom Search Point',...
    'Location','southeast')

% labels axes and titles figure
xlabel("Strain \epsilon")
ylabel("Stress \sigma (MPa)")
title("Stress-Strain Analysis")

hold off