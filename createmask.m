function[mask] = createmask(I)

% I = imread('Patient008.jpg');
% I = rgb2gray(I);

I=medfilt2(I);

threshold = graythresh(I);
IBinary = imbinarize(I, threshold);

%imshow(IBinary)

ISmooth = medfilt2(IBinary);        %Using a median filter to smooth the binary image

%imshow(ISmooth)

[~, threshold] = edge(ISmooth, 'sobel');
fudgefactor = 0.2;    %the closer to 1, the fewer lines appear.  The closer to 0, the more
BinaryEdge = edge(ISmooth, 'sobel', threshold * fudgefactor);
% imshow(BinaryEdge)

structure90 = strel('line', 2, 90);     %structure('type', thickness, angle)
structure00 = strel('line', 2, 0);      %structure('type', thickness, angle)
 
MaskDilate = imdilate(BinaryEdge, [structure90, structure00]);      %dilate using the line structures as guides
% imshow(MaskDilate)

Isize = size(MaskDilate);
TotalSize = Isize(1) * Isize(2);
opened = bwareaopen(MaskDilate, floor(TotalSize/200));      %opening the area, removing any shapes with fewer than size/200 pixels
% imshow(opened)

EdgeFill = imfill(opened, 'holes');       %fill in the holes  in the image
% imshow(EdgeFill)

ClearedEdge = imclearborder(EdgeFill);      %remove any shapes touching the edges of the image.  The lung should be centered so this should never remove the lungs
% imshow(ClearedEdge)

mask = uint8(ClearedEdge);

end