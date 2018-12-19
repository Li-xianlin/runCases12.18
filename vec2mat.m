function M=vec2mat(V,dim);
%--------------------------------------------------------------------
% vec2mat function     convert vector to matrix.
% Input  : - Matrix, dimension
% Output : - Matrix.
%--------------------------------------------------------------------


M = zeros(dim,dim);

for i = 1:dim
    M(:,i) = V((i-1)*dim+1:i*dim);
end

