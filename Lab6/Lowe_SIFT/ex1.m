dataFolder = '../data/';
imageFiles = dir(strcat(dataFolder, '*.p*'));
nimages = length(imageFiles);
ndesc = 1;
G = zeros(nimages, 128);
L = zeros(nimages, 4);
for i=1:nimages

    fname = strcat(dataFolder, imageFiles(i).name);
    [image, descriptors, locs] = sift(fname);
    G( ndesc: ndesc + size(descriptors, 1) - 1, :) = descriptors;
    L( ndesc: ndesc + size(descriptors, 1) - 1, :) = locs;
    ndesc = ndesc + size(descriptors, 1);
  
end

disp('nbl');