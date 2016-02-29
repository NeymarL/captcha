%% READDATA: read image and transform to unroll them
function [captcha code h w] = readData()
    % read train record
    [name code num] = textread('train_images/train_record', '%s %s %d');
    % get date size
    len = size(name);
    % initialize captcha, captcha store by row
    % captcha(i) represent the ith example
    captcha = zeros(len, 1);
    h = 0;
    w = 0;
    % read image
    for i = 1:len,
        filename = strcat('train_images/', name(i));
        filename = strcat(filename, '.png');
        % trans cell to string
        filename = filename{1};
        x = imread(filename);
        % remove the white border of image
        x_ = removeBorder(x(:,:,1));
        [h w] = size(x_);
        % unroll x_ to a row and asign to captcha(i)
        length = size(x_(:)')(2);
        if size(captcha)(2) == 1,
            captcha = resize(captcha, len, length);
        end;
        captcha(i,:) = [x_(:)'];
    end;
end;
