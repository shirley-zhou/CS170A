function [U, S, V] = mysvd(A)

n = size(A, 1);
p = size(A, 2);
[V, L] = eig(A' * A);
L = diag(L);

%sort V, L simultaneously
for i=1:p
m = i; %index of current max eigenvalue
    for j=i+1:p
        if (L(j) > L(i))
            m = j;
        end
    end
    if m ~= i %swap columns
        tmp_L = L(i);
        L(i) = L(m);
        L(m) = tmp_L;
        tmp_V = V(:,i);
        V(:,i) = V(:,m);
        V(:,m) = tmp_V;
    end
end
S = sqrt(diag(L));
if p > n
    S = S(1:n, 1:p);
else
    S = [S; zeros(p-n, p)];
end
U = A * V * mypinv(S);

