function Sminus = mypinv(S)

m = size(S, 1);
n = size(S, 2);
Sminus = zeros(n, m);
p = min(m, n);
for i = 1:p
    if S(i,i) ~= 0
        Sminus(i,i) = 1/S(i,i);
    end

end