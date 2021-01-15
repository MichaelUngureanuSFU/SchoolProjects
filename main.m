function[] = main()

I = imread('FinalProject_Code/Patient008.jpg');
I = rgb2gray(I);
% imshow(I)

[mask, lungonly, blacklesslung,BlackMask, whitelesslung,swellings,binaryswell] = Lungfilter(I);

% imshow(mat2gray(binaryswell))

sumlung = sum(sum(mask));
sumswell = sum(sum(binaryswell));

percentswollen = (sumswell/sumlung)*100;

disp('Percent of lung swollen due to COVID-19: ');
disp(percentswollen)


%images used in report
figure()
imshow(I)
title('CT scan of lungs used to identify COVID-19 infections')

figure()
imshow(mat2gray(mask))
title('Mask of lungs used to isolate lungs and count area of lungs')

figure()
imshow(lungonly)
title('Isolated lungs')

figure()
imshow(blacklesslung)
title('Isolated lungs without the background lung, leaving only swellings and blood vessels (and noise)')

figure()
imshow(BlackMask)
title('Mask to isolate the white from a lung')

figure()
imshow(whitelesslung)
title('Isolated lungs without white (blood vessels)')

figure()
imshow(swellings)
title('isolated swellings')

figure()
imshow(binaryswell)
title('Mask to isolate swellings from lung and count area of swellings')
end