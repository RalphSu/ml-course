function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

%size(Theta1)
%size(Theta2)
%size(lambda)

X = [ones(size(X, 1), 1) X];
%delta3 = zeros(num_labels, 1);
delta2 = zeros(num_labels, hidden_layer_size +1);
delta1 = zeros(hidden_layer_size, input_layer_size +1);
for i = 1:m
	% feed forwrd to calculate the estimation
	a1 = X(i, :)';
	z1 = a1;
	z2 = Theta1 * a1;
	a2 = sigmoid(z2);
	a2 = [ 1; a2];
	z3 = Theta2 * a2;
	a3 = sigmoid(z3); % num_labeles *1
	y_i = eye(num_labels)(y(i), :); % vectorize y(i) from one value(1-10) to vector with 0/1 value at 10 dimensions
	
	% accumulate cost
	J = J + sum( -1 * y_i * log(a3) - (1- y_i) * log(1- a3));
	% backword propagation now
%	size(a3)
%	size(y_i)
	err3 = a3 - y_i'; % num_lables* 1
%	size(err3)
	%size(z2)
	err2 = (Theta2' * err3)(2:end) .* sigmoidGradient(z2);
	%size(err2)
	delta2 = delta2 + err3 * a2' %.+ lambda *[zeros(size(Theta2), 1) Theta2(:, 2:end)];
	%delta2 = delta2(2:end);
	err1 = (Theta1' * err2)(2:end) .* sigmoidGradient(z1)(2:end, :);
	delta1 = delta1 + err2 * a1' %.+ lambda *[zeros(size(Theta1), 1) Theta1(:, 2:end)];
	%size(delta2)
	%fprintf('Program paused. Press enter to continue.\n');
	%pause;
	%err1 = Theta1' * err2 .* sigmoidGradient(z1)
end
J = J / m + lambda /2 /m * (sum(sum(Theta1(:, 2:size(Theta1, 2)) .^2)) + sum(sum(Theta2(:, 2:size(Theta2, 2)) .^2)));
Theta1_grad = delta1/m;
%size(Theta1)
%size(delta1)
Theta2_grad = delta2/m;
%size(Theta2)
%size(delta2)



% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
