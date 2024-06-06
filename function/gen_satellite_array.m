function sat_array=gen_satellite_array(sat_num,ifsort)
arguments
    sat_num (1,1)double
    ifsort (1,1) logical = true
end

if ifsort
    phase_index =sort( 360 * rand(1, sat_num));
    sat_array=cell(1, sat_num);
else
    phase_index =360 * rand(1, sat_num);
    sat_array=cell(1, sat_num);
end

for i=1:sat_num
    sat_array{i}=Satellite(phase_index(i));
end
end

function A=gen_matrix_A(sat_array,M_bar)
arguments
    sat_array cell
    M_bar (1,1)double =20;
end

end