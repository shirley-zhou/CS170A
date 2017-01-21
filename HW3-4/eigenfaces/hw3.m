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
for i=1:s
    for j=i+1:s
        if C_good(i,:) == C_good(j,:)
            duplicates = [duplicates; i j];
        end;
    end;
end;

duplicates = [];
s = size(C, 1);
for i=1:s
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
audiofile = 'tune.mp3';
[tune, Fs] = audioread(audiofile);
y = tune(:,1); % first track of the stereo clip
%% 

