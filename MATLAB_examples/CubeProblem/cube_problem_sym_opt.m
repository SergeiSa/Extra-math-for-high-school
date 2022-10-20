clear; clc; close all;
dx = [9;0;0]; dy = [0;9;0]; dz = [0;0;9];

C1 = sym([0;0;0]);
D1 = C1 + dx;
A1 = C1 + dx + dz;
B1 = C1 + dz;
B = C1 + dy + dz;

K = (2/9) * B + (7/9) * B1;

BD1 = B - D1;
KC1 = K - C1;
n = cross(BD1, KC1);

lambda = -dot(B1, n) / dot(dx, n);
P = lambda*dx + B1;
A1P = A1 - P;
B1P = B1 - P;
norm(A1P) / norm(B1P)

m = cross(dy, dz); %cross(BB1, B1C1);

cos_phi = dot(n, m) / (norm(n) * norm(m));
phi = round(double(acos(cos_phi))*180/pi, 3)
round(double( acos(cos_phi) - atan(sqrt(85) / 7) ), 3)