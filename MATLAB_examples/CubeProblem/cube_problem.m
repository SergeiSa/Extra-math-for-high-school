clear; clc; close all;
dx = [9;0;0];
dy = [0;9;0];
dz = [0;0;9];

C1 = [0;0;0];
D1 = C1 + dx;
A1 = C1 + dx + dz;
B1 = C1 + dz;

C = C1 + dy;
D = C + dx;
A = C + dx + dz;
B = C + dz;

K = (2/9) * B + (7/9) * B1;

BD1 = B - D1;
KC1 = K - C1;

n = cross(BD1, KC1);

A1B1 = A1 - B1;
lambda = -dot(B1, n) / dot(A1B1, n);
P = lambda*A1B1 + B1;

A1P = A1 - P;
B1P = B1 - P;
disp(mat2str(round(  norm(A1P) / norm(B1P), 2    )))

BB1 = B - B1;
B1C1 = B1 - C1;
n2 = cross(BB1, B1C1);

cos_phi = dot(n, n2) / (norm(n) * norm(n2));
phi = acos(cos_phi) * 180/pi

round( acos(cos_phi) - atan(sqrt(85) / 7), 3   )


T = null(n');
Cube      = [A1, B1, C1, D1, A, B, C, D];
VertNames = {'A1', 'B1', 'C1', 'D1', 'A', 'B', 'C', 'D'};
Faces = [1, 2, 3, 4; 5, 6, 7, 8; 1, 5, 8, 4; 2, 6, 5, 1; 3, 7, 6, 2; 4, 8, 7, 3];

Count = 20;
lnsps = linspace(-9, 9, Count);
plane_X = NaN(Count, Count);
plane_Y = NaN(Count, Count);
plane_Z = NaN(Count, Count);
for i = 1:Count
    for j = 1:Count
        plane_point = T(:, 1)*lnsps(j) + T(:, 2)*lnsps(i);
        plane_X(i, j) = plane_point(1);
        plane_Y(i, j) = plane_point(2);
        plane_Z(i, j) = plane_point(3);
        %disp( mat2str( round([i, j, plane_point'], 2) ))
    end
end

surf(plane_X, plane_Y, plane_Z, 'FaceAlpha', 0.2, 'FaceColor', 'y');

cube_handle = patch('Faces',Faces,'Vertices',Cube'); hold on;
cube_handle.FaceAlpha = 0.2;
cube_handle.FaceColor = [1, 0, 0];

plot3(K(1), K(2), K(3), 'o', 'MarkerFaceColor', 'b')
plot3(P(1), P(2), P(3), 'o', 'MarkerFaceColor', 'g')
plot3([B(1), D1(1)], [B(2), D1(2)], [B(3), D1(3)], 'k', 'LineWidth', 2)

for i = 1:8
    text(Cube(1, i), Cube(2, i), Cube(3, i), VertNames(i));
end
text(K(1), K(2), K(3), 'K');
text(P(1), P(2), P(3), 'P');
    
view(3);
axis equal;