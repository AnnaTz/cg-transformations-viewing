function I = diffuseLight(P,N,kd,S,I0)

%number of light sources
n=size(S,1);

%normalized vector PS, from point to light source
L=(transpose(S)-P*ones(1,n))./(ones(n,1)*norm(transpose(S)-P*ones(1,n)));

%Idiffuse = I0 * kd * (N dot L), for r/g/b
%each column of I corresponds to a light source
I=I0.*(kd*max(dot(N*ones(1,n),L),0));
%max(dot(N*ones(1,n),L),0) to avoid negative dot(N*ones(1,n),L)

%sum across each row of I
%so now I contains the total diffuse r/g/b illumination
I=sum(I,2);

end