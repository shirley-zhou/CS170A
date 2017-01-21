function J = rotation(a, b, d)

mu = sqrt((a-d^2 + 4*b^2));
if (mu > 0)
    c = sqrt(((a-d)+mu)/(2*mu));
    s = sqrt((-(a-d)+mu)/(2*mu));
    J = [c -s; s c];
else
    J = eye(2);
end