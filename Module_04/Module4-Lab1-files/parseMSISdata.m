function data = parseMSISdata(file)

% This is a quick function to read the MSIS data files and parse the
% results into a single structure for analysis. 

A = load(file);

year = A(:,1);
month = A(:,2);
day = A(:,3);
hour = A(:,5);

data.time = datetime(year(1),month(1),day(1),hour(1),0,0,0);       % handy single number for the date and time

% the "." notation above creates a data structure with different fields. 
% They don't have to all be the same size, or even the same data type!

data.altkm = A(:,6);
data.lat = A(:,7);
data.lon = A(:,8);

data.density.O = A(:,9);
data.density.N2 = A(:,10);
data.density.O2 = A(:,11);
data.density.mass = A(:,12);
data.tempK = A(:,13);
data.density.He = A(:,15);
data.density.Ar = A(:,16);
data.density.H = A(:,17);
data.density.N = A(:,18);

data.f107 = A(:,19);
data.apdaily = A(:,21);