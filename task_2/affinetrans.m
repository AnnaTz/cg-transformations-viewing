function cq = affinetrans(cp,R,ct)

%number of points
n=size(cp,1);

%initialize cq
cq=zeros(n,3);

%compute affine-transformed coordinates
for i=1:1:n
cq(i,:)=R*cp(i, :)'+ct;
end

end

