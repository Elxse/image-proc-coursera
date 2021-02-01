function [Q] = img_quantize(timg, method, threshold)
    % Quantize each block of the image using the quantization table
    % or a threshold.
    %
    % Input:
    %   timg - a matrix of transformed coefficients
    %   method - quantization to be applied
    %           (0 to use the quantization table, 1 to use an unique
    %           threshold, 2 to preserve the 8 largest coefficients)
    %   threshold - for method 1, the quantity by which each 
    %               coefficient will be divide and multiply back after
    %               rounding the result.
    %
    % Output:
    %   Q - matrix of quantized coefficients
    % 
    % Throw an error if 'method' or 'threshold' are invalid.
    
    % Size of a block
    N = 8;
    
    % Image's dimension
    [rows, cols] = size(timg);
    
    % Number of blocks per row (NR) and column (NC)
    NR = floor(rows / N);
    NC = floor(cols / N);
    
    % Preallocate of Q
    Q = zeros(N * NR, N * NC);
    
    % Quantization matrix
    Qm = [ 16, 11, 10, 16, 24, 40, 51, 61; ...
           12, 12, 14, 19, 26, 58, 60, 55; ...
           14, 13, 16, 24, 40, 57, 69, 56; ...
           14, 17, 22, 29, 51, 87, 80, 62; ...
           18, 22, 37, 56, 68, 109, 103, 77; ...
           24, 35, 55, 64, 81, 104, 113, 92; ...
           49, 64, 78, 87, 103, 121, 120, 101; ...
           72, 92, 95, 98, 112, 100, 103, 99 ];
    
    % For each block...
    for i = 1 : NR
        for j = 1 : NC
            % Get the corresponding transformed coefficients
            sub_img = double(timg(1+N*(i-1):N*i, 1+N*(j-1):N*j));
            
            if (method == 0)
                % Quantize using the quantization matrix
                Q(1+N*(i-1):N*i, 1+N*(j-1):N*j) = round(sub_img ./ Qm) .* Qm;
            
            elseif (method == 1)
                % Quantize by threshold
                if (threshold < 1 || floor(threshold) ~= threshold)
                    error('Invalid threshold.');
                end
                
                Q(1+N*(i-1):N*i, 1+N*(j-1):N*j) = round(sub_img / threshold) * threshold;
                
            elseif (method == 2)
                % Preserve the 8 largest coefficients by absolute value
                sorted_mat = sort(reshape(abs(sub_img), N * N, 1), 'descend');
                largest_coeff = sorted_mat(N);
                 Q(1+N*(i-1):N*i, 1+N*(j-1):N*j) = round(sub_img .* (abs(sub_img) >= largest_coeff));
            else
                error('Invalid method.');
                
            end % if
        end % for j
    end % for i
    
end