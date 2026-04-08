% -----------------------------------------------------
%
% ASEN 2501: Introduction to Astronautics
% Module 4: Space Environment and Communications
%
% Lab 1: The LEO Space Environment
%
% Part 2: Plotting IRI Profiles
%
% -----------------------------------------------------

clear; close all; clc

%% Load the first profiles from your downloaded IRI files

% This function parses the data in the file into the appropriate columns.
% Having a separate function makes it easy to repeat  on more files
% (as you'll see later)

data1 = parseIRIdata('IRIprofiles/IRI-01022020-1200-lat40.txt');



%% Q3.1: plot the ELECTRON density

h1 = figure(1);
ax1 = axes;

semilogx(ax1,data1.density.Ne,data1.altkm,'linewidth',2);

% label your plots!

XX
XX
XX

% change the font size

set(ax1,'Fontsize',14);                          % the default tiny font drives me crazy


%% Q3.2: plot the number densities of ion species

h2 = figure(2);
ax2 = axes;

% NOTE: IRI gives ion densities as percentage x 10. But ion densities add up 
% to the electron density. So, to get to number densities, divide by 10 and
% multiply by Ne. Then divide by 100 to get to fraction instead of percent.
% Let's make that a little more concise:

data1.nfac = data1.density.Ne / 1000;

% now plot the total density by multiplying by this factor. repeat on the
% same plot for O+, N+, H+, He+, O2+, NO+, and cluster ions

semilogx(ax2,data1.density.Op .* data1.nfac,data1.altkm,'linewidth',1.5);
hold(ax2,'on');
XX
XX
XX
XX
XX
XX

legend(ax2,'O+','N+','H+ (protons)','He+','O2+','NO+','Cluster ions')

% label your plots! 

XX
XX
XX

% change the font size

set(ax2,'Fontsize',14);

% you'll get a weird plot with 10^-38 values, so set the plot limits to the
% range we care about

set(ax2,'xlim',[1e0 1e6]);


%% Q3.3: plot the temperature profiles 

h3 = figure(3);
ax3 = axes;

% plot temperature profiles for neutrals, ions, and electrons

plot(ax3,data1.temp.neutral,data1.altkm,'linewidth',2);
hold(ax3,'on');
XX
XX

legend(ax3,'Neutrals','Ions','Electrons');

% label your plots! 

XX
XX
XX

% change the font size

set(ax3,'Fontsize',14);


%% Load the other data files

% data2: same date, but midnight 
data2 = parseIRIdata('IRIprofiles/IRI-01022020-0000-lat40.txt');

% data3: same date and time, 0 latitude
data3 = parseIRIdata('IRIprofiles/IRI-01022020-1200-lat00.txt');

% data4: same date and time, 80 latitude
data4 = parseIRIdata('IRIprofiles/IRI-01022020-1200-lat80.txt');

% data5: same time and lat, July 2022 
data5 = parseIRIdata('IRIprofiles/IRI-07052022-1200-lat40.txt');


%% day/night comparison: data1 and data2. Learn subplots!

h4 = figure(4);
set(h4,'position',[800 600 1400 500]);      % wider!
ax41 = subplot(1,3,1);          % creates the first in a 1 x 3 array of panels 
ax42 = subplot(1,3,2);
ax43 = subplot(1,3,3);

% ELECTRON DENSITY: for data1 and data2

semilogx(ax41,data1.density.Ne,data1.altkm,'linewidth',1.5);
hold(ax41,'on');
XX

legend(ax41,'Noon','Midnight');

% label your plots! 

XX
XX
XX

% change the font size

set(ax41,'Fontsize',14);

% ION DENSITY: just do O+, H+, and NO+ for both data1 and data2

% different conversion factor for each dataset!
data2.nfac = data2.density.Ne / 1000; 

semilogx(ax42,data1.density.Op .* data1.nfac,data1.altkm,'linewidth',1.5);
hold(ax42,'on');
XX
XX
XX
XX
XX

legend(ax42,'O+ Noon','H+ Noon','NO+ Noon','O+ Midnight','H+ Midnight','NO+ Midnight');

% label your plots! 

XX
XX
XX

set(ax42,'xlim',[1e0 1e6]);

% change the font size

set(ax42,'Fontsize',14);

% TEMPERATURES: again, do neutrals, ions, and electrons, for data1 and
% data2

plot(ax43,data1.temp.neutral,data1.altkm,'linewidth',1.5);
hold(ax43,'on');
XX
XX
XX
XX
XX

legend(ax43,'Neutrals Noon','Ions Noon','Electrons Noon','Neutrals Midnight',...
    'Ions Midnight','Electrons Midnight');

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

% ELECTRON DENSITY: for data1, data3, and data4

semilogx(ax51,data1.density.Ne,data1.altkm,'linewidth',1.5);
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

% ION DENSITY: just do N2, O, and He, for data1, data3, and data4

% different conversion factor for each dataset!
data3.nfac = data3.density.Ne / 1000; 
data4.nfac = data4.density.Ne / 1000; 

semilogx(ax52,data1.density.Op .* data1.nfac,data1.altkm,'linewidth',1.5);
hold(ax52,'on');
XX
XX
XX
XX
XX
XX
XX
XX

legend(ax52,'O+ 40 deg','H+ 40 deg','NO+ 40 deg','O+ 0 deg','H+ 0 deg','NO+ 0 deg',...
    'O+ 80 deg','H+ 80 deg','NO+ 80 deg');

% label your plots! 

XX
XX
XX

set(ax52,'xlim',[1e0 1e6]);

% change the font size

set(ax52,'Fontsize',14);

% TEMPERATURES: just do ions and electrons for these three data files

plot(ax53,data1.temp.ion,data1.altkm,'linewidth',1.5);
hold(ax53,'on');
XX
XX
XX
XX
XX

legend(ax53,'Ions 40 deg','Electrons 40 deg','Ions 0 deg','Electrons 0 deg',...
    'Ions 80 deg','Electrons 80 deg');

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

% ELECTRON DENSITY: for data1 and data5

semilogx(ax61,data1.density.Ne,data1.altkm,'linewidth',1.5);
hold(ax61,'on');
XX

legend(ax61,'January 2020','July 2022');

% label your plots! 

XX
XX
XX

% change the font size

set(ax61,'Fontsize',14);

% ION DENSITY: just do N2, O, and He for data1 and data5

% different conversion factor for each dataset!
data5.nfac = data5.density.Ne / 1000; 

semilogx(ax62,data1.density.Op .* data1.nfac,data1.altkm,'linewidth',1.5);
hold(ax62,'on');
XX
XX
XX
XX
XX

legend(ax62,'O+ Winter','H+ Winter','NO+ Winter','O+ Summer',...
    'H+ Summer','NO+ Summer');

% label your plots! 

XX
XX
XX

set(ax62,'xlim',[1e0 1e6]);

% change the font size

set(ax62,'Fontsize',14);

% TEMPERATURES: ions and electrons for these two data files

plot(ax63,data1.temp.ion,data1.altkm,'linewidth',1.5);
hold(ax63,'on');
XX
XX
XX

legend(ax63,'January 2020 Ions','January 2020 Electrons','July 2022 Ions','July 2022 Electrons');

% label your plots! 

XX
XX
XX

% change the font size

set(ax63,'Fontsize',14);


%% END
