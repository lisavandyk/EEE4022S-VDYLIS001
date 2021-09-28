I = imread('2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1.czi - 2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1_t021_c001.jpg');

figure;
imshow(I);
title('Original image');

I2 = imcrop(I,[1 1 1462 1462]);

figure;
imshow(I2);
title('Cropped Image');

imwrite(I2,'2021-05-22_Experiment-01_NRG_Msm-GFP_Exp1_t021_c001.jpg');