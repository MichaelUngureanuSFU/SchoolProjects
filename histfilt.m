function[mask] = histfilt(I)

lunghisteq = histeq(I);
% imshow(lunghisteq)

threshold = graythresh(lunghisteq);
IBinary = imbinarize(lunghisteq, threshold);

mask = uint8(IBinary);
end