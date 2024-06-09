function dp = systemtrans(cp,b1,b2,b3,c0)

%rotation matrix from old to new coordinate system
R=[b1 b2 b3];

%transpose R
Rt=transpose(R);

%number of points
n=size(cp,1);

%initialize dp
dp=zeros(n,3);

%transform coordinates to new coordinate system
for i=1:1:n
dp(i,:)=Rt*cp(i, :)'-Rt*c0;
end

end

