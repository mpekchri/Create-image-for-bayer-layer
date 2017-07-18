function results = nearest_Rule_KA2(xb,M,N)
%% inputs
% xb = bayer layer 
% M,N = desired dimensions of the output image
% M = number of rows , N = number of columns
%% outputs
% results = rgb image with M rows and N columns
Mo = size(xb,1);
No = size(xb,2);
results = zeros(Mo,No,3);

%% Additional informations
% according to the inputs , we will create the result by applying nearest algorithm
% in this case , the value of each triad (of output image) is determined by only one other cell of the xb (bayer layer)
% More info about this method (it's really not necessary) can be found in report.pdf

%% indexing preparations
% we set the indexes the way that rule [KA2] (mentioned in nearest_Rule-KA2.pdf) describes them .
% In order to avoid exceeding xb dimensions we apply padding to xb
% so the final indexes will be I=I+1 , J = J+1
xb = padarray(xb,[1 1],'symmetric','both');

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


%% case green - case g1
lj = [1 No-1];
li = [1 Mo-1];
lj = lj+1+wj;
li = li+1+wi;

results(li(1):2:li(2),lj(1):2:lj(2),1) = xb(li(1):2:li(2),lj(1)+1:2:lj(2)+1);%red
results(li(1):2:li(2),lj(1):2:lj(2),2) = xb(li(1):2:li(2),lj(1):2:lj(2)); %green
results(li(1):2:li(2),lj(1):2:lj(2),3) = xb(li(1)+1:2:li(2)+1,lj(1):2:lj(2)); %blue

%% case red
lj = [2 No];
li = [1 Mo-1];
lj = lj+1+wj;
li = li+1+wi;
results(li(1):2:li(2),lj(1):2:lj(2),1) = xb(li(1):2:li(2),lj(1):2:lj(2)); %red
results(li(1):2:li(2),lj(1):2:lj(2),2) = xb(li(1)+1:2:li(2)+1,lj(1):2:lj(2));
results(li(1):2:li(2),lj(1):2:lj(2),3) = xb(li(1)+1:2:li(2)+1,lj(1)-1:2:lj(2)-1);

%% case blue
lj = [1 No-1];
li = [2 Mo];
lj = lj+1+wj;
li = li+1+wi;
results(li(1):2:li(2),lj(1):2:lj(2),1) = xb(li(1)+1:2:li(2)+1,lj(1)+1:2:lj(2)+1); %red
results(li(1):2:li(2),lj(1):2:lj(2),2) = xb(li(1)+1:2:li(2)+1,lj(1):2:lj(2));
results(li(1):2:li(2),lj(1):2:lj(2),3) = xb(li(1):2:li(2),lj(1):2:lj(2));

%% case green -case g2
lj = [2 No];
li = [2 Mo];
lj = lj+1+wj;
li = li+1+wi;
results(li(1):2:li(2),lj(1):2:lj(2),1) = xb(li(1)+1:2:li(2)+1,lj(1):2:lj(2)); %red
results(li(1):2:li(2),lj(1):2:lj(2),2) = xb(li(1):2:li(2),lj(1):2:lj(2));
results(li(1):2:li(2),lj(1):2:lj(2),3) = xb(li(1):2:li(2),lj(1)-1:2:lj(2)-1);


% b_y = Mo/M and b_x = No/N
if(M>Mo)
	b_y = M/Mo;
else
	b_y = Mo/M;
end
if(N>No)
	b_x = N/No;
else
	b_x = No/N;
end

%% compute sampling grid according to desired dimensions
% no need for these computations if Mo == M %% No == N
if(Mo ~= M || No ~= N)
    temp = results;
    results = zeros(M,N,3);
    grid_y = linspace(1,Mo,M);
    grid_x = linspace(1,No,N);
    grid_y = floor(grid_y);
    grid_x = floor(grid_x);
    for i=1:b_y:M
        for j=1:b_x:N
            results(i:i+b_y,j:j+b_x,1) = temp(grid_y(i),grid_x(j),1);
            results(i:i+b_y,j:j+b_x,2) = temp(grid_y(i),grid_x(j),2);
            results(i:i+b_y,j:j+b_x,3) = temp(grid_y(i),grid_x(j),3);
        end
    end
end


end
