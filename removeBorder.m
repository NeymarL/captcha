function [after] = removeBorder(before)
    %REMOVEBORDER remove the border of a captcha

    % get height and width
    [height, width] = size(before);

    % 0-30, 215-30, 215, 15

    height_rate = 15 / 80;
    width_rate = 30 / 215;

    height_start = height_rate * height;
    height_end = height - height_start;

    width_start = width_rate * width;
    width_end = width - width_start;

    after = before(height_start:height_end, width_start:width_end);


end