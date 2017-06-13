function [Vs, C, centroidWordsCnt] = ex1(K)
    max = 2;
    dataFolder  = '../data/';
    imageFiles  = dir(strcat(dataFolder, '*.p*'));
    nimages     = length(imageFiles);
    ndesc       = 1;

    
    G       = zeros(nimages, 128);
    L       = zeros(nimages, 4);
    labels  = zeros(nimages, 1);
    for i=1:nimages
        fname = strcat(dataFolder, imageFiles(i).name);
        [image, descriptors, locs] = sift(fname);
        G( ndesc: ndesc + size(descriptors, 1) - 1, :) = descriptors;
        labels(ndesc: ndesc + size(descriptors, 1) - 1, :) = i * ones(size(descriptors, 1), 1);
        ndesc = ndesc + size(descriptors, 1);
    end
    
    [ idx, C ]          = kmeans(G, K);
    
    imagesCent          = zeros(nimages, K);
    centroidWordsCnt    = zeros(K,nimages);
   
    for i=1: size(G,1)
        
        imagesCent(labels(i), idx(i))       = imagesCent(labels(i), idx(i)) + 1;
        centroidWordsCnt(idx(i), labels(i)) = 1;
        
    end
    
    disp('Computing Vs');
    Vs = computeVs(nimages, K, imagesCent, centroidWordsCnt);
    printMaxClusters(Vs, max, imageFiles);
    disp('.');
end

function Vs = computeVs(nimages, K, imagesCent, centroidWordscnt)
    Vs = zeros(nimages, K);
    for i=1 : nimages
        for j=1:K
            mjn     = imagesCent(i, j);
            mn      = sum(imagesCent(i, :));
            N       = nimages;
            Nj      = sum(centroidWordscnt(j,:));
            Vs(i,j) = (mjn / mn) * log(N/Nj);
        end
    end
end

function printMaxClusters(Vs, max, imageFiles)
    clusters = zeros(size(Vs,1)*max, 1);
    for i=1:size(Vs,1)
        [sorted, sortedIdx] = sort(Vs(i,:),'descend');
        startIdx = (i-1)*max+1;
        endIdx = i*max;
        clusters(startIdx:endIdx,1) = sortedIdx(1:max)';
    end
    
    totalCluster = size(clusters,1);
    totalImg = size(Vs,1);
    count=1;
    for k=1:totalCluster
        images = find(Vs(:,clusters(k))>0);
        count = totalImg*(k-1)+1;
        title(sprintf('Cluster %d', clusters(k)));
        for i=1:size(images)
            img = imread(fullfile( '../data/',imageFiles(images(i)).name));
            subplot(totalCluster,totalImg,count), subimage(img);
            count = count +1;
        end
    end
end