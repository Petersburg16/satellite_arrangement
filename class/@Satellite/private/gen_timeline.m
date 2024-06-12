function obj = gen_timeline(obj)
% Generate a timeline for simulation
%
% Returns:
% t: （row vector)timeline for simulation.

T = obj.days*24*60*60; % totlal times of simulation (s)
tmax = T/obj.h; % time index

t=linspace(0,(tmax-1)*obj.h,tmax);
obj.t=t;
end