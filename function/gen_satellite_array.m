function sat_array=gen_satellite_array(sat_num,ifsort)
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
    sat_num (1,1) int8
    ifsort (1,1) logical = true
end

% Generate phase_index
if ifsort
    phase_index =sort( 360 * rand(1, sat_num));
    sat_array=cell(1, sat_num);
else
    phase_index =360 * rand(1, sat_num);
    sat_array=cell(1, sat_num);
end

% Generate sat_array
for i=1:sat_num
    sat_array{i}=Satellite(phase_index(i));
end
end

