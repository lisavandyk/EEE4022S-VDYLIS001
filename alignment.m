%% This script calculates the correlation of pixels across the time-lapse microscopy and outputs the time series aligned with respect to one another
%
%   Lisa van Dyk
%   University of Cape Town
%   Electrical Engineering Department
%   02 October 2021

%%

I = imread('2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1.czi - 2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1_t001_c001.jpg');

%I_gray = rgb2gray(I);
%imshow(I_gray);
%title('Original phase image');

%Set up variables

tol = 1;
i = 1;
j = 1;


figure;
J5 = imcrop(I, [80 200 1456 1304]);
imshow(J5);
title('Ideal cropped image');

[numRows, numCols] = size(J5);

corr_matrix = zeros(numRows-1, numCols-1);

for i = 1:(numRows-1)  
   for j = 1:(numCols-1)
      deltaAB = J5(i,j) - J5(i+1,j);
      deltaAC = J5(i,j) - J5(i,j+1);
      corr_matrix(i,j) = fmap(deltaAB,deltaAC, tol);
   end
end

%{
subplot(2,2,1);
J1 = imcrop(I,[1 1 1376 1104]);
imshow(J1);
title('Cropped image of first quarter');

subplot(2,2,2);
J2 = imcrop(I, [1377 1 2752 1104]);
imshow(J2);
title('Cropped image of section II');

subplot(2,2,3);
J3 = imcrop(I, [1 1105 1376 2208]);
imshow(J3);
title('Cropped image of section III');

subplot(2,2,4);
J4 = imcrop(I, [1377 1105 2752 2208]);
imshow(J4);
title('Cropped image of section IV');

%}

%{
[numRows, numCols] = size(I_gray);

temp_image = false([numRows, numCols]);

for i = 1:numRows
   for j = 1:numCols
      if I(i,j) < 70
          temp_image(i,j) = true;
      end
   end
end

figure;
imshow(temp_image);
%}
