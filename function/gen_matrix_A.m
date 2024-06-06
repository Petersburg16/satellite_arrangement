function A=gen_matrix_A(sat_array,M_bar)
% Generate matrix A based on sat_array.  
%   
% Parameters:  
% sat_array: (cell array) An array for storing satellites.  
% M_bar: (double) Angle threshold to determine if a satellite is nearby (degrees). Defaults to 20.  
%   
% Returns:  
% A: (matrix) If satellite i is nearby satellite j, A(i,j) will be set to 1.  
%  
% Verify Parameters
arguments
    sat_array cell
    M_bar (1,1)double =20;
end
sat_num=length(sat_array);
M_vector=cell(1,sat_num);
A=zeros(sat_num,sat_num);
for i=1:sat_num
    M_vector{i}=[cos(deg2rad(sat_array{i}.M)),sin(deg2rad(sat_array{i}.M))];
end

for i=1:sat_num
    for j=1:sat_num
        if i==j
            A(i,j)=0;
        else
            angle_M=abs(acos(dot(M_vector{i},M_vector{j})));
            if angle_M<deg2rad(M_bar)
                A(i,j)=1;
            end
        end
    end
end
end