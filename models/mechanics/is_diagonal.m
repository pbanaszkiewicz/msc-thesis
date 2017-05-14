function [ result ] = is_diagonal( matrix, epsilon )
%IS_DIAGONAL Check if matrix is very close to being diagonal
%   Args:
%   epsilon - number by which the comparison should be performed

m = abs(matrix - diag(diag(matrix)));
result = all(m(:) < epsilon);

end

