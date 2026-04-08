% -----------------------------------------------------
%
% ASEN 2501: Introduction to Astronautics
% Module 4: Space Environment and Communications
%
% Lab 1: The LEO Space Environment
%
% Part 1: Plotting MSIS Profiles
%
% -----------------------------------------------------

clear; close all; clc

s = settings;
s.matlab.appearance.figure.GraphicsTheme.TemporaryValue = "light";

%% Load the first profiles from your downloaded MSIS files

% This function parses the data in the file into the appropriate columns.
% Having a separate function makes it easy to repeat  on more files
% (as you'll see later)

data1 = parseMSISdata('MSISprofiles/MSIS-01022020-1200-lat40.txt');



%% Q3.1: plot the mass density

h1 = figure(1);
ax1 = axes;

semilogx(ax1,data1.density.mass,data1.altkm,'linewidth',2);

% label your plots! You should always have these three things:

xlabel(ax1,'Mass density (g/cm^3)');
ylabel(ax1,'Altitude (km)');
title(ax1,sprintf('Mass density for %s',datetime(data1.time)));

% change the font size

set(ax1,'Fontsize',14);                          % the default tiny font drives me crazy


%% Q3.2: plot the number densities of all species: O, N2, O2, Ar, He, H, and N

h2 = figure(2);
ax2 = axes;

semilogx(ax2,data1.density.O,data1.altkm,'linewidth',1.5);
hold(ax2,'on');
XX
XX
XX
XX
XX
XX

legend(ax2,'Oxygen 1','Nitrogen 2','Oxygen 2','Argon','Helium','Hydrogen','Nitrogen 1')

% label your plots! 

xlabel(ax2,'Number density (#/cm^3)');
XX
XX

% change the font size

set(ax2,'Fontsize',14);

% you'll get a weird plot with 10^-38 values, so set the plot limits to the
% range we care about

set(ax2,'xlim',[1e0 1e20]);


%% Q3.3: plot the temperature profile 

h3 = figure(3);
ax3 = axes;

% plot the temperature profile

XX

% label your plots! 

XX
XX
XX

% change the font size

set(ax3,'Fontsize',14);


%% Load the other data files

% data2: same date, but midnight 
data2 = parseMSISdata('MSISprofiles/MSIS-01022020-0000-lat40.txt');

% data3: same date and time, 0 latitude
data3 = parseMSISdata('MSISprofiles/MSIS-01022020-1200-lat00.txt');

% data4: same date and time, 80 latitude
data4 = parseMSISdata('MSISprofiles/MSIS-01022020-1200-lat80.txt');

% data5: same time and lat, July 2022 
data5 = parseMSISdata('MSISprofiles/MSIS-07052022-1200-lat40.txt');


%% day/night comparison: data1 and data2. Learn subplots!

h4 = figure(4);
set(h4,'position',[800 600 1400 500]);      % wider!
ax41 = subplot(1,3,1);          % creates the first in a 1 x 3 array of panels 
ax42 = subplot(1,3,2);
ax43 = subplot(1,3,3);

% MASS DENSITY: plot data1 and data2 mass density to compare.

semilogx(ax41,data1.density.mass,data1.altkm,'linewidth',1.5);
hold(ax41,'on');
XX

legend(ax41,'Noon','Midnight');

% label your plots! 

XX
XX
XX

% change the font size

set(ax41,'Fontsize',14);

% NUMBER DENSITY: just do N2, O, and He for both data1 and data2.

semilogx(ax42,data1.density.N2,data1.altkm,'linewidth',1.5);
hold(ax42,'on');
XX
XX
XX
XX
XX

legend(ax42,'N2 Noon','N2 Midnight','O Noon','O Midnight','He Noon','He Midnight');

% label your plots! 

XX
XX
XX

set(ax42,'xlim',[1e0 1e20]);

% change the font size

set(ax42,'Fontsize',14);

% TEMPERATURE: plot tempK for both data1 and data2

plot(ax43,data1.tempK,data1.altkm,'linewidth',1.5);
hold(ax43,'on');
XX

legend(ax43,'Noon','Midnight');

% label your plots! 

XX
XX
XX

% change the font size

set(ax43,'Fontsize',14);


%% latitude comparison: data1, data3, data4

h5 = figure(5);
set(h5,'position',[800 600 1400 500]);      % wider!
ax51 = subplot(1,3,1);          % creates the first in a 1 x 3 array of panels 
ax52 = subplot(1,3,2);
ax53 = subplot(1,3,3);

% MASS DENSITY: plot for data1, data3, and data4

semilogx(ax51,data1.density.mass,data1.altkm,'linewidth',1.5);
hold(ax51,'on');
XX
XX

legend(ax51,'40 deg','0 deg','80 deg');

% label your plots! 

XX
XX
XX

% change the font size

set(ax51,'Fontsize',14);

% NUMBER DENSITY: just do N2, O, and He for data1, data3, and data4

semilogx(ax52,data1.density.N2,data1.altkm,'linewidth',1.5);
hold(ax52,'on');
XX
XX
XX
XX
XX
XX
XX

legend(ax52,'N2 40 deg','N2 0 deg','N2 80 deg','O 40 deg','O 0 deg','O 80 deg',...
    'He 40 deg','He 0 deg','He 80 deg');

% label your plots! 

XX
XX
XX

set(ax52,'xlim',[1e0 1e20]);

% change the font size

set(ax52,'Fontsize',14);

% TEMPERATURE: for data1, data3, and data4

plot(ax53,data1.tempK,data1.altkm,'linewidth',1.5);
hold(ax53,'on');
XX
XX

legend(ax53,'40 deg','0 deg','80 deg');

% label your plots! 

XX
XX
XX

% change the font size

set(ax53,'Fontsize',14);


%% summer / winter comparison: data1 and data5

h6 = figure(6);
set(h6,'position',[800 600 1400 500]);      % wider!
ax61 = subplot(1,3,1);          % creates the first in a 1 x 3 array of panels 
ax62 = subplot(1,3,2);
ax63 = subplot(1,3,3);

% MASS DENSITY: for data1 and data5

semilogx(ax61,data1.density.mass,data1.altkm,'linewidth',1.5);
hold(ax61,'on');
XX

legend(ax61,'January 2020','July 2022');

% label your plots! 

XX
XX
XX

% change the font size

set(ax61,'Fontsize',14);

% NUMBER DENSITY: just do N2, O, and He

semilogx(ax62,data1.density.N2,data1.altkm,'linewidth',1.5);
hold(ax62,'on');
XX
XX
XX
XX
XX

legend(ax62,'N2 Winter','N2 Summer','O Winter','O Summer',...
    'He Winter','He Summer');

% label your plots! 

XX
XX
XX

set(ax62,'xlim',[1e0 1e20]);

% change the font size

set(ax62,'Fontsize',14);

% TEMPERATURE: plot for data1 and data5

plot(ax63,data1.tempK,data1.altkm,'linewidth',1.5);
hold(ax63,'on');
XX

legend(ax63,'January 2020','July 2022');

% label your plots! 

XX
XX
XX

% change the font size

set(ax63,'Fontsize',14);

%% END
