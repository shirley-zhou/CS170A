function analyzeimage(filename)

Img = double(imread(filename));
m = size(Img, 1);
n = size(Img, 2);

I = reshape(Img, [m*n 3]);
C = cov(I);
[U S V] = svd(C);

I1 = I*V(:,1);
I2 = I*V(:,2);
I3 = I*V(:,3);

Img1 = reshape(I1,m,n);
Img2 = reshape(I2,m,n);
Img3 = reshape(I3,m,n);

imshow(mat2gray(Img1));
figure, imshow(mat2gray(Img2));
figure, imshow(mat2gray(Img3));
