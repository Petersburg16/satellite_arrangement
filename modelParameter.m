N = 19;   % total number of agents
rho_bar = 10; % observation range of satellite, geocentric angle (deg)
% days = 1; %  totlal days of simulation
% T = days*24*60*60; % totlal times of simulation (s)
% h = 60; % Discrete interval (s)
% tmax = T/h; % time index

% %orbital six elements
% a = 6939.76*10e3; % semi-major axis (m)
% e = 0; % eccentricity
% i = 98; % orbital inclination (deg)
% Omega = 284.507; % right ascension of ascending node (deg)
% omega = 0; % argument of perigee (deg)
% M = zeros(tmax,N);% row index: time (s); column index: agents

%deg to rad
i = deg2rad(i);
Omega = deg2rad(Omega);
omega = deg2rad(omega);

for k = 1:N
    M(1,k) = 0 + (k-1)*pi/180*18; % initial phase 
end
