clear; clc; close all;
dx = [9;0;0];
dy = [0;9;0];
dz = [0;0;9];

C1 = sym([0;0;0]);
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
norm(A1P) / norm(B1P)

BB1 = B - B1;
B1C1 = B1 - C1;
n2 = cross(BB1, B1C1);

cos_phi = dot(n, n2) / (norm(n) * norm(n2));
phi = round(double(acos(cos_phi))*180/pi, 3)

round(double( acos(cos_phi) - atan(sqrt(85) / 7) ), 3)