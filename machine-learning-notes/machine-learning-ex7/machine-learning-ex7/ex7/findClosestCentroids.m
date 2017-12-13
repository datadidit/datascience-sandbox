function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%
distances = zeros(size(X,1), size(centroids,1));
for i = 1:size(X,1)
  assignment = [-1; 0];
  for centroid = 1:size(centroids,1)
    %compute length
    lenSqr = [X(i,:)-centroids(centroid,:)].^2;
    tLength = sum(lenSqr);
    distances(i,centroid) = tLength;
    if(assignment(1)==-1)
      assignment = [centroid; tLength];
    elseif(assignment(2)>tLength)
      assignment = [centroid; tLength];
    endif
  endfor
  
  %Make assignment 
  idx(i) = assignment(1);
endfor





% =============================================================

end

