function[outImage] = trimborder (I)
% I = imread('Patient008.jpg');
% I = rgb2gray(I);

Isize = size(I);

threshold = graythresh(I);
IBinary = imbinarize(I, threshold);

% imshow(I)

k = 1;

%this is a very C-style loop, however the properly vectorized method
%escaped me
while IBinary(k, :) == IBinary(k+1,:)
    k = k+1;
end

outImage = I((k+1:Isize(1)), :);        %why does this output to command window???

% imshow(outImage)

end