function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta
H = sigmoid(X*theta);
costSum1 = -transpose(y)*log(H);
costSum2 = transpose(1-y)*log(1-H);

%Math to regularize
[rows, cols] = size(theta);
regularizeTheta = theta([2:rows], 1);
%size(regularizeTheta)
%Compute cost 
J = (1/m).*(costSum1 - costSum2) + (lambda/(2*m))*sum(regularizeTheta.^2);

%Compute gradient
%Working version
grad = (1/m)*(transpose(H-y)*X);
nonReg = grad(1,1);
grad = (1/m)*(transpose(H-y)*X) + transpose((lambda/m)*theta);
grad(1,1) = nonReg;

% =============================================================

end
