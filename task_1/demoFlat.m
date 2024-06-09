%load data from .mat file
data=load('duck_hw1');
F=data.F;
C=data.C;
V=data.V_2d;
D=data.D;

%call painObject requesting flat coloring
I=paintObject(V,F,C,D,"Flat");

%rotate image to normal
I=imrotate(I,-90);

%save image
imshow(I,'InitialMagnification',50);
imwrite(I,'duck_flat.bmp');