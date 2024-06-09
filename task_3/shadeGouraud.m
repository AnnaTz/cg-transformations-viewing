function Y = shadeGouraud(p,Vn,Pc,C,S,ka,kd,ks,ncoeff,Ia,I0,X)

%initialize matrices of ambient, diffuse and specular illumination
%size is 3x3, each row corresponding to a triangle tip, each column to a wavelength
Iamb=zeros(3,3);
Idiff=zeros(3,3);
Ispec=zeros(3,3);

%calculate the three types of illumination for each tip
for i=1:1:3
Iamb(i,:)=ambientLight(ka(:,i),Ia);
Idiff(i,:)=diffuseLight(Pc,Vn(:,i),kd(:,i),S,I0);
Ispec(i,:)=specularLight(Pc,Vn(:,i),C,ks(:,i),ncoeff,S,I0);
end

%calculate total illumination as the sum of the three types 
I=Iamb+Idiff+Ispec;

%pass the canvas, the tips' coordinates and the calculated illumination to the coloring function
Y=triPaintGouraud(X,p,I);

end
