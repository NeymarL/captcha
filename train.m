%% This file train neural network for 
%% recogonize captcha

% load data
load X.mat;
load Y.mat;     % include Y unit height

%% Initialization

% Setup the parameters
fprintf('Setup the parameters...\n');
input_layer_size  = height * unit;  % height x unit Input Images of Digits
hidden_layer_size = 300;  % 300 hidden units
num_labels = 37;          % 36 labels, from 1 to 10, 'a' to 'z'(11 to 37) 


% Initializing Pameters
fprintf('Initializing Pameters...\n');
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];


%% Training NN
fprintf('Training NN...\n');
options = optimset('MaxIter', 50);

%  You should also try different values of lambda
lambda = 0.3;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, Y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% plot cost
plot([1:1:50], cost);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% save theta
%save theta.mat Theta1 Theta2;

% predict
pred = predict(Theta1, Theta2, X);

accu(i) = mean(double(pred == Y));

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == Y)) * 100);
