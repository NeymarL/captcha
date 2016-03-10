function [] = split_and_store()
    % read train record
    [name code num] = textread('train_images/train_record', '%s %s %d');
    % get date size
    len = size(name);
    % initialize captcha, captcha store by row
    % captcha(i) represent the ith example
    captcha = zeros(len, 1);
    h = 0;
    w = 0;
    cnt = 0;
    out_name = ".png";
    % read image
    for i = 1:len,
        %filename = strcat('train_images/', name(i));
        %filename = strcat(filename, '.png');
        % trans cell to string
        %filename = filename{1};
        %x = imread(filename);
        % remove the white border of image
        %x_ = removeBorder(x);
        %[s u] = splitCaptcha(x_, 6);
        %s = uint8(s);
        fid = fopen("record.txt", "wt");
        for j = 1:6,
            f = strcat('good_images/', int2str(cnt));
            f = strcat(f, out_name);
            %imwrite(s(:,:,:,j), f);
            value = code{i}(j);
            fprintf(fid, '%d %s\n', cnt, value);
            cnt = cnt + 1;
        end;
        fclose(fid);
    end;

end