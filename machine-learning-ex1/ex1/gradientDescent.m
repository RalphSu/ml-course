function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %







    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);
    gradient_0 = sum(  X * theta - y)
    gradient_1 = sum( X(:, 2)' * (X * theta - y))
    theta = theta - alpha * [gradient_0; gradient_1] / m
    fprintf('iter: %d. cost = %f, gradient_0: %f, gradient_1: %f, new theta: %f \n', iter, J_history(iter), gradient_0, gradient_1, theta);

end

end
