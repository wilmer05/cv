
clear all;
close all;

addpath('../lib/');

im1 = '../data_set/graf/img1.ppm';
im2 = '../data_set/graf/img4.ppm';

%the groud truth homography

%FOR GRAF14
TrueH = [   6.6378505e-01   6.8003334e-01  -3.1230335e+01; 
            -1.4495500e-01   9.7128304e-01   1.4877420e+02;
            4.2518504e-04  -1.3930359e-05   1.0000000e+00];

 %FOR GRAF16
 %TrueH = [   4.2714590e-01  -6.7181765e-01   4.5361534e+02;
 %          4.4106579e-01   1.0133230e+00  -4.6534569e+01;
 %           5.1887712e-04  -7.8853731e-05   1.0000000e+00];
 
%first apply sift on both images and do the matching
[desc1 loca1 desc2 loca2 matchings mnb] = match(im1, im2);

%now from the returned matchings and locations extract points such that 
%left and right are 2XN matrices such that point left(:,x) matches point
%right(:,x) 
[left right] = get_matching_pts(loca1, loca2, matchings);

%Having these lists, compute the homography between the two points using a
%basic ransac algorithm
[H, inliers] = ransacfithomography(left, right, 0.001);

%make sure the homography is divided by its last element
%H = H/H(3,3);

%apply the homography to im1 and store the result in new_im
left_image = imread(im1);
right_image = imread(im2);
[newim, newT] = imTrans(left_image, H);

[TrueIm, TruenewT] = imTrans(left_image, TrueH);
%show images before and after applying the homography
figure
hold on
subplot(2,2,1);
imshow(left_image);
title('Left image')
subplot(2,2,2);
imshow(right_image);
title('Right image')
subplot(2,2,3);
imshow(newim);
title('Result obtained with SIFT computed Homography')
subplot(2,2,4);
imshow(TrueIm);
title('Result obtained with Ground truth Homography')

