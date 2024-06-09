function [I] = paintObject(V,F,C,D,painter)

%initialize background
M=1200;
N=1200;
I=ones(M,N,3); %white color

K=size(F,1); %how many triangles

%intialize array containing each triangle's depth
depth=zeros(1,K); 

for k=1:1:K
    depth(k)=mean([D(F(k,1)) D(F(k,2)) D(F(k,3))]); %mean value of the triangle's tips' depth
end
[depth,sortIdx]=sort(depth,'descend'); %descending sort of depths
F=F(sortIdx,:); %sort F accordingly, so that each tips triad corresponds to the right depth

for k=1:1:K %access each triangle
    Vk=[V(F(k,1),:);V(F(k,2),:);V(F(k,3),:)]; %coordinates of the triangle's tips
    Ck=[C(F(k,1),:);C(F(k,2),:);C(F(k,3),:)]; %colors of the triangle's tips
    if painter == "Gouraud" %based on the function input
        I=triPaintGouraud(I,Vk,Ck); %gouraud-color the triangle 
    else
        I=triPaintFlat(I,Vk,Ck); %flat-color the triangle
    end
end
end

