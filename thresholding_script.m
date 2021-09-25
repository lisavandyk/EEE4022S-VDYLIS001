%Start fresh
close all;
clear all;

%Define variables
%L = 256;
%r_min = 0;
r_max = 0;

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

%Map 
%}

J = imadjust(I_gray,stretchlim(I_gray),[]);
figure;
imshow(J);
title('Grey-scale image with stretched histogram');

figure;
imhist(J);
title('Stretched histogram')

%}

%Fluoresent images

If = imread('2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1.czi - 2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1_t021_c002_cropped.jpg');

If_gray = rgb2gray(If);
[counts, binLocations] = imhist(If_gray);

%Size of matrix
[numRows, numCols] = size(If_gray);

figure;
imshow(If_gray);
title('Grey-scale image of fluoresent microscopy');

figure;
imhist(If_gray);
title('Histogram of fluoresence image');

%Create empty temp image
temp_image = false([numRows, numCols]);

for i = length(binLocations):-1:1
   if counts(i) > 0
       r_max = i + 1;
       break
   end
end

%T = r_max - 50;
T = 20;

for i = 1:numCols
   for j = 1:numCols
      if If_gray(i,j) > T
          temp_image(i,j) = true;
      end
   end
end

%J = temp_image;

%J = fluorescent_threshold(If_gray, numRows, numCols);

%J = imadjust(If_gray,stretchlim(If_gray),[]);


figure;
imshow(temp_image);
title('Image bit mask');

%figure;
%imhist(J);
%title('');

%Find first location of histogram
%{
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
%{
figure;
subplot(2,2,1);
imshow(I_gray);
title('Grey scale image')

subplot(2,2,2);
imhist(I_gray);
title('Grey histogram of OG image');

subplot(2,2,3);
imshow(If_gray);
title('Grey-scale image of fluoresent image');

subplot(2,2,4);
imhist(If_gray);
title('Histogram of fluorescent image');
%}

%{
figure;
subplot(2,2,1);
imshow(I_gray);
title('Original Gray-scale Image');

subplot(2,2,2);
imhist(I,256);
%axis tight;
title('Histogram of Original image');

subplot(2,2,3);
J = imcomplement(I_gray);
imshow(J);
title('Compliment of gray scale image');

subplot(2,2,4);
imhist(J,256);
title('Histogram of compliment Image J');
%}