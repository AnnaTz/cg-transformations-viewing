function [color] = colorInterp(A,B,a,b,x)
%A,B-> colors of active points
%a,b-> x-coordinates of active points
%x-> x-coordinate of the running point
color=(B*(x-a)+A*(b-x))/(b-a); %linear interpolation across the scan line
end

