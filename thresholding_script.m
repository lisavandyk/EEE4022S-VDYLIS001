I = imread('2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1.czi - 2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1_t001_c001.jpg');
%I_gray = ind2gray(I,map);
%imageinfo;

I_gray = rgb2gray(I);
figure;
%subplot(2,2,1);
imshow(I_gray);
title('Image');

figure;
%subplot(2,2,2);
imhist(I,256);
axis tight;
title('Histogram');