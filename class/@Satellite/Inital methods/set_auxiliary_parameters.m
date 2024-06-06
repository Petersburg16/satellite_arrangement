function obj=set_auxiliary_parameters(obj,G_0)
% Allow setup auxiliary parameters without defaults.
%
% Parameters：
% G_0: (float,optional)Greenwich sidereal hour angle. Defaults to 0.
%
% Verify Parameters
arguments
    obj
    G_0 (1,1) double = 0
end
obj.G_0=G_0;
end