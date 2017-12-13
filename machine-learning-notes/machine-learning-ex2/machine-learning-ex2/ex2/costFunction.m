function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));
vector_grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta
%
% Note: grad should have the same dimensions as theta
%
%compute theta*X to pass into sigmoid
H = X*theta;

%calculate cost pre summation
costPresum = zeros(size(y));

%Don't think I can do this algorithm appropriately without looping 
for i = 1:rows(H)
  for j = 1:columns(H)
    yEntry = y(i,j);
    hEntry = sigmoid(H(i,j));
    logOneHEntry = log(hEntry);
    logTwoHEntry = log(1-hEntry);
    cost = -yEntry*logOneHEntry-(1-yEntry)*logTwoHEntry;
    costPresum(i,j) = cost;
    costPresum(1, 1);
  endfor
endfor

%Sum this all up and multiply by m for J
J = 1/m * sum(costPresum);
grad = (1/m)*(transpose(sigmoid(H)-y)*X);


% =============================================================

end
