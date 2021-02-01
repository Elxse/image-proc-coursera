function [T] = img_transform(img, method)
    % Divide the image into 8x8 blocks, and on each block,
    % apply DCT or FFT. Any image dimension is truncated 
    % if it is not a multiple of 8.
    %
    % Input:
    %   img - a matrix of pixels
    %   method - transform to be applied 
    %           (0 for in-built DCT, 1 for own implementation of DCT, 2 for FFT)
    %
    % Output:
    %   T - the transform image
    %
    % Throw an error if 'method' is invalid
    
    N = 8;
    [rows, cols] = size(img);
    
    % Compute the number of blocks per row (NR) and per column (NC)
    NR = floor(rows / N);
    NC = floor(cols / N);
    
    % Preallocate the transform matrix
    T = zeros(N * NR, N * NC);
    
    % Cosine matrix for own implementation of DCT
    c = zeros(N, N);
    if (method == 1)
        for x = 1 : N
            for u = 1 : N
                c(x,u) = ((2*x-1)*(u-1)*pi)/(2*N);
            end
        end
        c = cos(c);
    end
   
    sqrt2 = sqrt(2);
    
    % For each 8x8 block...
    for i = 1 : NR
        for j = 1 : NC
            % Get the sub image corresponding to the block
            sub_img = double(img(1+N*(i-1):N*i, 1+N*(j-1):N*j));
            
            if (method == 0)
                % In-built DCT
                T(1+N*(i-1):N*i, 1+N*(j-1):N*j) = dct2(sub_img);
                
            elseif (method == 1)
                % Own implementation of DCT
                B = zeros(N,N);
                for u = 1 : N
                    for v = 1 : N
                        B(u,v) = 0;
                        for x = 1 : N
                            for y = 1 : N
                                B(u,v) = B(u,v) + sub_img(x,y) * c(x,u) * c(y,v);
                            end % for y
                        end % for x
                    end % for v
                end % for u
                
                % Normalisation of B (alpha coefficients in lecture 4)
                B = 2 * B / N;
                B(:, 1) = B(:, 1) / sqrt2;
                B(1, :) = B(1, :) / sqrt2;
                
                % Copy B in the corresponding region of T
                T(1+N*(i-1):N*i, 1+N*(j-1):N*j) = B;
                
            elseif (method == 2)
                % In-built FFT
                T(1+N*(i-1):N*i, 1+N*(j-1):N*j) = fft2(sub_img);
              
            else
                error('Invalid `method`.');
                
            end % if
        end % for j
    end % for i
end