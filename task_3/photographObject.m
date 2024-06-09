function [P2d,D] = photographObject(p,M,N,H,W,w,cv,ck,cu)

%compute 2d projected coordinates
[P,D]=projectKu(w,cv,ck,cu,p);

%adjust coordinates to raster
P2d=rasterize(P,M,N,H,W);


end
