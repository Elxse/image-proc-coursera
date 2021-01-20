% Week 1 - Introduction to image and video processing

% For every 3×3 block of the image (without overlapping), 
% replace all corresponding 9 pixels by their average. 
% This operation simulates reducing the image spatial resolution. 
% Repeat this for 5×5 blocks and 7×7 blocks. If you are using Matlab, investigate simple command lines to do this important operation.

function [img_res] = reduce_img_resolution(img, n)
    % Reduce the image resolution by replacing each pixel
    % of the same nxn block by the corresponding average of the block's
    % pixels.
    %
    % Input:
    %   img - a matrix of pixels
    %   n   - size of block to consider
    %
    % Output:
    %   img_res - resulting image with lower resolution
    %
    % Throw an error if invalid input `n`, i.e. n is not a positive integer
    
    if (n <= 0 || floor(n) ~= n)
        error('Invalid `n`.')
    end
    [rows, cols] = size(img);
    img_res = zeros(rows, cols);
    
    % Compute the number of complete blocks per rows (b_rows) and per columns (b_cols)
    % and remainders per rows (r_rows) and per columns (r_cols)
    b_rows = floor(rows / n);
    b_cols = floor(cols / n);
    %r_rows = mod(rows, n);
    %r_cols = mod(cols, n);
    
    % Process the complete blocks
    % For each complete block...
    for br = 1 : b_rows
        for bc = 1 : b_cols
            % ... determine the position of the block...
            start_row = (br - 1) * n + 1;
            end_row = br * n;
            start_col = (bc - 1) * n + 1;
            end_col = bc * n;
            sub_img = img(start_row:end_row, start_col:end_col);
            
            % ... compute the average of the pixels composing the block...
            avg = mean(sub_img(:));
            
            % ... and set all pixels of the corresponding complete block to `avg`
            for i = start_row : end_row
                for j = start_col : end_col
                    img_res(i,j) = avg;
                end
            end       
        end 
    end
    
    % Process the remaining rows on the bottom, adjacent to complete blocks
    % (minus the bottom right corner).
    % Same procedure, except the average will correspond to the average
    % of the remaining pixels of blocks of size r_rows * n 
    start_row = (b_rows - 1) * n + 1;
    end_row = rows;
    for bc = 1 : b_cols
        start_col = (bc - 1) * n + 1;
        end_col = bc * n;
        sub_img = img(start_row:end_row, start_col:end_col);
        avg = mean(sub_img(:));
        
        for i = start_row : end_row
            for j = start_col : end_col
                img_res(i,j) = avg;
            end
        end       
    end 
    
    % Process the remaining cols on the right, adjacent to complete blocks
    % (minus the bottom right corner).
    % Same procedure, except the average will correspond to the average
    % of the remaining pixels of blocks of size n * r_cols 
    start_col = (b_cols - 1) * n + 1;
    end_col = cols;
    for br = 1 : b_rows
        start_row = (br - 1) * n + 1;
        end_row = br * n;
        sub_img = img(start_row:end_row, start_col:end_col);
        avg = mean(sub_img(:));
        
        for i = start_row : end_row
            for j = start_col : end_col
                img_res(i,j) = avg;
            end
        end       
    end 
    
    % Process the remaining pixels on the bottom right corner
    start_row = (b_rows - 1) * n + 1;
    end_row = rows;
    start_col = (b_cols - 1) * n + 1;
    end_col = cols;
    sub_img = img(start_row:end_row, start_col:end_col);
    avg = mean(sub_img(:));
    for i = start_row : end_row
        for j = start_col : end_col
            img_res(i,j) = avg;
        end
    end       
    
    % Round the pixels to integer values
    img_res = uint8(floor(img_res + 0.5));
end