%% makeXY: this function make X(i) = a number or 
%% a letter image, Y(i) = the value of X(i)
%% args : captcha => the unrolled captcha matrices;
%%        code    => the value of captcha;
%%        n       => the number of characters in captcha
%%        height  => the height of captcha matrix befor unroll
%%        weight  => the width of captcha matrix before unrrol   
function [X, Y, unit] = makeXY(captcha, code, n, height, width)
    % def useful variables
    m = size(captcha);  % num of exaples
    
    % initialize
    X = zeros(m * n, 1);
    Y = zeros(m * n, 1);

    % split image
    for i = 1:m,
        [temp unit] = splitCaptcha(reshape(captcha(i,:), height, width), n);
        for j = 1:n,
            % single character
            single = temp(:,:,j);
            % size of single
            len = size([single(:)]);
            % resize X
            if size(X)(2) == 1,
                X = resize(X, m * n, len);
            end;
            % unroll single and asign to X
            X(n * (i - 1) + j, :) = [single(:)'];
            % hash value for Y
            % 0     =>  10
            % 1-9   =>  1-9
            % a-z   =>  11-37
            hashed_value = 0;
            value = code{i}(j);
            if value == '0',
                hashed_value = 10;
            elseif value >= '1' && value <= '9',
                hashed_value = value - '0';
            elseif value >= 'a' && value <= 'z',
                hashed_value = 11 + value - 'a';
            end;
            % asign to Y
            Y(n * (i - 1) + j) = hashed_value;
        end;
    end;

    % store data
    save X.mat X;
    save Y.mat Y unit height;

end
