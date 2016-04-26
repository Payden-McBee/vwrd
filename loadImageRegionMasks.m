function masks = loadImageRegionMasks(directory)
filename = 'Gaborone_20111011083426_MS.tifmask';
mask1 = csvread(filename);
%file2 = 'Gumare_20111105084356_MS.tifmask';
%mask2 = csvread(file2);

masks{1} = mask1;
%masks{2} = mask2;
