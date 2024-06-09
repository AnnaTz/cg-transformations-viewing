clc
clear

%% Load data %%
data=load('hw2');
cv=data.cv;
ck=data.ck;
cu=data.cu;
M=data.M;
N=data.N;
H=data.H;
W=data.W;
w=data.w;
V=data.V;
F=data.F;
C=data.C;
t1=data.t1;
g=data.g;
theta=data.theta;
K=data.K;
t2=data.t2;

%convert inches to cm
H=H/0.39370;
W=W/0.39370;

%% Initial position 
% TODO Photograph object with photographObject
[P2d,D] = photographObject(V,M,N,H,W,w,cv,ck,cu);
% TODO Paint object with ObjectPainter with gouraud
I0 = paintObject(P2d,F,C,D,'Gouraud');
% Save result
imwrite(I0, '0.jpg');


%% Step 1 - Translate by t1
% TODO Apply translation
R=eye(3);
V1 = affinetrans(V,R,t1);
% TODO Photograph object with photographObject
[P2d,D] = photographObject(V1,M,N,H,W,w,cv,ck,cu);
% TODO Paint object with ObjectPainter with gouraud
I1 = paintObject(P2d,F,C,D,'Gouraud');
% Save result
imwrite(I1, '1.jpg');

%% Step 2 - Rotate by theta around given axis
% TODO Apply rotation
R = rotmat(theta,g);
t=zeros(3,1);
V2 = affinetrans(V1,R,t);
% TODO Photograph object with photographObject
[P2d,D] = photographObject(V2,M,N,H,W,w,cv,ck,cu);
% TODO Paint object with ObjectPainter with gouraud
I2 = paintObject(P2d,F,C,D,'Gouraud');
% Save result
imwrite(I2, '2.jpg');

%% Step 3 - Translate back
% TODO Apply translation
R=eye(3);
V3 = affinetrans(V2,R,t2);
% TODO Photograph object with photographObject
[P2d,D] = photographObject(V3,M,N,H,W,w,cv,ck,cu);
% TODO Paint object with ObjectPainter with gouraud
I3 = paintObject(P2d,F,C,D,'Gouraud');
% Save result
imwrite(I3, '3.jpg');
