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
    h = X * theta;
    error = h - y;
    m = length(y);

    %=======================================
    % My original attempt at algorithm
    %deriv0 = (1/length(y)) * sum(error);
    %deriv1 = (1/length(y)) * sum(error2);
    %temp0 = theta(1) - alpha * deriv0;
    %temp1 = theta(2) - alpha * deriv1;
    %=======================================
    theta_change = (alpha*(1/m)*(transpose(X) * error));
    
    theta = theta - theta_change;
   
    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);

end

end
