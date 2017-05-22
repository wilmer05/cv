function [patch_list, coordinates] = extract_patches(image, patch_size)
%extract_patches Extracts a list of patches from a given image
%   IN:
%   image - image to extract patches from
%   patch_size - size of the patch [height width]
%   OUT:
%   patch_list - list of N patches in 4D structure:
%       (patch height, patch width, number of color channels, N)
%   coordinates - (N-by-2) matrix with coordinates of patch centers.
%
%   NOTE: patches in patch_list and in coordinates should be in the same
%         order

    % TODO: implement
    max_x = size(image,2) - patch_size(2) + 1;
    max_y = size(image,1) - patch_size(1) + 1;
    patch_list = zeros(patch_size(2), patch_size(1), size(image,3), max_x*max_y);
    coordinates = zeros(max_x*max_y, 2);
    idx = 1;
    if mod(patch_size(1),2) == 1 && mod(patch_size(2),2) == 1
        for x_start=1:max_x
            for y_start=1:max_y
                x_coordinate = x_start + floor(patch_size(2)/2);
                y_coordinate = y_start + floor(patch_size(1)/2);
                colours = size(image, 3);
                %patch_list(idx,:) = [patch_size(1), patch_size(2), colours, idx];
                coordinates(idx,:) = [y_coordinate, x_coordinate];
                %imagePatch = image;
                cnt = 1;
                for col=1 : colours
                    for i=x_start:x_start+patch_size(2)-1
                        cnt2 = 1;
                        for j =y_start:y_start+patch_size(1)-1
                            patch_list(cnt2, cnt, col, idx) = image(j,i,col);
                            cnt2 = cnt2 + 1;
                        end
                        cnt =  cnt + 1;
                    end
                end
                idx = idx + 1;
            end
        end
    else
        disp('Size has to be odd');
    end

end

