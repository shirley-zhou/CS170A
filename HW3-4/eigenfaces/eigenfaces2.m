function [S_k, V_k, avgface, C] = eigenfaces2(filenames, k, s)

row = 64;
col = 64;
image_vector  = @(Bitmap) double(reshape(Bitmap,row*col,1));
vector_image  = @(Vec) reshape( uint8( min(max(Vec,0),255) ), row, col);
vector_render = @(Vec) imshow(vector_image(Vec));

sz = max(size(filenames));
if s > sz || isempty(s),
    s = sz;
end;

for i=1:s
    Face = imread(filenames{i});
    F(i,:) = image_vector(Face);
end;

avgface = mean(F);
vector_render(avgface');

M = ones(s,1) * avgface;

X = F - M;
[U_k,S_k,V_k] = svds( cov(X), k );

C = X*V_k;

