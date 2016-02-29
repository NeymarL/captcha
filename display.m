%% display: random pick a picture to display
function [] = display()
    % load data
    load X.mat;
    load Y.mat;

    while 1,
        % random pick a index
        index = floor(rand * size(X)(1));
        xi = X(index,:);
        img = reshape(xi, height, unit);
        imagesc(img);
        value = Y(index);
        % hash back
        value = Y(index);
        if value == 10,
            value = '0';
        elseif value >= 1 && value <= 9,
            value += '0';
        elseif value >= 11 && value <= 37,
            value = value - 11 + 'a';
        fprintf('Y(%d) = %c\n', index, value);
        fprintf('Program paused. Press enter to continue.\n');
        pause;
    end;

end;
