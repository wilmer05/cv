function [] = ex1
    dataFolder  = '../data/';
    imageFiles  = dir(strcat(dataFolder, '*.p*'));
    nimages     = length(imageFiles);
    ndesc       = 1;
    
    %number of words
    K = 10;
    
    G       = zeros(nimages, 128);
    L       = zeros(nimages, 4);
    labels  = zeros(nimages, 1);
    for i=1:nimages

        fname                                               = strcat(dataFolder, imageFiles(i).name);
        [image, descriptors, locs]                          = sift(fname);
        G( ndesc: ndesc + size(descriptors, 1) - 1, :)      = descriptors;
        L( ndesc: ndesc + size(descriptors, 1) - 1, :)      = locs;
        labels(ndesc: ndesc + size(descriptors, 1) - 1, :)  = i * ones(size(descriptors, 1), 1);
        ndesc                                               = ndesc + size(descriptors, 1);

    end
    
    [ idx, C ]          = kmeans(G, K);
    
    imagesCent          = zeros(nimages, K);
    imagesWordsCnt      = zeros(nimages,1);
    centroidWordsCnt    = zeros(K,nimages);
   
    for i=1: size(G,1)
        
        imagesWordsCnt(labels(i))           = imagesWordsCnt(labels(i))     + 1;
        imagesCent(labels(i), idx(i))       = imagesCent(labels(i), idx(i)) + 1;
        centroidWordsCnt(idx(i), labels(i)) = 1;
        
    end
    
    disp('Computing Vs');
    Vs = computeVs(nimages, K, imagesWordsCnt, imagesCent, centroidWordsCnt);
    disp('.');
end

function Vs = computeVs(nimages, K, imagesWordsCnt, imagesCent, centroidWordscnt)
    Vs = zeros(nimages, K);
    for i=1 : nimages
        for j=i:K
            mjn     = imagesCent(i, j);
            mn      = imagesWordsCnt(i);
            N       = nimages;
            Nj      = sum(centroidWordscnt(j,:));
            Vs(i,j) = (mjn / mn) * log(N/Nj);
        end
    end
end