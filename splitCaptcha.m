function [singles, unit] = splitCaptcha(x, n)
    %SPLITCAPTCHA split a captcha into n single num
    % or alphabet

    % get height and width
    [height, width] = size(x);

    % unit width
    unit = floor(width / n);

    % initialize
    singles = zeros(height, unit, n);

    for i = 1:n,
        singles(:,:,i) = x(:, (i - 1) * unit + 1:i * unit);
    end;
end