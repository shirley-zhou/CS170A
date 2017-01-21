%Problem 1: SVD

C = gallery('chow', 8);
[U, S, V] = mysvd(C);
largest = max(max(S));
smallest = min(min(S));
conditional = largest/smallest

%F = hadamard(8);
%H = hilb(8);
%P = pascal(8);


%[U, S, V] = mysvd(F);
%[U, S, V] = mysvd(H);
%[U, S, V] = mysvd(P);

A = double(imread('Joseph_Fourier_1820.jpg'))/255;
R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);
A = (R+G+B)/3;

[U, S, V] = mysvd(A);
S(1:5, 1:5) = 0;
Serror5 = S;
Aerror5 = U*Serror5*V';
imshow(Aerror5);

S(1:10, 1:10) = 0;
Serror10 = S;
Aerror10 = U*Serror10*V';
imshow(Aerror10);

S(1:20, 1:20) = 0;
Serror20 = S;
Aerror20 = U*Serror20*V';
imshow(Aerror20);

S(1:50, 1:50) = 0;
Serror50 = S;
Aerror50 = U*Serror50*V';
imshow(Aerror50);

%Problem2:
p = [3 2 5 4];
q = [4 5 3 1];
r = quaternionmultiply(p,q)

q = [8 2 3 1];
qinv = quaternioninverse(q)
qinv * (q*q')

x = [1 0 0];
theta = pi/6;
z = [0 0 1];
x = [0 x];

q = rotationquaternion(theta, z);
tmp = quaternionmultiply(quaternioninverse(q), x);
w = quaternionmultiply(tmp, q)

%check
axang = [0 0 1 pi/6];
quat = axang2quat(axang);
w = quatrotate(quat, [1 0 0])

%D
%u = [1 2 3];
theta = pi/3;
v = [1 1 1];
%u = [0 u];
q = rotationquaternion(theta, v);
%tmp = quaternionmultiply(quaternioninverse(q), u);
%w = quaternionmultiply(tmp, q)
%q1 = quiver3(0,0,0, 1, 2, 3);
%hold on;
%q2 = quiver3(0,0,0, w(1), w(2), w(3));
%hold on;
%rotate axes
tmp = quaternionmultiply(quaternioninverse(q), [0 1 0 0]);
x = quaternionmultiply(tmp, q);
tmp = quaternionmultiply(quaternioninverse(q), [0 0 1 0]);
y = quaternionmultiply(tmp, q);
tmp = quaternionmultiply(quaternioninverse(q), [0 0 0 1]);
z = quaternionmultiply(tmp, q);
q3 = quiver3([0,0,0], [0,0,0], [0,0,0], [x(1) y(1) z(1)], [x(2) y(2) z(2)], [x(3), y(3), z(3)]);
legend([q1 q2 q3], 'original u', 'rotated u', 'rotated axes');

%E
theta = pi/3;
v = [1 1 1];
q = rotationquaternion(theta, v);
tmp = quaternionmultiply(quaternioninverse(q), [0 1 0 0]);
x = quaternionmultiply(tmp, q);
tmp = quaternionmultiply(quaternioninverse(q), [0 0 1 0]);
y = quaternionmultiply(tmp, q);
tmp = quaternionmultiply(quaternioninverse(q), [0 0 0 1]);
z = quaternionmultiply(tmp, q);
graph = quiver3([0,0,0], [0,0,0], [0,0,0], [x(1) y(1) z(1)], [x(2) y(2) z(2)], [x(3), y(3), z(3)]);

graph.ShowArrowHead = 'off';

p = -q;
tmp = quaternionmultiply(quaternioninverse(p), [0 1 0 0]);
x = quaternionmultiply(tmp, p);
tmp = quaternionmultiply(quaternioninverse(p), [0 0 1 0]);
y = quaternionmultiply(tmp, p);
tmp = quaternionmultiply(quaternioninverse(p), [0 0 0 1]);
z = quaternionmultiply(tmp, p);
graph = quiver3([0,0,0], [0,0,0], [0,0,0], [x(1) y(1) z(1)], [x(2) y(2) z(2)], [x(3), y(3), z(3)]);
graph.ShowArrowHead = 'off';

%Problem3:
A = zeros(14800, 13);
for i=1:13
    F = convertimage(sprintf('faces/basis/f%d.jpg', i));
    f = F(:);
    A(:,i) = f/norm(f);
end

T2 = convertimage('faces/tests/t2.jpg');
b = T2(:);

x = pinv(A'*A)*A'*b;
v = A*x;
v = v/(max(v));
imshow(reshape(v,148,100));
imshow(T2);

%squared error
norm(v-b)^2

%coefficients
x'

%highest correlation
RHO = corr(A);
RHO2 = RHO;
RHO2(logical(eye(13))) = 0;
[Y I] = max(RHO2);

COEFF = pca(RHO)

c1 = COEFF(:,1);
c2 = COEFF(:,2);
%pairwise distances
D = squareform(pdist([c1 c2]))
D(logical(eye(13))) = Inf;
m = min(D)

%Problem 4:
[time ixic] = read_stock('IXIC.csv');
t1 = time(2:7350);
y1 = ixic(2:7350);
t2 = time(9611:11287);
y2 = ixic(9611:11287);

%Polynomial Fit:
%First time period:
X4 = [t1.^4 t1.^3 t1.^2 t1 t1.^0];
c1p = X4 \ y1; %find coefficients of degree 4 polynomial

%Second time period:
X4 = [t2.^4 t2.^3 t2.^2 t2 t2.^0];
c1p = X4 \ y2; %find coefficients of degree 4 polynomial

%Exponential fit:
%First time period:
Ylog = log(y1);
T1 = [t1.^0 t1];
c1log = Ylog \ T1

%Second time period:
Ylog = log(y2);
T2 = [t2.^0 t2];
c2log = Ylog \ T2

%Polynomial Fit:
%First time period:
c1p = polyfit(t1, y1, 4); %find coefficients of degree 4 polynomial

%Second time period:
c2p = polyfit(t2, y2, 4); %find coefficients of degree 4 polynomial

%Exponential fit:
%First time period:
ylog = log(y1);
c1log = polyfit(t1, ylog, 1);
polylog1 = polyval(c1log, t1);

%Second time period:
ylog = log(y2);
c2log = polyfit(t2, ylog, 1);
polylog2 = polyval(c2log, t2);

hold on;
plot(t1, polyval(c1p, t1), 'r', t2, polyval(c2p, t2), 'r');
hold on;
plot(t1, exp(polylog1), 'g', t2, exp(polylog2), 'g');
title(sprintf('poly1: %d %d %d %d %d, poly2: %d %d %d %d %d \nexp1: %d %d, exp2: %d %d', c1p, c2p, c1log, c2log))

%squared errors:
polyerror1 = norm(polyval(c1p, t1) - y1)^2
polyerror2 = norm(polyval(c2p, t2) - y2)^2
experror1 = norm(exp(polylog1) - y1)^2
experror2 = norm(exp(polylog2) - y2)^2

%% get the desired interval of NASDAQ quotes here...
desired_ixic = ixic(8223:9481);
n = size(desired_ixic,1);
power_spectrum = abs(fft(desired_ixic)).^2;
log_power_spectrum = log(power_spectrum); % power_spectrum values have large range, so we use a semilog plot

%% NOTE: use day numbers (\verb"ixic" subscript values) as ’x’ values --- not the ’time’ values in IXIC.csv !!
frequencies = linspace(0, 1.0, n);
%% stock quotes are made "once per day", so their frequency is 1/day.
%% In the frequencies vector, the largest value 1.0 means stocks are sampled once per day.
%% In other words, the frequency values have 1/day as their maximum.
plot(frequencies(2:floor(n/2)), log_power_spectrum(2:floor(n/2)));
%% We plot only the first half of the data, since the second half is a mirror image;
%% also we ignore the first Fourier coefficient, since it is just the sum of the input.

v = log_power_spectrum(2:floor(n/2));
I = find(v < 8)

