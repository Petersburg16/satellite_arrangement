function sat_array=gen_satellite_array_by_index(sat_index)
% Generate a array of satellite.
% 
% Parameters:
% sat_num: (int) Amount of satellits.
% ifsort: (bool,optional) Sort satellits or not. Defaults to true.
% 
% Return:
% sat_array: (cell) An array for storing satellites.
%
% Verify Parameters
arguments
    sat_index double
end
sat_num=length(sat_index);
% Generate sat_array
for i=1:sat_num
    sat_array{i}=Satellite(sat_index(i));
end
end

