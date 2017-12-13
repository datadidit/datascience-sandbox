function g = sigmoid(z)
%SIGMOID Compute sigmoid function
%   g = SIGMOID(z) computes the sigmoid of z.

% You need to return the following variables correctly 
g = zeros(size(z));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the sigmoid of each value of z (z can be a matrix,
%               vector or scalar).
for i = 1:rows(g)
  for j = 1:columns(g)
    temp = z(i,j);
    g(i,j) = 1/(1+e^-(temp));
    %printf("z(%d,%d) = %f\n", i, j, g(i,j));
  endfor
endfor


% =============================================================

end
