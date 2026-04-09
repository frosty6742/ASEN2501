% -----------------------------------------------------
%
% ASEN 2501: Introduction to Astronautics
% Module 4: Space Environment and Communications
%
% Lab 1: The LEO Space Environment
%
% Part 3: MSIS and IRI compared
%
% -----------------------------------------------------

clear; close all; clc

plotsDir = fullfile(pwd,'plots');
if ~exist(plotsDir,'dir')
	mkdir(plotsDir);
end

%% Load the first profiles from your MSIS and IRI files

data1 = parseMSISdata('MSISprofiles/MSIS-01022020-1200-lat40.txt');
data2 = parseIRIdata('IRIprofiles/IRI-01022020-1200-lat40.txt');



%% Q3.1: plot the neutral and electron densities together

h1 = figure(1);
ax1 = axes;

% what is the total neutral density?
data1.density.total = data1.density.O + data1.density.N2 + data1.density.O2 + data1.density.Ar + data1.density.He + data1.density.H + data1.density.N;       % complete this statement!

% plot both on the same panel
semilogx(ax1,data1.density.total,data1.altkm,'linewidth',2);
hold(ax1,'on');
semilogx(ax1, data2.density.Ne, data2.altkm, 'linewidth',2);

% add a legend to ax1
legend(ax1,'Total Neutral Density','Electron Density');

% label your plots! 
xlabel(ax1,'Density (#/cm^3)');
ylabel(ax1,'Altitude (km)');
title(ax1,sprintf('Neutral and Electron Densities for %s',datetime(data1.time)));

% change the font size
set(ax1,'Fontsize',14);

% export figure
saveas(h1, fullfile(plotsDir,'Lab1part3_compare_fig1_neutral_electron_densities.png'));

% altitudes 
alts = [100 400 700];

% interp1 my beloved!
ne_at = interp1(data2.altkm, data2.density.Ne, alts);
nn_at = interp1(data1.altkm, data1.density.total, alts);

% ionization fraction
f = ne_at ./ nn_at;

table(alts', ne_at', nn_at', f', 'VariableNames', {'Alt_km','Ne_per_cm3','Nn_per_cm3','IonFrac'})