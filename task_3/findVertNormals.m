function Normals = findVertNormals(R,F)

%total number of triangle tips
r=length(R);
%total number of triangles
T=length(F);
%initialize matrix of triangle vertical vectors
%size is 3xT, each column containing the vertical vector of a triangle
trig_norm=zeros(3,T);

%for each ABC triangle
for i=1:1:T
e1=R(:,F(2,i))-R(:,F(1,i)); %AB vector
e2=R(:,F(3,i))-R(:,F(1,i)); %AC vector
trig_norm(:,i)=cross(e1,e2); %AB x AC -> vertical vector of ABC
end

%initialize matrix of triangle tips' normal vectors
%size is 3xr, each column containing the normal vertical vector of a tip
Normals=zeros(3,r);

%for each triangle tip
for i=1:1:r
for_tips=find(any(F==i),1); %find rows of F (aka triangles) that contain tip i and save their indexes
n=length(for_tips); %total number of triangles that contain the tip
for j=1:1:n %calculate the tip's vertical vector
Normals(:,i)=Normals(:,i)+trig_norm(:,for_tips(j))/n; %as the average of the above triangles' vertical vectors 
end
%normalize the tip's vertical vector
Normals(:,i)=Normals(:,i)/norm(Normals(:,i));
end

end

