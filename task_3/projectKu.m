function [P,D] = projectKu(w,cv,ck,cu,p)

%compute z-axes of CCS
%zc=cv-ck;
zc=-cv+ck;
zc=zc/norm(zc);

%compute y-axes of CCS
t=cu-dot(cu,zc)*zc;
yc=t/norm(t);

%compute x-axes of CCS
xc=cross(yc,zc);

%compute 2d CCS coordinates P and depth D
[P,D] = projectCamera(w,cv,xc,yc,p);

end

