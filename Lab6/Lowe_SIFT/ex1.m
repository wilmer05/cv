function [] = ex1(K)
    dataFolder  = '../data/';
    imageFiles  = dir(strcat(dataFolder, '*.p*'));
    nimages     = length(imageFiles);
    ndesc       = 1;

    
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
    
    [ idx, C, sumd, D]          = kmeans(G, K);
    
    imagesCent          = zeros(nimages, K);
    centroidWordsCnt    = zeros(K,nimages);
   
    for i=1: size(G,1)
        
%        imagesWordsCnt(labels(i))           = imagesWordsCnt(labels(i))     + 1;
        imagesCent(labels(i), idx(i))       = imagesCent(labels(i), idx(i)) + 1;
        A = find(D(i,:) == 0.0, 1);
        if size(A,2) > 0
            centroidWordsCnt(A, label(i)) = 1;
        end
        
    end
    
    disp('Computing Vs');
    Vs = computeVs(nimages, K, imagesCent, centroidWordsCnt, D);
end

function Vs = computeVs(nimages, K, imagesCent, centroidWordscnt, D)
    Vs = zeros(nimages, K);
    for i=1 : nimages
        mn      = sum(imagesCent(i, :));
        for j=1:K
            mjn     = imagesCent(i, j);
            N       = nimages;
            Nj      = max(sum(centroidWordscnt(j,:)),1);
            Vs(i,j) = ( mjn / mn ) * log( N / Nj );
        end
    end
end