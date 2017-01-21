function [Q, L] = jacobi(A)
n = size(A, 1);
Q = eye(n);

if (norm((A-A'), 'fro') / norm(A, 'fro') > n*n*eps)
    disp('error')
end

offDiag = logical(1-eye(n));

while (norm(A(offDiag), 'fro')^2 / norm(A, 'fro')^2 > n*n*eps)
    maxval = -Inf;
    %choose p, q so |A(p, q)| is maximized
    for p = 1:(n-1)
        for q = (p+1):n
            curr = abs(A(p, q));
            if curr > maxval,
                maxval = curr;
                maxp = p;
                maxq = q;
            end
        end
    end
    
    p = maxp;
    q = maxq;
    a = A(p,p);
    b = A(p,q);
    d = A(q,q);
    J = rotation(a, b, d);
    A([p q], :) = J'*A([p q], :);
    A(:, [p q]) = A(:, [p q])*J;
    Q(:, [p q]) = Q(:, [p q])*J;
end

L = diag(diag(A));