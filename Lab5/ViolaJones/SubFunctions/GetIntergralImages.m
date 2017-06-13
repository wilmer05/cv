function IntegralImages = GetIntergralImages(Picture,Options)
% Make integral image from a Picture
%
%
% Convert the Picture to double 
% (grey-level scaling doesn't influence the result, thus 
% double instead of im2double can also be used)
Picture=im2double(Picture);

% Resize the image to decrease the processing-time
if(Options.Resize)
    if (size(Picture,2) > size(Picture,1)),
        Ratio = size(Picture,2) / 384;
    else
        Ratio = size(Picture,1) / 384;
    end
    Picture = imresize(Picture, [size(Picture,1) size(Picture,2) ]/ Ratio);
else
    Ratio=1;
end

% Convert the picture to greyscale (this line is the same as rgb2gray, see help)
if(size(Picture,3)>1),
    Picture=0.2989*Picture(:,:,1) + 0.5870*Picture(:,:,2)+ 0.1140*Picture(:,:,3);
end

%%%%%%%%% Assignment. MISSING CODE HERE %%%%%%%%%%%%%
% Make the integral image for fast region sum look up


%MISSING CODE HERE %
IntegralImages.ii= zeros(size(Picture));

for i=1 : size(Picture, 1)
    IntegralImages.ii(i) = Picture(i);
    if (i > 1)
        IntegralImages.ii(i) = IntegralImages.ii(i-1) + Picture(i);
    end
    acum = Picture(i);
    for j=2 : size(Picture, 2)
        acum = acum + Picture(i,j);
        IntegralImages.ii(i,j) =  acum;
        if(i > 1)
            IntegralImages.ii(i, j) = IntegralImages.ii(i, j) + IntegralImages.ii(i-1, j);
        end
    end
end

IntegralImages.ii=padarray(IntegralImages.ii,[1 1], 0, 'pre');

%%%%%%%%% Assignment. MISSING CODE HERE %%%%%%%%%%%%%
% Make integral image to calculate fast a local standard deviation of the
% pixel data


%IntegralImages.ii2=
IntegralImages.ii2= zeros(size(Picture));

for i=1 : size(Picture, 1)
    IntegralImages.ii2(i) = Picture(i)^2;
    if (i > 1)
        IntegralImages.ii2(i) = IntegralImages.ii2(i-1) + Picture(i)^2;
    end
    acum = Picture(i)^2;
    for j=2 : size(Picture, 2)
        acum = acum + Picture(i,j)^2;
        IntegralImages.ii2(i,j) =  acum;
        if(i > 1)
            IntegralImages.ii2(i, j) = IntegralImages.ii2(i, j) + IntegralImages.ii2(i-1, j);
        end
    end
end

IntegralImages.ii2=padarray(IntegralImages.ii2,[1 1], 0, 'pre');

% Store other data
IntegralImages.width = size(Picture,2);
IntegralImages.height = size(Picture,1);
IntegralImages.Ratio=Ratio;
