function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%
hX = X * theta;

%Compute cost
costSum1 = (1/(2*m))*sum((hX-y).^2);

%Math to regularize
[rows, cols] = size(theta);
regularizeTheta = theta([2:rows], 1);
costSum2 = (lambda/(2*m))*sum(regularizeTheta.^2);

J = costSum1 + costSum2;
% =========================================================================
%Compute gradient
%Working version
grad = (1/m)*(transpose(hX-y)*X);
nonReg = grad(1,1);
grad = (1/m)*(transpose(hX-y)*X) + transpose((lambda/m)*theta);
grad(1,1) = nonReg;

grad = grad(:);

end
