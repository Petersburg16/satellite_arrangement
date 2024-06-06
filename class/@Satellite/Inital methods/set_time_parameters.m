function obj=set_time_parameters(obj,days,h)
% Allow setup time parameters without defaults.
%
% Parameters：
% days: (float,optional)total days of simulation. Defaults to 1.
% h: (float,optional)Discrete interval (s). Defaults to 30.
%
% Verify Parameters
arguments
    obj
    days (1,1) double = 1
    h (1,1) double = 30
end
obj.days=days;
obj.h=h;
end