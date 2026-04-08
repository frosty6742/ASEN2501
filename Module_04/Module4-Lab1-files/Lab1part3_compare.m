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

%% Load the first profiles from your MSIS and IRI files

data1 = parseMSISdata('MSISprofiles/MSIS-01022020-1200-lat40.txt');

data2 = parseIRIdata('IRIprofiles/IRI-01022020-1200-lat40.txt');



%% Q3.1: plot the neutral and electron densities together

h1 = figure(1);
ax1 = axes;

% what is the total neutral density?

data1.density.total = XX       % complete this statement!

% plot both on the same panel

semilogx(ax1,data1.density.total,data1.altkm,'linewidth',2);
hold(ax1,'on');
XX

% add a legend to ax1

XX

% label your plots! 

XX
XX
XX

% change the font size

set(ax1,'Fontsize',14);

