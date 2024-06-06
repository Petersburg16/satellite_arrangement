function obj=set_auxiliary_parameters(obj,G_0)
% Allow setup auxiliary parameters without defaults.
%
% Parameters：
% G_0: (float,optional)Greenwich sidereal hour angle(degrees). Defaults to 284.507.
%
% Verify Parameters
arguments
    obj
    G_0 (1,1) double = 284.507
end
obj.G_0=G_0;
end