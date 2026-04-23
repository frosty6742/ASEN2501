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

data1 = readtable('acceleration.csv');

% This reads the data into a matlab "table", which is pretty convenient for
% plotting and analysis, as you'll see below. You can reference the columns
% just as you would in a structure. 

h1 = figure(1);
%set(h1,'position',[800 600 1000 500]);
% above sets the figure position on your screen, in units of pixels. If it
% goes off the page, adjust these values. 

ax11 = subplot(1,2,1);
ax12 = subplot(1,2,2);

% plot acceleration for all three axes

plot(ax11,data1.time,data1.ax,'r');
hold(ax11,'on');
plot(ax11,data1.time,data1.ay,'g');
plot(ax11,data1.time,data1.az,'b');

legend(ax11,'a_x','a_y','a_z');

% label your plots, and include units!
xlabel(ax11,'Time (s)');
ylabel(ax11,'Acceleration (m/s^2)');
title(ax11,'Accelerometer Data');


% get the average and standard deviation of each of the three components,
% but just for the time when it was sitting still:
avgx = mean(data1.ax(950:end));
avgy = mean(data1.ay(950:end));
avgz = mean(data1.az(950:end));

stdx = std(data1.ax(950:end));
stdy = std(data1.ay(950:end));
stdz = std(data1.az(950:end));


% print out the answers to the command window
disp(sprintf('Averages: %.2f, %2.f, %.2f m/s^2\n',avgx,avgy,avgz));
disp(sprintf('Standard deviations: %.2f, %2.f, %.2f m/s^2\n',stdx,stdy,stdz));


% confirm that a_total is the vector norm of the three components:
a_vecnorm = sqrt(data1.ax.^2 + data1.ay.^2 + data1.az.^2);

plot(ax12,data1.time,data1.atotal,'r', 'LineWidth', 0.75);
hold(ax12,'on');
plot(ax12,data1.time,a_vecnorm,'b');



legend(ax12,'a total from device','a vecnorm');

% label your plots!
xlabel(ax12,'Time (s)');
ylabel(ax12,'Acceleration (m/s^2)');
title(ax12,'Total Acceleration vs Vector Norm');

% figure out the maximum difference
maxdiff = max(abs(data1.atotal - a_vecnorm));    % complete this!

disp(sprintf('Maximum difference between a-total and vecnorm = %.3f m/s^2\n',maxdiff));
saveas(h1, fullfile(plotsDir,'M4L3_Fig1_accelerometer.png'));


%% Gyroscope

data2 = readtable('gyroscope.csv');


h2 = figure(2);
%set(h2,'position',[800 600 700 500]);
ax21 = subplot(1,1,1);

% plot the gyroscope data

plot(ax21,data2.time,data2.wx,'r');
hold(ax21,'on');
plot(ax21,data2.time,data2.wy,'g');
plot(ax21,data2.time,data2.wz,'b');

legend(ax21,'a_x','a_y','a_z');

% label your plots
xlabel(ax21,'Time (s)');
ylabel(ax21,'Angular Velocity (rad/s)');
title(ax21,'Gyroscope Data');


% find maximum rotation rate on the table. For me it was around the z-axis
[maxspin,ind] = max(data2.wz);

% find the time it took to stop. Can do this manually, looking at the plot,
% or come up with a more sophisticated way!

starttime = data2.time(ind);
stoptime = data2.time(find(data2.wz < 0.01, 1, 'first'));

spintime = stoptime - starttime;

% display some answers
disp(sprintf('Maximum spin rate = %.3f rad/s\n',maxspin));
disp(sprintf('Time to stop spinning = %.3f sec\n',spintime));

saveas(h2, fullfile(plotsDir,'M4L3_Fig2_gyroscope.png'));


%% Magnetometer

data3 = readtable('magnetometer.csv');


h3 = figure(3);
%set(h3,'position',[800 600 1000 500]);
ax31 = subplot(1,2,1);
ax32 = subplot(1,2,2);

% plot three components of magnetometer data
plot(ax31,data3.time,data3.Bx,'r');
hold(ax31,'on');
plot(ax31,data3.time,data3.By,'g');
plot(ax31,data3.time,data3.Bz,'b');



legend(ax31,'B_x','B_y','B_z');

% label your plots
xlabel(ax31,'Time (s)');
ylabel(ax31,'Magnetic Field (uT)');
title(ax31,'Magnetometer Data');

% confirm that a_total is the vector norm of the three components:
B_vecnorm = sqrt(data3.Bx.^2 + data3.By.^2 + data3.Bz.^2);          % complete this!

% plot Btotal and B-vecnorm to compare
plot(ax32,data3.time,data3.Btotal,'r', 'LineWidth', 0.75);
hold(ax32,'on');
plot(ax32,data3.time,B_vecnorm,'b');

legend(ax32,'B total from device','B vecnorm');

% label your plots
xlabel(ax32,'Time (s)');
ylabel(ax32,'Magnetic Field Vector Norm(uT)');
title(ax32,'Magnetometer Data Vector Norm');

% figure out the maximum difference

maxdiff = max(abs(data3.Btotal - B_vecnorm));    % complete this! 

disp(sprintf('Maximum difference between B-total and vecnorm = %.3f uT\n',maxdiff));
saveas(h3, fullfile(plotsDir,'M4L3_Fig3_magnetometer.png'));


% get the average and standard deviation of each of the three components,
% and for the magnitude,
% but just for the time when it was sitting still:

avgx = mean(data3.Bx(1:90));           % YOU WILL LIKELY NEED TO CHANGE THESE INDICES
avgy = mean(data3.By(1:90));
avgz = mean(data3.Bz(1:90));
avgB = mean(data3.Btotal(1:90));

stdx = 1000 * std(data3.Bx(1:90));
stdy = 1000 * std(data3.By(1:90));
stdz = 1000 * std(data3.Bz(1:90));
stdB = 1000 * std(data3.Btotal(1:90));

disp(sprintf('Averages: %.2f, %2.f, %.2f, %.2f uT\n',avgx,avgy,avgz,avgB));
disp(sprintf('Standard deviations: %.2f, %2.f, %.2f, %.2f uT\n',stdx,stdy,stdz,stdB));