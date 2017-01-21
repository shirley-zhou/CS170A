%% Removing noise using FFT.

img = imread( 'taeyeon.jpg' );

T = mean(double(img), 3);   % T = rgb2gray( img );

[m, n] = size( T );
midM = floor( m/2 );
midN = floor( n/2 );

figure;
imshow( T );    % imshow( uint8(T) );
title( 'Original image' );

%% Computing the FFT2 of the image (two-sided FFT, applying F to both sides of the image matrix).

Z = fft2( T );
P = log( abs( Z ) );

% Move the origin of the transform to the center of the frequency rectangle.

Z_c = fftshift( Z );
P_c = fftshift( P );

figure;
imshow( P_c, [] );
title( '(Shifted) Log of the absolute-valued power spectrum' );


%% ...........


%% Reconstruct original image.
% 
% T2 = ifft2( .... );           % Inverse of Fourier transform of the image.
% 
% figure;
% imshow( real(T2), [] );
% title( 'Reconstructed image' );
% 
