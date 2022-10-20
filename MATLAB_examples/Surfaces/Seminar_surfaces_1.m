clear; clc; close all;

Count = 50;
lnsps = linspace(-1, 1, Count);
plane_X = NaN(Count, Count);
plane_Y = NaN(Count, Count);
plane_Z = NaN(Count, Count);
for i = 1:Count
    for j = 1:Count
        x = lnsps(i);
        y = lnsps(j);
%         z = x + y;
%         z = x^2 + y;
%         z = x^2 + y^2;
%         z = abs(x) + abs(y);
        z = 0.1*cos(10*x) + 0.2*sin(10*y);
        
        plane_X(i, j) = x;
        plane_Y(i, j) = y;
        plane_Z(i, j) = z;
        %disp( mat2str( round([i, j, plane_point'], 2) ))
    end
end

figure()
surf(plane_X, plane_Y, plane_Z, 'FaceAlpha', 1.0);


view(3);
axis equal;