function results = nearest_Rule_KA1(xb,M,N)
%% inputs
% xb = bayer layer 
% M,N = desired dimensions of the output image
% M = number of rows , N = number of columns
%% outputs
% results = rgb image with M rows and N columns
results = zeros(M,N,3);

%% indexing according to rule_KA1
% indexes will be like : 
% I = ((i-1)+1/2)*(size(xb,1)/M);
% J = ((j-1)+1/2)*(size(xb,2)/N);
b_y = size(xb,1)/M;
b_x = size(xb,2)/N;
w = [0 0];

%% padding in order to avoid (0,0) cell etc...
% we should now "transpose" our coordinates according to : i+1 ,j+0
x = padarray(xb,[2 2],'symmetric','both');

%% Bayer Pattern
% in this soluction we assume that our bayer image pattern is rggb
% actually we create the matlab function demosaic with input 'rggb'
% Just for demonstrating reasons i will add some variables,that will give us
% the oportunity to result demosaic output when given strign is 'gbrg' or
% ...

% in order to run function in mode rggb : wi = 1 , wj = 0
% in order to run function in mode gbrg : wi = 0 , wj = 1
% in order to run function in mode grbg : wi = 1 , wj = 1
% in order to run function in mode bggr : wi = 0 , wj = 0
% grbg select
wj = 1;
wi = 1;

%% general case
% i for y, j for x
% lj = [j_start j_end];
% li = [i_start -i_end];

% case blue
lj = [2 N];
li = [2 M];
lI = (li -1/2+w(1))*b_y+1+wi;
lJ = (lj - 1/2+w(1))*b_x+1+wj;

results(li(1):1:li(2),lj(1):1:lj(2),1) = x(lI(1)+1:b_y:lI(2)+1,lJ(1)-1:b_x:lJ(2)-1) ;%red;
results(li(1):1:li(2),lj(1):1:lj(2),2) = x(lI(1)+1:b_y:lI(2)+1,lJ(1):b_x:lJ(2)); %green
results(li(1):1:li(2),lj(1):1:lj(2),3) = x(lI(1):b_y:lI(2),lJ(1):b_x:lJ(2)); %blue

%case red
lj = [1 N-1];
li = [1 M-1];
lI = (li -1/2-w(1))*b_y+1+wi;
lJ = (lj - 1/2-w(1))*b_x+1+wj;

results(li(1):1:li(2),lj(1):1:lj(2),1) = x(lI(1):b_y:lI(2),lJ(1):b_x:lJ(2));%red;
results(li(1):1:li(2),lj(1):1:lj(2),2) = x(lI(1)+1:b_y:lI(2)+1,lJ(1):b_x:lJ(2)); %green
results(li(1):1:li(2),lj(1):1:lj(2),3) = x(lI(1)+1:b_y:lI(2)+1,lJ(1)+1:b_x:lJ(2)+1); %blue

%case green
%(case green 1: i=2:2:M-2,j=3:2:N-1)
lj = [1 N-1];
li = [2 M];
lI = (li -1/2+w(1))*b_y+1+wi;
lJ = (lj - 1/2+w(1))*b_x+1+wj;

results(li(1):1:li(2),lj(1):1:lj(2),1) = x(lI(1)+1:b_y:lI(2)+1,lJ(1):b_x:lJ(2));%red;
results(li(1):1:li(2),lj(1):1:lj(2),2) = x(lI(1):b_y:lI(2),lJ(1):b_x:lJ(2));  %green
results(li(1):1:li(2),lj(1):1:lj(2),3) = x(lI(1):b_y:lI(2),lJ(1)-1:b_x:lJ(2)-1); %blue

%(case green 2: i=3:2:M-1,j=2:2:N-2)
lj = [2 N];
li = [1 M-1];
lI = (li -1/2+w(1))*b_y+1+wi;
lJ = (lj - 1/2+w(1))*b_x+1+wj;

results(li(1):1:li(2),lj(1):1:lj(2),1) = x(lI(1):b_y:lI(2),lJ(1):b_x:lJ(2));%red
results(li(1):1:li(2),lj(1):1:lj(2),2) = x(lI(1):b_y:lI(2),lJ(1)-1:b_x:lJ(2)-1); %green
results(li(1):1:li(2),lj(1):1:lj(2),3) = x(lI(1)+1:b_y:lI(2)+1,lJ(1):b_x:lJ(2));%blue

end

