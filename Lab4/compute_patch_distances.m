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
    for i=1:size(patch_list,1)
        
    end
end

