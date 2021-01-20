% Week 1 - Introduction to image and video processing
clc;

% Load the image
img = imread('lena.pgm');

% Display the image
figure(1);
imshow(img);
title('Figure 1: Original image')
input('Press any key to continue...', 's');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Reduce image's intensity level
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img_res = reduce_img_intensity(img, 2);
figure(2);
imshow(img_res);
title('Figure 2: Reduced the image''s intensity level by 2');

img_res = reduce_img_intensity(img, 16);
figure(3);
imshow(img_res);
title('Figure 3: Reduced the image''s intensity level by 16');

img_res = reduce_img_intensity(img, 32);
figure(4);
imshow(img_res);
title('Figure 4: Reduced the image''s intensity level by 32');

input('Press any key to continue...', 's');
close(figure(2)); close(figure(3)); close(figure(4));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Blur the image by averaging neighborhood 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img_res = avg_neighborhood(img, 1);
figure(2);
imshow(img_res)
title({'Figure 2: Image blurred by averaging pixels', 'to their 3x3 neighbourhood'});

img_res = avg_neighborhood(img, 5);
figure(3);
imshow(img_res);
title({'Figure 3: Image blurred by averaging pixels', 'to their 10x10 neighbourhood'});

img_res = avg_neighborhood(img, 10);
figure(4);
imshow(img_res);
title({'Figure 4: Image blurred by averaging pixels', 'to their 20x20 neighbourhood'});

input('Press any key to continue...', 's');
close(figure(2)); close(figure(3)); close(figure(4));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Rotate image by 45 and 90 degrees
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img_res = imrotate(img, 45);
figure(2);
imshow(img_res);
title('Figure 2: Rotated image by 45° counterclockwise');

img_res = imrotate(img, 90);
figure(3);
imshow(img_res);
title('Figure 3: Rotated image by 90° counterclockwise');

input('Press any key to continue...', 's');
close(figure(2)); close(figure(3));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Reduce image's resolution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img_res = reduce_img_resolution(img, 3);
figure(2);
imshow(img_res);
title('Figure 2: Reduced the image''s resolution using 3x3 blocks');

img_res = reduce_img_resolution(img, 5);
figure(3);
imshow(img_res);
title('Figure 3: Reduced the image''s resolution using 5x5 blocks');

img_res = reduce_img_resolution(img, 7);
figure(4);
imshow(img_res);
title('Figure 4: Reduced the image''s resolution using 7x7 blocks');

input('Press any key to continue...', 's');
close(figure(2)); close(figure(3)); close(figure(4));


close(figure(1));
clc;