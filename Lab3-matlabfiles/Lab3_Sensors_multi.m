% -----------------------------------------------------
%
% ASEN 2501: Introduction to Astronautics
% Module 4: Space Environment and Communications
%
% Lab 3: Spacecraft (or phone) sensor data
%
% -----------------------------------------------------

clear; close all; clc

s = settings;
s.matlab.appearance.figure.GraphicsTheme.TemporaryValue = "light";

plotsDir = fullfile(pwd,'plots');
if ~exist(plotsDir,'dir')
    mkdir(plotsDir);
end

%% Accelerometer

data1 = readtable('multi.csv');

% This reads the data into a matlab "table", which is pretty convenient for
% plotting and analysis, as you'll see below. You can reference the columns
% just as you would in a structure. 

% Now let's make a figure with four stacked panels.

h1 = figure(1);
%set(h1,'position',[800 300 1000 1000]);
ax11 = subplot(4,1,1);
ax12 = subplot(4,1,2);
ax13 = subplot(4,1,3);
ax14 = subplot(4,1,4);


% for the multi collection, the "time" entry is a bit weird; it is stored
% as a datenumber. This requires some steps to translate to a simple time
% vector.

% Convert to datetime, specifying the input format and timezone
t = datetime(data1.time, 'InputFormat', 'yyyy-MM-dd''T''HH:mm:ss.SSS''Z''', 'TimeZone', 'UTC');

% Convert to datenum
dn = datenum(t);

% for plotting, let's plot the time (in seconds) since the first sample.
% Note that datenumber is in days, so multiply by 24 hours/day and 3600
% sec/hour:
time2 = (dn - dn(1)) * 3600*24;


%% Acceleration

% plot three axes of acceleration in first panel
plot(ax11,time2,data1.ax,'r');
hold(ax11,'on');
plot(ax11,time2,data1.ay,'g');
plot(ax11,time2,data1.az,'b');

% calculate the vector norm and plot it
data1.atotal = sqrt(data1.ax.^2 + data1.ay.^2 + data1.az.^2);          % complete this!

plot(ax11,time2,data1.atotal,'k','linewidth',1.5);

legend(ax11,'a_x','a_y','a_z','a_{tot}');

% label your axes! xlabel(ax1,...) etc
xlabel(ax11,'Time (s)');
ylabel(ax11,'Acceleration (m/s^2)');
title(ax11,'Accelerometer Data');


%% Gyroscope

% plot three axes of gyro data in second panel
plot(ax12,time2,data1.wx,'r');
hold(ax12,'on');
plot(ax12,time2,data1.wy,'g');
plot(ax12,time2,data1.wz,'b');


legend(ax12,'w_x','w_y','w_z');

% label your axes!
xlabel(ax12,'Time (s)');
ylabel(ax12,'Angular Velocity (rad/s)');
title(ax12,'Gyroscope Data');



%% Magnetic Field

% plot three axes of mag data in third panel
plot(ax13,time2,data1.Bx__T_,'r');
hold(ax13,'on');
plot(ax13,time2,data1.By__T_,'g');
plot(ax13,time2,data1.Bz__T_,'b');


% calculate the vector norm and plot it
data1.Btotal = sqrt(data1.Bx__T_.^2 + data1.By__T_.^2 + data1.Bz__T_.^2);          % complete this!

plot(ax13,time2,data1.Btotal,'k','linewidth',1.5);

legend(ax13,'B_x','B_y','B_z','B_{tot}');

% label your axes!
xlabel(ax13,'Time (s)');
ylabel(ax13,'Magnetic Field (uT)');
title(ax13,'Magnetometer Data');


%% Even though it's not very interesting, let's plot speed

plot(ax14,time2,data1.speed,'k');

% label your axes!
xlabel(ax14,'Time (s)');
ylabel(ax14,'Speed (m/s)');
title(ax14,'Speed Data');

saveas(h1, fullfile(plotsDir,'M4L3_MultiFig1.png'));


%% check out this handy tool:

linkaxes([ax11 ax12 ax13 ax14],'x');

% zoom and pan around on one of the axes and see what happens to the
% others...