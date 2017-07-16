function results = nearest_ver_last(xb,M,N)
%% inputs
% xb = bayer layer 
% M,N = desired dimensions of the output image
% M = number of rows , N = number of columns
%% outputs
% results = rgb image with M rows and N columns
results = zeros(M,N,3);

%% Additional informations
% according to the inputs , we will create the result by applying nearest algorithm
% in this case , the value of each triad (of output image) is determined by only one other cell of the xb (bayer layer)
% More info about this method (it's really not necessary) can be found in report.pdf

%% indexing preparations
% we set the indexes the way that rule [KA1] (mentioned in report.pdf) describes them .
% In order to avoid exceeding xb dimensions we apply padding to xb
% so the final indexes will be I=I+1 , J = J+1
x = padarray(xb,[1 1],'symmetric','both');


%% Bayer Pattern
% what about if we want to implement another bayer pattern,
% instead of 'grbg' ? we will add some weight to our indexes, 
% like I = I + w(1) , J = J + w(2)
% if w=[0 0] we got a solution for grbg bayer image
% if w=[1 0] we got a solution for bggr bayer image
% if w=[0 1] we got a solution for rggb bayer image
% if w=[1 1] we got a solution for gbrg bayer image
w = [0 0];
wj = w(2);
wi = w(1);

% b_y = Mo/M and b_x = No/N
b_y = size(xb,1)/M;
b_x = size(xb,2)/N;

%% case i<M/2 , j<N/2
% i for y, j for x
% lj = [j_start j_end];
% li = [i_start -i_end];
% case green  - ONLY 
lj = [1 N/2];
li = [1 M/2];
lI = (li-1).*b_y+1;
lJ = (lj-1).*b_x+1;
lI = lI+1+wi;
lJ = lJ+1+wj;

results(li(1):1:li(2),lj(1):1:lj(2),1) = x(lI(1):b_y:lI(2),lJ(1)+1:b_x:lJ(2)+1);
results(li(1):1:li(2),lj(1):1:lj(2),2) = x(lI(1):b_y:lI(2),lJ(1):b_x:lJ(2));
results(li(1):1:li(2),lj(1):1:lj(2),3) = x(lI(1)-1:b_y:lI(2)-1,lJ(1):b_x:lJ(2));

%% case i>M/2 , j<N/2
lj = [1 N/2];
li = [M/2+1 M];
lI = li.*b_y;
lJ = (lj-1).*b_x+1;
lI = lI+1+wi;
lJ = lJ+1+wj;

results(li(1):1:li(2),lj(1):1:lj(2),1) = x(lI(1)-1:b_y:lI(2)-1,lJ(1)-1:b_x:lJ(2)-1);
results(li(1):1:li(2),lj(1):1:lj(2),2) = x(lI(1)-1:b_y:lI(2)-1,lJ(1):b_x:lJ(2));
results(li(1):1:li(2),lj(1):1:lj(2),3) = x(lI(1):b_y:lI(2),lJ(1):b_x:lJ(2));

%% case i<M/2 , j>N/2
lj = [N/2+1 N];
li = [1 M/2];
lI = (li-1).*b_y+1;
lJ = lj.*b_x;
lI = lI+1+wi;
lJ = lJ+1+wj;

results(li(1):1:li(2),lj(1):1:lj(2),1) = x(lI(1):b_y:lI(2),lJ(1):b_x:lJ(2));
results(li(1):1:li(2),lj(1):1:lj(2),2) = x(lI(1)-1:b_y:lI(2)-1,lJ(1):b_x:lJ(2));
results(li(1):1:li(2),lj(1):1:lj(2),3) = x(lI(1)-1:b_y:lI(2)-1,lJ(1)-1:b_x:lJ(2)-1);

%% case i>M/2 , j>N/2
lj = [N/2+1 N];
li = [M/2+1 M];
lI = li.*b_y;
lJ = lj.*b_x;
lI = lI+1+wi;
lJ = lJ+1+wj;

results(li(1):1:li(2),lj(1):1:lj(2),1) = x(lI(1)-1:b_y:lI(2)-1,lJ(1):b_x:lJ(2));
results(li(1):1:li(2),lj(1):1:lj(2),2) = x(lI(1):b_y:lI(2),lJ(1):b_x:lJ(2));
results(li(1):1:li(2),lj(1):1:lj(2),3) = x(lI(1):b_y:lI(2),lJ(1)-1:b_x:lJ(2)-1);

end

