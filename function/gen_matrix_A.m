function A=gen_matrix_A(sat_array,M_bar)
sat_num=length(sat_array);
M_vector=cell(1,sat_num);
A=zeros(sat_num,sat_num);
for i=1:sat_num
    sat_array{i}.M
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