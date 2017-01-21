%Problem 1:

face_descriptions;

n = size(face_features, 1);
o = size(image_to_omit, 1);

goodfaces = [];
evilfaces = [];
for i=1:n
    omit = 0;
    for j=1:o
        if strcmp(face_features(i,1), image_to_omit(j,1))
            omit = 1;
        end;
    end;
    if omit == 0
        if strcmp(face_features(i,4), 'Good')
            goodfaces = [goodfaces; face_features(i, 1)];
        else
            evilfaces = [evilfaces; face_features(i, 1)];
        end;
    end
end;

[S, V_good avggood, C_good] = eigenfaces2(goodfaces, 30, max(size(goodfaces)));
singvals = diag(S)'

[S, V_evil avgevil, C_evil] = eigenfaces2(evilfaces, 30, max(size(evilfaces)));
singvals = diag(S)'

duplicates = [];
s = size(C_good, 1);
for i=i:s
    for j=i+1:s
        if C_good(:,i) == C_good(:,j)
            duplicates = [duplicates; i j];
        end;
    end;
end;

duplicates = [];
C = C';
s = size(C, 1);
for i=i:s
    for j=i+1:s
        if C(:,i) == C(:,j)
            duplicates = [duplicates; i j];
        end;
    end;
end;

[S, V, avgface, C] = eigenfaces2(face_features(:,1), 30, max(size(face_features)));

predictions = zeros(1, 47);
for i=1:47
    Face = imread(evilfaces{i});
    F = image_vector(Face)' ;

    dist_good = (F - avggood)*(F - avggood)' ;
    dist_evil = (F-avgevil)*(F-avgevil)' ;

    if dist_evil < dist_good
     predictions(i) = 1;
    else
     predictions(i) = 0;
    end;
end;

predictions


%--------------------------------------------------------------
%Problem 2

%% 
audiofile = 'tune.wav';
[tune, Fs] = audioread(audiofile);
y = tune(:,1); % first track of the stereo clip

n = size(y, 1)
factor(n)

t = cputime;
f = fft(y);
elapsed = cputime - t;

power = abs(fft(y));
freqspectrum = linspace(1, Fs, n);
plot(freqspectrum, power);

n = floor(n/2);
power = power(1:n);
halfspectrum = linspace(1, Fs/2, n);
plot(halfspectrum, power);
axis([0 1000 0 inf]);

%intervals
i1 = 244:290;
i2 = 290:330;
i3 = 200:250;
i4 = 430:500;

[f1 p1] = top_spike(i1, power)
[f2 p2] = top_spike(i2, power)
[f3 p3] = top_spike(i3, power)
[f4 p4] = top_spike(i4, power)

%--------------
audiofile = 'tune.wav';
[untune, Fs] = audioread(audiofile);
y = tune(:,1); % first track of the stereo clip

n = size(y, 1)

power = abs(fft(y));
freqspectrum = linspace(1, Fs, n);
plot(freqspectrum, power);

n = n/2+1;
power = power(1:n);
halfspectrum = linspace(1, Fs/2, n);
plot(halfspectrum, power);
axis([0 1000 0 inf]);

%intervals
i1 = 244:290;
i2 = 290:330;
i3 = 330:430;
i4 = 430:500;

[f1 p1] = top_spike(i1, power)
[f2 p2] = top_spike(i2, power)
[f3 p3] = top_spike(i3, power)
[f4 p4] = top_spike(i4, power)

%% 

%Problem 3:

Img = imread('taeyeon.bmp');
Z = fft2(Img);
P = log(abs(Z));
%normalize:
minval = min(min(P));
maxval = max(max(P));
P = (P - minval)/(maxval-minval);
imshow(P);

Zc = fftshift(Z);
Pc = fftshift(P);
imshow(Pc);

%top band: row 187-10 to 187+10
%bottom center = 250 + (250-187) = 313
%bottom band: row 313-10 to 313+10

for i=177:197
    Zc(i,:) = 0;
    Pc(i,:) = 0;
end;

for i=303:320
    Zc(i,:) = 0;
    Pc(i,:) = 0;
end;
imshow(Pc);

for i=12:32
    Zc(i,:) = 0;
    Pc(i,:) = 0;
end;

for i=469:489
    Zc(i,:) = 0;
    Pc(i,:) = 0;
end;
imshow(Pc);

Znew = ifftshift(Zc);
I = ifft2(Znew);
minval = min(min(I));
maxval = max(max(I));
I = (I - minval)/(maxval-minval);
imshow(I);

imshow(Img); %original taeyeon.bmp
%% 

%Problem 4:
%analyzeimage('eclipse.jpg');
%analyzeimage('shark_attack.jpg');
analyzeimage('racoon.jpg');

%%
%Problem 6:
n = 10000;
values = randgenerator(n);
avg = mean(values)
variance = var(values)

syms x;
f = (x-2)*heaviside(x-2)*heaviside(3-x) + (4-x)*heaviside(x-3)*heaviside(4-x);
cdf = int(f, x)

result = randgenerator(10000);
avg = mean(result)


X = randn(50, 50, 10000);
S = zeros(50, 50, 10000);

for i=1:10000
	[~, S(:, :, i), ~] = svd(X(:, :, i));
end;

avgSVs = mean(S, 3);
plot(1:50, diag(avgSVs));

hist(log(reshape(S(1, 1, :), 1, 10000)), 40);
