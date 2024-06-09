function Y = shadePhong(p,Vn,Pc,C,S,ka,kd,ks,ncoeff,Ia,I0,X)

%keep pre-existing triangles
Y=X;

%calculate total min and max y-coordinates of the whole triangle
ymin=min(p(:,2));
ymax=max(p(:,2));

%dx->array containing the slopes of the triangle's edges
%initialize slope array 
dx=zeros(1,3);

%calculate each edge's slope
j=3;
for i=1:3 %using i and j, access the triangle's tips pairwise
    if abs(p(i,1)-p(j,1))<1 %x-coordinates almost equal
        dx(i)=0; %vertical edge
    else
        dx(i)=(p(i,1)-p(j,1))/(p(i,2)-p(j,2)); %dx=(x1-x2)/(y1-y2)
    end
    j=i;
end

%initialize active points array
%because the algorithm works for triangles,
%there will be 2 active points/edges for each scan line
points=zeros(1,2);

%KA->matrix containing the active points' ka coefficients
%KD-> --- kd coefficients
%KS-> --- ks coefficients
%NV->matrix containing the active points' normal vectors
%each column correspoding to an active point
KA=ones(3,2); %initialize
KD=ones(3,2); %---
KS=ones(3,2); %---
NV=ones(3,2); %---

%scan background from top to bottom, between the triangles' ymax and ymin
for y=ymax:-1:ymin
    count=0; %initialize active points' counter 
    j=3;
    for i=1:3 %using i and j, access the triangle's tips pairwise
        if(p(i,2)>=y && p(j,2)<y)||(p(i,2)<y && p(j,2)>=y) %scan line is between the y-coordinates of an edge's tips, meaning this is an active edge
            count=count+1; %one more active point has been found
            points(count)=p(i,1)+dx(i)*(y-p(i,2)); %save the active point's x-coordinates, calculated using the edge's equation
            
            %calculate coefficients and normal vectors based on interpolation
            KA(:,count)=(ka(:,i)*(p(j,2)-y)+ka(:,j)*(y-p(i,2)))/(p(j,2)-p(i,2)); %active point's KA = (ka1*(y2-y)+ka2*(y-y1))/(y2-y1)
                                                                                 %y1,y2->active edge's tips, y->scan line, ka1,ka2->tips' ka coefficients
            KD(:,count)=(kd(:,i)*(p(j,2)-y)+kd(:,j)*(y-p(i,2)))/(p(j,2)-p(i,2)); %active point's KD = (kd1*(y2-y)+kd2*(y-y1))/(y2-y1) likewise
            KS(:,count)=(ks(:,i)*(p(j,2)-y)+ks(:,j)*(y-p(i,2)))/(p(j,2)-p(i,2)); %active point's KS = (ks1*(y2-y)+ks2*(y-y1))/(y2-y1) likewise
            NV(:,count)=(Vn(:,i)*(p(j,2)-y)+Vn(:,j)*(y-p(i,2)))/(p(j,2)-p(i,2)); %active point's NV = (Vn1*(y2-y)+Vn2*(y-y1))/(y2-y1) likewise
        end
        j=i;
    end

    [points,index]=sort(points); %sort active points in ascending order
    KA=KA(:,index); %sort KA accordingly, so that each pair of tips' ka corresponds to the right active edge
    KD=KD(:,index); %sort KD likewise
    KS=KS(:,index); %sort KS ---
    NV=NV(:,index); %sort NV ---
    
    
    for i=1:2:count-1
        %floor the active x-coordinates, because most likely they are not integers
        xmin=floor(points(i)); 
        xmax=floor(points(i+1));
        %scan from left to right, between the two active points
        for x=xmin:xmax 
            if xmax == xmin %case of overlapping active points
                xka=KA(:,1); %running point's ka is the same as active points' ka because they overlap
                xkd=KD(:,1); %likewise for running point's kd
                xks=KS(:,1); %likewise for ks
                xnv=NV(:,1); %likewise for running point's normal vector
            else %linear interpolation across the scan line
                xka=(KA(:,2)*(x-xmin)+KA(:,1)*(xmax-x))/(xmax-xmin); %running point's ka coefficients
                xkd=(KD(:,2)*(x-xmin)+KD(:,1)*(xmax-x))/(xmax-xmin); %---kd---
                xks=(KS(:,2)*(x-xmin)+KS(:,1)*(xmax-x))/(xmax-xmin); %---ks---
                xnv=(NV(:,2)*(x-xmin)+NV(:,1)*(xmax-x))/(xmax-xmin); %running point's normal vector
            end
            Iamb=ambientLight(xka,Ia); %ambient illumination on running point
            Idiff=diffuseLight(Pc,xnv,xkd,S,I0); %diffuse illumination ---
            Ispec=specularLight(Pc,xnv,C,xks,ncoeff,S,I0); %specular illumination ---
            %calculate the running point's total illumination as the sum of the three illumination types
            I=Iamb+Idiff+Ispec;
            Y(x,y,:)=I; %assign its color to the canvas matrix
        end
    end
end

end

