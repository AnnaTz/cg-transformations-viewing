function Prast = rasterize(P,M,N,H,W)

%convert coordinates to raster units
%move them so that the system starts from left-down corner
Prast=[P(:,1)*M/H+M/2 P(:,2)*N/W+N/2];

%round them to fit distinct pixels
Prast=round(Prast);

end

