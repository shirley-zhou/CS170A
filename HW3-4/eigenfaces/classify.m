function result = classify(filename)

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

[S, V_good avggood] = eigenfaces2(goodfaces, 30, max(size(goodfaces)));

[S, V_evil avgevil] = eigenfaces2(evilfaces, 30, max(size(evilfaces)));

row = 64;
col = 64;
image_vector  = @(Bitmap) double(reshape(Bitmap,row*col,1));
vector_image  = @(Vec) reshape( uint8( min(max(Vec,0),255) ), row, col);
vector_render = @(Vec) imshow(vector_image(Vec));

Face = imread(filename);
F = image_vector(Face)' ;

dist_good = (F - avggood)*(F - avggood)' ;
dist_evil = (F-avgevil)*(F-avgevil)' ;

if dist_evil < dist_good
    result = 1;
else
    result = 0;
end;