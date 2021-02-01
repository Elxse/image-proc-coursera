function [I] = img_inv_transform(tqimg, method)
    % Invert the quantization and the transformation applied to an original
    % image. 
    %
    % Input:
    %   tqimg - a matrix of transformed and/or quantized coefficients
    %   method - the transformation method applied to the original image
    %            (0 for in-built DCT, 1 for own implementation of DCT, 2 for FFT)
    %
    % Output:
    %   I - the original image
    %
    % Throw an error if 'method' is invalid.
    
    N = 8;
    [rows, cols] = size(tqimg);
    
    % Compute the number of blocks per row (NR) and per column (NC)
    NR = floor(rows / N);
    NC = floor(cols / N);
    
    % Preallocate the approximation of the original matrix
    I = zeros(N * NR, N * NC);
    
    % Cosine matrix for own implementation of DCT, only when method is 1
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
            sub_img = double(tqimg(1+N*(i-1):N*i, 1+N*(j-1):N*j));
            
            if (method == 0)
                % In-built DCT
                I(1+N*(i-1):N*i, 1+N*(j-1):N*j) = idct2(sub_img);
                
            elseif (method == 1)
                % Own implementation of DCT
                B = zeros(N,N);
                for x = 1 : N
                    for y = 1 : N
                        B(x,y) = 0;
                        for u = 1 : N
                            for v = 1 : N
                                B(x,y) = B(x,y) + sub_img(x,y) * c(x,u) * c(y,v);
                            end % for y
                        end % for x
                    end % for v
                end % for u
                
                % Normalisation of B (alpha coefficients in lecture 4)
                B = 2 * B / N;
                B(:, 1) = B(:, 1) / sqrt2;
                B(1, :) = B(1, :) / sqrt2;
                
                % Copy B in the corresponding region of I
                I(1+N*(i-1):N*i, 1+N*(j-1):N*j) = B;
                
            elseif (method == 2)
                % In-built FFT
                I(1+N*(i-1):N*i, 1+N*(j-1):N*j) = real(ifft2(sub_img));
              
            else
                error('Invalid `method`.');
                
            end % if
        end % for j
    end % for i
    
    I = uint8(round(I));
end