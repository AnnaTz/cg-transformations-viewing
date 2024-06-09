function Im = photographObjectPhong(shader,f,C,K,u,bC,M,N,H,W,R,F,S,ka,kd,ks,ncoeff,Ia,I0)

%calculate normal vectors of all triangle tips
normals=findVertNormals(R,F);

%calculate 2d rasterized coordinates of the triangle tips
[P2d,D] = photographObject(transpose(R),M,N,H,W,f,C,K,u);

%initialize canvas to the given background color
Im=bC(ones(M,N,3));

%total number of triangles
T=size(F,2); 

%intialize array containing each triangle's depth
depth=zeros(1,T); 

%for each triangle
for k=1:1:T
    depth(k)=mean([D(F(1,k)) D(F(2,k)) D(F(3,k))]); %mean value of the triangle's tips' depth
end
[depth,sortIdx]=sort(depth,'descend'); %descending sort of depths
F=F(:,sortIdx); %sort F accordingly, so that each tips triad corresponds to the right depth

%for each triangle
for k=1:1:T 
    Vk=[P2d(F(1,k),:);P2d(F(2,k),:);P2d(F(3,k),:)]; %coordinates of the triangle's tips    
                                                    %each row corresponding to a tip
    Pc=(R(:,F(1,k))+R(:,F(2,k))+R(:,F(3,k)))/3; %coordinates of the triangle's center of gravity
                                                %each column corresponding to a tip
    Vn=[normals(:,F(1,k)) normals(:,F(2,k)) normals(:,F(3,k))]; %normal vectors of the triangle's tips
    tka=[ka(:,F(1,k)) ka(:,F(2,k)) ka(:,F(3,k))]; %ka coefficients of the triangle's tips
    tkd=[kd(:,F(1,k)) kd(:,F(2,k)) kd(:,F(3,k))]; %kd coefficients ---
    tks=[ks(:,F(1,k)) ks(:,F(2,k)) ks(:,F(3,k))]; %ks coefficients ---
    
    if shader == 1 %choose shading function based on the shader flag
        Im=shadeGouraud(Vk,Vn,Pc,C,S,tka,tkd,tks,ncoeff,Ia,I0,Im); %gouraud-shade the triangle 
    elseif shader == 2
        Im=shadePhong(Vk,Vn,Pc,C,S,tka,tkd,tks,ncoeff,Ia,I0,Im); %phong-shade the triangle
    end
end

end



