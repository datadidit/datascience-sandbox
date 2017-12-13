function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returns the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%
newCent = zeros(K, size(X,2)+1);
for i = 1:size(idx,1)
  %Update applicable row
  assignedK = idx(i);
  update = [X(i,:) 1];
  newCent(assignedK,:) = newCent(assignedK,:) + update;
endfor

%Update centroids using newCent
for info = 1:size(newCent,1)
  rowForData = newCent(info,[1:size(newCent,2)-1]);
  divisor = newCent(info,size(newCent,2));
  centroids(info,:) = rowForData./divisor;
endfor



% =============================================================


end
