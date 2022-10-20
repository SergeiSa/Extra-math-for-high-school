clear; clc; close all;

A = [sqrt(2)/2,  sqrt(2)/2;
     -sqrt(2)/2, sqrt(2)/2] * ...
    [2, 0;
     0, 1];
 
%   xf = 2x+y
%   yf = y

Count = 130;
lnsps = linspace(0, 2*pi, Count);

circ = NaN(2, Count);
for i = 1:Count
    phi = lnsps(i);
    circ(1, i) = cos(phi);
    circ(2, i) = sin(phi);
end

circA = A*circ;

figure();

for i = 1:Count
    
    Red = [1, 0, 0];
    Green = [0, 0.5, 0];
    
    mycolor = Red * (i-1) / Count + Green * (Count - i + 1) / Count;
    
plot(circ(1, i), circ(2, i), 'o', 'MarkerFaceColor', mycolor, 'MarkerEdgeColor', mycolor); hold on;
plot(circA(1, i), circA(2, i), 'o', 'MarkerFaceColor', mycolor, 'MarkerEdgeColor', mycolor); hold on;

plot([circ(1, i), circA(1, i)], [circ(2, i), circA(2, i)], ...
    'k', 'LineWidth', 0.5); hold on;


end
axis equal;












