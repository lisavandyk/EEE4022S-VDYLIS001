%Start fresh
close all;

%Define variables
r_max = 0;
sum_pixel_values = 0;
number = 0;

%Fluoresent images
If = imread('2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1_t021_c002_cropped.jpg');
If_gray = rgb2gray(If);

%Size of matrix
[numRows, numCols] = size(If_gray);

J = fluorescent_threshold(If_gray, numRows, numCols);

%Plot the image and it's corresponding mask
figure;
subplot(2,1,1);
imshow(If_gray);
title('Grey-scale image of fluoresent microscopy');

subplot(2,1,2);
imshow(J);
title('Image bit mask of fluorescent image');

%Read in original image and get information

I = imread('2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1_t021_c001.jpg');

%Transform to grey-scale
I_gray = rgb2gray(I);

%Increase the contrast of the grey-scale image
I_contrast = imadjust(I_gray,stretchlim(I_gray),[]);

%Get the compliment of the grey-scale image
I_flipped = imcomplement(I_contrast);

%Get histogram of image
%[I_counts, I_binLocations] = imhist(I_gray);

%Calculate the average pixel intensity of the known bacteria in the image
%to caclulate threshold value to find the rest of the bacteria in the image
for i = 1:numRows
   for j = 1:numCols
      if J(i,j) == true
          sum_pixel_values = sum_pixel_values + I_flipped(i,j);
          number = number + 1;
      end
   end
end

%T = sum_pixel_values/number;
T = 200;
%Create binary mask for grey-scale image
binary_mask = false([numRows, numCols]);

for i = 1:numRows
   for j = 1:numCols
      if I_flipped(i,j) > T
          binary_mask(i,j) = true;
      end
   end
end

%Plot images
figure;
subplot(2,2,1);
imshow(I_gray);
title('Original Grey-scale image of colony')

subplot(2,2,2);
imhist(I_gray);
title('Histogram of grey-scale image with 256 bins');

subplot(2,2,3);
imshow(I_contrast);
title('Grey-scale image of colony with contrast enhancement using histogram stretching');

subplot(2,2,4);
imhist(I_contrast);
title('Histogram of increased contrast of grey-scale image');

figure;
subplot(1,2,1);
imshow(I_flipped);
title('Compliment of increased contrast of Grey-scale image');

subplot(1,2,2);
imshow(binary_mask);
title('Resulting binary mask from compliment of grey-scale image');

