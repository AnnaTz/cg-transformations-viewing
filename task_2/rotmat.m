function R = rotmat(a,u)

ux=u(1);
uy=u(2);
uz=u(3);

%compute rotation matrix 
R=[(1-cos(a))*ux^2+cos(a) (1-cos(a))*ux*uy-sin(a)*uz (1-cos(a))*ux*uz+sin(a)*uy;
   (1-cos(a))*uy*ux+sin(a)*uz (1-cos(a))*uy^2+cos(a) (1-cos(a))*uy*uz-sin(a)*ux;
   (1-cos(a))*uz*ux-sin(a)*uy (1-cos(a))*uz*uy+sin(a)*ux (1-cos(a))*uz^2+cos(a)];

end

