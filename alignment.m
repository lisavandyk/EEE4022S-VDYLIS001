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
T = 60;

for i = 1:numRows
   for j = 1:numCols
      if I(i,j) > T
          mask(i,j) = true;
      end
   end
end


figure;
subplot(1,2,1);
imhist(I_contrast);

subplot(1,2,2);
imshow(mask);
title(['Resulting binary mask for T = ', num2str(T)]);

figure;
subplot(1,2,1);
imshow(I_gray);
title("Phase contrast image in Grey");

subplot(1,2,2);
imshow(I_contrast);
title("Increased contrast of image");
%}