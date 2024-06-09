function I = specularLight(P,N,C,ks,ncoeff,S,I0)

%number of light sources
n=size(S,1);

%normalized vector PC, from point to camera(observer)
V=(C-P)/norm(C-P);
%normalized vector PS, from point to light source
L=(transpose(S)-P*ones(1,n))./(ones(n,1)*norm(transpose(S)-P*ones(1,n)));

nN=N*ones(1,n);
nV=V*ones(1,n);

%Ispecular = I0 * ks * ((2*N*(N dot L)-L) dot V)^ncoeff, for r/g/b
%each column of I corresponds to a light source
I=I0.*(ks*dot(2*nN.*(ones(n,1)*max(dot(nN,L),0))-L,nV).^ncoeff);
%max(dot(nN,L),0) to avoid negative dot(nN,L)

%sum across each row of I
%so now I contains the total specular r/g/b illumination
I=sum(I,2);


end

