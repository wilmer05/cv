function distances = compute_patch_distances(patch_list, patch, mask, weights)
%compute_patch_distances Computes distances between the given patch and 
%                        all patches in the list of patches
%   IN:
%	patch_list - list of N patches in 4D structure:
%       (patch height, patch width, number of color channels, N)
%   patch - given patch
%   mask - binary mask to be applied in distance computation
%   weights - intra-patch weights
%   OUT:
%   distances - array of size N, containing all patch distances

    % TODO: implement
    patch = single(patch);
    distances = zeros(size(patch_list,4),1);
    for N=1:size(patch_list,4)
        for col=1 : size(patch_list, 3)     
            for y=1:size(patch,1)
                for x=1:size(patch,2)
    %                     patch2 = 
                    distances(N) = distances(N) + mask(y,x) * weights(y,x) * (patch(y,x)-patch_list(y,x,col,N))^2;
                end
            end
        end
        distances(N) = distances(N) / (size(patch,2) * size(patch,1)); 
    end
end

