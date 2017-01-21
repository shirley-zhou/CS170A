function [V, L] = jacobi(A)
n = size(A, 1);
V = eye(n);

offDiag = logical(1-eye(n));

while (norm(A(offDiag)) > n*n*eps)
    max = -Inf;
    %choose p, q so |A(p, q)| is maximized
    for p = 1:(n-1)
        for q = (p+1):n
            curr = abs(A(p, q));
            if curr > max,
                max = curr;
                maxp = p;
                maxq = q;
            end
        end
    end
    
    p = maxp;
    q = maxq;
    [c, s] = symschur2(A, p, q);
    J = [c s; -s c];
    A([p q], :) = J'*A([p q], :);
    A(:, [p q]) = A(:, [p q])*J;
    V(:, [p q]) = V(:, [p q])*J;
end

L = diag(diag(A));