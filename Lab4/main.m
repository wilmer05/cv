files = { 'blobs', 'cells', 'bricks', 'D1' ,'D3'};
patches = [15];
tolerances = [0.05, 0.2];
last = size(files, 2);
for i=1:last
   
    % Input
    file = string(files(i));
    file_name = 'data/' + file + '.png';
    sample = imread(char(file_name));
    texture_size = [128 128];
    for j=1: size(patches, 2)
        for k =1:size(tolerances, 2)
            close all;
            fig = figure;
            patch_size = patches(j); % should be odd (3, 5, 7, etc.)
            tolerance = tolerances(k);

            [texture, copy_map] = synthesize_texture(sample, texture_size, patch_size, tolerance);
            
            % Result
            h1 = subplot(2, 2, 1);
            imshow(sample);
            title('Sample')
            h2 = subplot(2, 2, 2);
            imshow(texture);
            title('Texture')
            h3 = subplot(2, 2, 3);
            imshow(build_color_map([size(sample,1), size(sample,2)]));
            title('Color map')
            h4 = subplot(2, 2, 4);
            imshow(copy_map);
            title('Copy map')
            if size(sample,1) < size(texture,1)
                size_y = get(h2, 'YLim');
            else
                size_y = get(h1, 'YLim');
            end
            if size(sample,2) < size(texture,2)
                size_x = get(h2, 'XLim');
            else
                size_x = get(h1, 'XLim');
            end
            set(h1, 'XLim', size_x, 'YLim', size_y);
            set(h2, 'XLim', size_x, 'YLim', size_y);
            set(h3, 'XLim', size_x, 'YLim', size_y);
            set(h4, 'XLim', size_x, 'YLim', size_y);
            saveas(fig, char('results/' + file + '-' + string(patch_size) + '-' + string(tolerance) + '.png'));
        end
    end
end