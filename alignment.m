%% This script calculates the correlation of pixels across the time-lapse microscopy and outputs the time series aligned with respect to one another
%   
%   Based of the ViCAR, an automatic registration algorithm 
%
%   Lisa van Dyk
%   University of Cape Town
%   Electrical Engineering Department
%   02 October 2021

%%
close all;

I = imread('2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1.czi - 2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1_t001_c001.jpg');
%Convert image into grey-scale image
I_gray = rgb2gray(I);
%Increase contrast of image for a clearer distinction of edges
I_contrast = imadjust(I_gray,stretchlim(I_gray),[]);

%calculate threshold image of edges only
[numRows, numCols] = size(I_gray);

mask = false(numRows, numCols);
%set threshold value before histogram exponential curve in pixel intenisty
T = 80;

for i = 1:numRows
   for j = 1:numCols
      if I(i,j) < T
          mask(i,j) = true;
      end
   end
end

%Morphological dilation of image using 3x3 SE kernel

dilate = false(numRows, numCols);
%No real valuable information will be missed from one pixel border of image
%- edge will be dilated anyway
for i = 2:(numRows-1)
   for j = 2:(numCols-1)
       if mask(i,j) == true
             dilate(i,j) = true;
             dilate(i+1,j) = true;
             dilate(i,j+1) = true;
             dilate(i+1,j+1) = true;
             %3x3
             dilate(i-1,j-1) = true;
             dilate(i-1,j) = true;
             dilate(i-1,j+1) = true;
             dilate(i,j-1) = true;
             dilate(i+1,j-1) = true;
       end
   end
end

%Figure showing change in contrast of image
figure;
subplot(1,2,1);
imshow(I_gray);
title("Phase contrast image in Grey");

subplot(1,2,2);
imshow(I_contrast);
title("Increased contrast of image");

%Figure showing resulting mask for T = 80
figure;
subplot(1,2,1);
imhist(I_contrast);

subplot(1,2,2);
imshow(mask);
title(['Resulting binary mask for T = ', num2str(T)]);

%Figure showing dilation of 2x2 kernel
figure;
imshow(dilate);
title('Dilated binary mask using 2x2 Kernel');
