function [S_k, V_k] = eigenfaces2(filenames, k, s)

sz = max(size(filenames));
if s > sz || isempty(s),
    s = sz;
end;

for i=1:s
    Face = imread('filenames[i]');
    F(i,:) = image_vector(Face);
end;

avgface = mean(F);
vector_render(avgface');

M = ones(n,1) * avgface;

X = F - M;
[U_k,S_k,V_k] = svds( cov(X), k );


