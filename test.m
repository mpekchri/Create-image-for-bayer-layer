%% load file in memory
l = load('bayerLayer.mat');
xb = l.x;                       % xb = our bayer layer
[M,N] = size(xb);               % desired output dimensions equal to xb's dimensions

%% use nearest method as sampling method and show image
im = nearest_Rule_KA1(xb,M,N);
figure
imshow(im)
title('rule KA1 , rgb dimensions == bayer layer dimensions')

%% use nearest method as sampling method and show image
M = 2*M;
N = 2*N;                        % desired output dimensions > xb's dimensions
im = nearest_Rule_KA2(xb,M,N);
figure
imshow(im)
title('rule KA2 , rgb dimensions == 2 * bayer layer dimensions')