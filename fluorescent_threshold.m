function [J] = fluorescent_threshold(I, numRows, numCols)
%Fluorescent_threshold - This function is designed to take in the
%fluoresecnt image of the time-lapse microscopy and output an image mask of
%the live bacteria
%   Detailed explanation goes here


%Create output image matrix
temp_image = zeros([numRows, numCols]);

%Find histogram limits of image

[counts_if, binLocations_if] = imhist(I);

%Find last location of histogram
for i = length(binLocations_if):-1:1
   if counts_if(i) > 1
       r_max = i + 1;
       break
   end
end

%Due to the nature of the fluorescent microscopy - the bacteria is going to
%be the brightest 
%let threshold be two grey levels smaller than r_max

T = r_max - 2;

%Populate temp_image with binary mask values

for i = 1:numCols
   for j = 1:numCols
      if I > T
          temp_image(i,j) = 1;
      end
   end
end

J = temp_image;

end

