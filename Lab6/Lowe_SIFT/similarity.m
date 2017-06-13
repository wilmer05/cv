function simil = similarity(img, numberOfClusters)

    imwrite(img, 'tmp.ppm');

    [image, descriptors, locs] = sift('tmp.ppm');
    
    [databaseVs, C, cnt] = ex1(numberOfClusters);
    
    clusters = zeros(size(descriptors, 1), 1);
    for i=1:size(descriptors, 1)
        desc = descriptors(i, :);
        mindist = inf;
        for j = 1 : size(C,1)
            d = norm(C(j,:) - desc);
            
            if d < mindist
                mindist = d;
                clusters(i) = j;
            end
        end
    end
    
    vq = zeros(numberOfClusters, 1);
    nd = size(descriptors , 1);
    N = numberOfClusters;
    
    for i = 1 : numberOfClusters
        nid = sum(clusters == i);
        Nj = sum(cnt(i, :));
        vq(i) = ( nid / nd ) * log( N / Nj );
    end
    
    simil = zeros(size(numberOfClusters,1));
    
    for i = 1 : size(databaseVs, 1)
        vd = databaseVs(i, :);
        
        simil(i) = dot(vd, vq) / (norm(vq) * norm(vd));
    end
    
end