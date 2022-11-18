clc; clear; close all;
rotz = @(gamma) [cos(gamma) -sin(gamma) 0; sin(gamma) cos(gamma) 0; 0 0 1];

G = 6.673 * 10^(-11);
M = 5.972 * 10^24;
radius = 6371000;
ISS_height = 437*10^3;
ISS_velocity = 7654;
ISS_time = 90*60;
ISS_mass = 420000;

Oz = [0;0;1];

North = -43.07 *pi/180;
East = -61.50  *pi/180;
% North = 0 *pi/180;
% East = 167.39  *pi/180;
% 43.07° South
% 61.50° West

init_pos = [cos(North)*cos(East); 
            cos(North)*sin(East); 
            sin(North)];
     
orbit_norm = get_orbit_n(init_pos, false);
tau = cross(orbit_norm, init_pos) + 0.5*orbit_norm;

r0 = init_pos*(radius + ISS_height);
v0 = tau * ISS_velocity;

tspan = linspace(0, 3*ISS_time, 10^5);
x0 = [r0; v0];
odefun = @(t, x) [x(4:6); -G*M*x(1:3) / ((norm(x(1:3)))^3)];
% f = G*M*r / ((norm(r))^3);

opts = odeset('Reltol',1e-13,'AbsTol',1e-14,'Stats','on');

% [t, x] = ode45(odefun,tspan,x0, opts);
[t, x] = ode45(odefun,tspan,x0);
trajectory = x(:, 1:3);
velocity = x(:, 4:6);

trajectory_corrected = zeros(size(trajectory));
kinetic_enegry   = zeros(size(trajectory, 1), 1);
potential_enegry = zeros(size(trajectory, 1), 1);
for i = 1:length(t)
    current_time = t(i);
    angle_Erth_rotation = -2*pi * current_time/(24*60*60);
    current_point = trajectory(i, :)';
    current_point_corrected = rotz(angle_Erth_rotation)*current_point;
    trajectory_corrected(i, :) = current_point_corrected;
    
    kinetic_enegry(i) = 0.5*ISS_mass * dot(velocity(i, :), velocity(i, :));
    potential_enegry(i) = -G*M*ISS_mass / norm(current_point);
end
total_energy = potential_enegry+kinetic_enegry;


figure('Color', 'w')
subplot(2, 2, 1)
plot(t, kinetic_enegry, 'r'); hold on;
plot(t, potential_enegry, 'b'); hold on;
plot(t, total_energy, 'k'); hold on;
legend("kinetic", "potential", "total")
title([ 'change in total energy: ', num2str(total_energy(end) - total_energy(1)) ])
subplot(2, 2, 3)
plot(t, x(:, 4:6))

subplot(2, 2, [2, 4])
plot3(trajectory_corrected(:, 1), trajectory_corrected(:, 2), trajectory_corrected(:, 3), ...
    'r', 'LineWidth', 1.5); hold on;
plot3(0, 0, 0, 'o', 'MarkerFaceColor', 'r')
plot3(x(1, 1), x(1, 2), x(1, 3), 'o', 'MarkerFaceColor', 'k')
grid on;

earth_sphere(50,'m') 




function orbit_norm = get_orbit_n(r, solution_one)

phi = 51.6 * pi / 180;

p1 =            -r(2)/r(1);
p2 = -cos(phi) * r(3)/r(1);

a = p1^2 + 1;
b = 2*p1*p2;
c = p2^2 - sin(phi)*sin(phi);

y1 = ( -b + sqrt(b^2 - 4*a*c) )/(2*a);
y2 = ( -b - sqrt(b^2 - 4*a*c) )/(2*a);

x1 = p1*y1 + p2;
x2 = p1*y2 + p2;

z = cos(phi);

n1 = [x1; y1; z];
n2 = [x2; y2; z];

if solution_one
    orbit_norm = n1;
else
    orbit_norm = n2;
end

end