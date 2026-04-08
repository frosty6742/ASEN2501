function data = parseIRIdata(file)


% This is a quick function to read the IRI data files and parse the
% results into a single structure for analysis. 

A = load(file);

% the "." notation creates a data structure with different fields. 
% They don't have to all be the same size, or even the same data type!

data.altkm = A(:,1);

data.density.Ne = A(:,2);
data.nmf2 = A(:,3);
data.temp.neutral = A(:,4);
data.temp.ion = A(:,5);
data.temp.el = A(:,6);
data.density.Op = A(:,7);
data.density.Np = A(:,8);
data.density.Hp = A(:,9);
data.density.Hep = A(:,10);
data.density.O2p = A(:,11);
data.density.NOp = A(:,12);
data.density.Cluster = A(:,13);