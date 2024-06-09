function [P,D] = projectCamera(w,cv,cx,cy,p)

%compute z-axes of CCS
cz=cross(cx,cy);

%compute transformed to CCS coordinates
dp = systemtrans(p,cx,cy,cz,cv);

%compute depth of points
D = dp(:,3)*w;

%compute 2d coordinates on CCS projection plane 
P=w*[dp(:,1)./dp(:,3) dp(:,2)./dp(:,3)];

end

