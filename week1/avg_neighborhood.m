% Week 1 - Introduction to image and video processing

% Using any programming language you feel comfortable with (it is though  recommended to use the provided free Matlab), 
% load an image and then  perform a simple spatial 3x3 average of image pixels. 
% In other words,  replace the value of every pixel by the average of the values in its 3x3 neighborhood. 
% If the pixel is located at (0,0), this means averaging  the values of the pixels at the positions 
% (-1,1), (0,1), (1,1), (-1,0), (0,0), (1,0), (-1,-1), (0,-1), and (1,-1). 
% Be careful with pixels at the  image boundaries. Repeat the process for a 10x10 neighborhood and again 
% for a 20x20 neighborhood. Observe what happens to the image (we will discuss this in more details in the very near future, about week 3).

function [img_res] = avg_neighborhood(img, n)
    % Blur the input image by replacing each pixel by the average of its (2n + 1)*(2n + 1) neighbors pixels.
    %
    % Input:
    %   img - a matrix of pixels
    %   n   - neighborhood, each pixel (i,j) will be replaced by the average
    %         of (i-n:i+n, j-n:j+n) pixels
    % Output:
    %   img_res - the blurred image
    %
    % Throw an error if n does not meet the requirements, i.e. n is not a positive number
    
    if (n <= 0 || floor(n) ~= n)
        error('Invalid `n`.');
    end
    [rows, cols] = size(img);
    img_res = zeros(rows, cols);
    for i = 1 : rows
        for j = 1 : cols
            if (i - n < 1); i_top = 1; else; i_top = i - n; end
            if (i + n > rows); i_bottom = rows; else; i_bottom = i + n; end
            if (j - n < 1); j_left = 1; else; j_left = j - n; end
            if (j + n > cols); j_right = cols; else; j_right = j + n; end
            sub_img = img(i_top : i_bottom, j_left : j_right);
            img_res(i,j) = mean(sub_img(:));
        end
    end
    
    % Round the pixels to integer values
    img_res = uint8(floor(img_res + 0.5));
end