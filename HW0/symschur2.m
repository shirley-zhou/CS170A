function [c, s] = symschur2(A, p, q)

if A(p, q) ~= 0,
    r = (A(q, q) - A(p, p)/(2*A(p, q)));
    if r >= 0,
        t = 1/(r + sqrt(1+(r^2)));
    else
        t = -1/(-r + sqrt(1+(r^2)));
    end
    c = 1/sqrt(1+(t^2));
    s = t*c;
else
    c = 1;
    s = 0;
end
