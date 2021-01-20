% Week 1 - Introduction to image and video processing

% Write a computer program capable of reducing the number of intensity
% levels in an image from 256 to 2, in integer powers of 2. The desired
% number of intensity levels needs to be a variable input to your program.

function [img_res] = reduce_img_intensity(img, level)
    % Reduces the number of intensity level of a (greyscale) image
    %
    % Input:
    %   img - a matrix of pixels
    %   level - desired intensity level, must be a positive integer between
    %           1 and 128 and must be a power of 2
    %
    % Output:
    %   img_res - a matrix of reduced intensity image's pixels
    %   Each image's pixel is processed as follows:
    %
    %              |              |
    %              |  image(x,y)  |
    %   img(x,y) = | ------------ | * level 
    %              |    level     |
    %              +---        ---+
    %
    % Throw an error if level does not meet requirements
    
    if (level <= 0 || level > 128 || floor(level) ~= level || level ~= 2^(nextpow2(level)))
        error('Invalid `level`.');
    end
    img_res = floor(img./level)*level;
end