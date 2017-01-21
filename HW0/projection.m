function R = projection(A, k)

p = size(A, 2);
P = rand(p, k);

colsums = sum(A, 1);
for i = 1:p
    A(:,i) = A(:,i) / colsums(i);
end
R = A * P;