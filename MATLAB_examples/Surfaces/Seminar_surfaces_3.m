clear; clc; close all;

%x^2 + y^2 + z^2 = r^2

%z = +\- sqrt(r^2 - x^2 - y^2)

Count = 20;
lnsps = linspace(0, 2*pi, Count);
plane_X = NaN(Count, Count);
plane_Y = NaN(Count, Count);
plane_Z = NaN(Count, Count);
for i = 1:Count
    for j = 1:Count
        phi   = lnsps(i);
        theta = lnsps(j);
        
        x = cos(phi)*cos(theta);
        y = sin(phi)*cos(theta);
        z = sin(theta);
        
        plane_X(i, j) = x;
        plane_Y(i, j) = y;
        plane_Z(i, j) = z;
        %disp( mat2str( round([i, j, plane_point'], 2) ))
    end
end

figure()
surf(plane_X, plane_Y, plane_Z, 'FaceAlpha', 1.0, 'EdgeAlpha', 0.3, 'FaceColor', 'r');

view(3);
axis equal;

T = [1, 0, 0;
     0, 2, 1;
     1, 1, 1];
 
s = sqrt(2) / 2;

T = [1, 0, 0;
     0, s, s;
     0, -s, s] * ...
     [1, 0, 0;
     0, 2, 0;
     0, 0, 1];
 
 
Vert = [vec(plane_X), vec(plane_Y), vec(plane_Z)]'; 
Vert = T*Vert;

plane_X_new = reshape(Vert(1, :), size(plane_X));
plane_Y_new = reshape(Vert(2, :), size(plane_Y));
plane_Z_new = reshape(Vert(3, :), size(plane_Z));

figure()
surf(plane_X_new, plane_Y_new, plane_Z_new, 'FaceAlpha', 1.0, 'EdgeAlpha', 0.3, 'FaceColor', 'g');

view(3);
axis equal;

