% Week 2 - Image and video compression
clc;

% Load the image
img = imread('lena.pgm');

% Display the image
figure(1);
imshow(img);
title('Figure 1: Original image')
input('Press any key to continue...', 's');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Basic implementation of JPEG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DCT and FFT
dimg = img_transform(img, 1);
fimg = img_transform(img, 2);

% Quantization

%   - Quantization table
qdm = img_quantize(dimg, 0, 0);
qfm = img_quantize(fimg, 0, 0);

%   - Threshold
qd8 = img_quantize(dimg, 1, 8);
qd16 = img_quantize(dimg, 1, 16);
qd32 = img_quantize(dimg, 1, 32);
qd64 = img_quantize(dimg, 1, 64);

qf8 = img_quantize(fimg, 1, 8);
qf16 = img_quantize(fimg, 1, 16);
qf32 = img_quantize(fimg, 1, 32);
qf64 = img_quantize(fimg, 1, 64);

%   - Preserve 8 largest coefficients
qdc = img_quantize(dimg, 2, 0);
qfc = img_quantize(fimg, 2, 0);

% Inverse transforms
imdm = img_inv_transform(qdm, 0);
imfm = img_inv_transform(qfm, 2);
imd8 = img_inv_transform(qd8, 0);
imd16 = img_inv_transform(qd16, 0);
imd32 = img_inv_transform(qd32, 0);
imd64 = img_inv_transform(qd64, 0);
imf8 = img_inv_transform(qf8, 2);
imf16 = img_inv_transform(qf16, 2);
imf32 = img_inv_transform(qf32, 2);
imf64 = img_inv_transform(qf64, 2);
imdc = img_inv_transform(qdc, 0);
imfc = img_inv_transform(qfc, 2);

% Display all compressed images
figure(2);
imshow(imdm);
title('Figure 2: DCT image, compressed using the quantization matrix');

figure(3);
imshow(imfm);
title('Figure 3: FFT image, compressed using the quantization matrix');

figure(4);
imshow(imd8);
title('Figure 4: DCT image, compressed using the threshold 8');

figure(5);
imshow(imd16);
title('Figure 5: DCT image, compressed using the threshold 16');

figure(6);
imshow(imd32);
title('Figure 6: DCT image, compressed using the threshold 32');

figure(7);
imshow(imd64);
title('Figure 7: DCT image, compressed using the threshold 64');

figure(8);
imshow(imd64);
title('Figure 8: Compressed by preserving 8 largest DCT coefficients');

figure(9);
imshow(imd64);
title('Figure 9: Compressed by preserving 8 largest FFT coefficients');


input('Press any key to continue...', 's');
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Only quantization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Quantization

%   - Quantization table
qdm = img_quantize(img, 0, 0);

%   - Threshold
qd8 = img_quantize(img, 1, 8);
qd16 = img_quantize(img, 1, 16);
qd32 = img_quantize(img, 1, 32);

%   - Preserve 8 largest coefficients
qdc = img_quantize(img, 2, 0);

% Display all compressed images
figure(1);
imshow(img);
title('Figure 1: Original image');

figure(2);
imshow(qdm);
title('Figure 2: Quantization without DCT, using the quantization matrix');

figure(3);
imshow(qdm);
title('Figure 3: Quantization without DCT, using threshold 8');

figure(4);
imshow(qdm);
title('Figure 4: Quantization without DCT, using threshold 16');

figure(5);
imshow(qdm);
title('Figure 5: Quantization without DCT, using threshold 32');

figure(6);
imshow(qdm);
title('Figure 6: Quantization without DCT, preserving 8 largest coefficients');



input('Press any key to continue...', 's');
close all;