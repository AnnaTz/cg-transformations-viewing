function [Y] = triPaintFlat(X,V,C)

%keep pre-existing triangles
Y=X;

%calculate total min and max y-coordinates of the whole triangle
ymin=min(V(:,2));
ymax=max(V(:,2));

%dx->array containing the slopes of the triangle's edges
%initialize slope array 
dx=zeros(1,3);

%calculate each edge's slope
j=3;
for i=1:3 %using i and j, access the triangle's tips pairwise
    if abs(V(i,1)-V(j,1))<1 %x-coordinates almost equal
        dx(i)=0; %vertical edge
    else
        dx(i)=(V(i,1)-V(j,1))/(V(i,2)-V(j,2)); %dx=(x1-x2)/(y1-y2)
    end
    j=i;
end


%initialize active points array
%because the algorithm works for triangles,
%there will be 2 active points/edges for each scan line
points=zeros(1,2);

%calculate the triangle's flat color
color=mean(C); %mean value of tips' colors

%scan background from top to bottom, between the triangles' ymax and ymin
for y=ymax:-1:ymin
    count=0; %initialize active points' counter 
    j=3;
    for i=1:3 %using i and j, access the triangle's tips pairwise
        if(V(i,2)>=y && V(j,2)<y)||(V(i,2)<y && V(j,2)>=y) %scan line is between the y-coordinates of an edge's tips, meaning this is an active edge
            count=count+1; %one more active point has been found
            points(count)=V(i,1)+dx(i)*(y-V(i,2)); %save the active point's x-coordinates, calculated using the edge's equation
        end
        j=i;
    end
    
    points=sort(points); %sort active points in ascending order
    
    
    for i=1:2:count-1
        %floor the active x-coordinates, because most likely they are not integers
        xmin=floor(points(i)); 
        xmax=floor(points(i+1));
        %scan from left to right, between the two active points
        for x=xmin:xmax 
            Y(x,y,:)=color; %assign its color to the background matrix
        end
    end
end

end

