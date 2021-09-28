%Start fresh
close all;

%Define variables
r_max = 0;

%Fluoresent images
If = imread('2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1.czi - 2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1_t021_c002_cropped.jpg');

If_gray = rgb2gray(If);
%[counts, binLocations] = imhist(If_gray);

%Size of matrix
[numRows, numCols] = size(If_gray);

J = fluorescent_threshold(If_gray, numRows, numCols);

%Plot the image and it's corresponding mask
figure;
subplot(2,2,1);
imshow(If_gray);
title('Grey-scale image of fluoresent microscopy');

subplot(2,2,2);
imshow(J);
title('Image bit mask of fluorescent image');

figure;
imhist(If_gray);
title('Histogram of fluoresence image');

%Read in original image and get information
%{
I = imread('2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1.czi - 2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1_t001_c001.jpg');

%Transform to grey-scale
I_gray = rgb2gray(I);
info = imfinfo('2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1.czi - 2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1_t001_c001.jpg');

%Get histogram of image
%[I_counts, I_binLocations] = imhist(I_gray);

%Plot images
figure;
imshow(I_gray);
title('Grey-scale image of colony')

figure;
imhist(I_gray);
title('Histogram of grey-scale image with 256 bins');

%{
%To increase the contrast in the image to make the automatic threshold
%easier - stretch histogram?
%Find first location of histogram
for i = 1:length(binLocations)
   if counts(i) > 0
       r_min = i-1;
       break
   end
end

%Find last location of histogram
for i = length(binLocations):-1:1
   if counts(i) > 1
       r_max = i + 1;
       break
   end
end
 
%}

J = imadjust(I_gray,stretchlim(I_gray),[]);
figure;
imshow(J);
title('Grey-scale image with stretched histogram');

figure;
imhist(J);
title('Stretched histogram')

%}
