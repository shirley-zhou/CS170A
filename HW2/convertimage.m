function A = convertimage(Img)

A = double(imread(Img))/255;
R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);
A = (R+G+B)/3;