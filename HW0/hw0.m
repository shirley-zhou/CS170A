%Problem 1:
X = csvread('Iris.csv', 1, 0 );

Xprojected = projection(X, 2);
plot(Xprojected(:,1), Xprojected(:,2), 'r.');
%find outliers
[rowsumsX, I1] = max(sum(Xprojected, 2))
Xprojected(I1, :)

HallOfFame;
Yprojected = projection(Stats, 2);
plot(Yprojected(:,1), Yprojected(:,2), 'b.');
[rowsumsY, I2] = max(sum(Yprojected, 2))
Yprojected(I2, :)

%---------------------------------------------
%Problem 2:
heroes;
[V, E] = eig(hero_network);
e = diag(E);

plot(e, 'g.');

[largest, index] = max(e);

spectralnorm = norm(hero_network)

eigenvector = V(:,index) %print eigenvector corresp to largest eigenvalue

plot(eigenvector, 'b.');

%find entry with largest value in eigenvector:
[largest, index] = max(eigenvector);

index

names(index)

%degree sequence
Nonzero_entries = logical(hero_network);
d = sum(Nonzero_entries, 2)

plot(d, 'r.');

[largest, index] = max(d);

index

%Graph Laplacian
D = diag(d);
L = D - Nonzero_entries;

eigenvals = eig(L);
for i=1:size(eigenvals, 1)
    if abs(eigenvals(i)) < 1e-14,
        eigenvals(i) = 0;
    end
end

z = ~logical(eigenvals);
numzeros = sum(z)

%Perron-Frobenius
colsums = sum(hero_network, 2) %sum cols of adjacency matrix
mincols = min(colsums)
maxcols = max(colsums)

%Problem 3:
%Jacobi:
%[V L] = jacobi(hero_network)
