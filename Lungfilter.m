function[mask,lungonly, blacklesslung,BlackMask, whitelesslung,swellings,binaryswell] = Lungfilter(I)

% I = imread('Patient003.jpg');
% I = rgb2gray(I);

I = trimborder(I);
% imshow(I)

mask = createmask(I);

lungonly = I;
lungonly = I .* mask;
% imshow(lungonly)

histmask = histfilt(lungonly);
% imshow(mat2gray(histmask))

blacklesslung = lungonly .* histmask;
% imshow(blacklesslung)

% smoothblacklung = medfilt2(blacklesslung);

threshold = graythresh(I);
binarylung = imbinarize(blacklesslung,threshold);
% imshowpair(binarylung, blacklesslung, 'montage')
% imshow(binarylung)

structure90 = strel('line', 2, 90);     %structure('type', thickness, angle)
structure00 = strel('line', 2, 0);      %structure('type', thickness, angle)
 
BlackMask = imdilate(binarylung, [structure90, structure00]);      %dilate using the line structures as guides
% imshow(BlackMask)

whitelesslung = blacklesslung;
whitelesslung = blacklesslung .* uint8(imcomplement(BlackMask));        %use the complement to expressly remove the blood vessels
% imshow(whitelesslung)

% whitesharp = imsharpen(whitelesslung);
% imshowpair(whitelesslung, whitesharp, 'montage')

diamond = strel('diamond', 1);
eroded = imerode(whitelesslung, diamond);
eroded2 = imerode(eroded, diamond);     %erode every shape in the image by 2 pixels, effectively shrinking the noise and removing the border
% imshow(eroded2)

whitefill = imfill(eroded2, 'holes');       %fill the holes
% imshow(whitefill)

reduced = bwareaopen(whitefill, 25);        %remove any shapes smaller than 25 pixels
% imshowpair(whitelesslung, reduced, 'montage')

swellings = whitelesslung;
swellings = whitelesslung .* uint8(reduced);
% imshow(swellings)

binaryswell = imbinarize(swellings);
% imshow(binaryswell)



end







