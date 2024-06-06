function sat_group=gen_sat_group(sat_array,iftrim,M_bar)
% Generate matrix sat_group based on sat_array.
%
% Parameters:
% sat_array: (cell array) An array for storing satellites.
% M_bar: (double) Angle threshold to determine if a satellite is nearby (degrees). Defaults to 20.
%
arguments
    sat_array cell
    iftrim logical =true
    M_bar (1,1)double =20
end
sat_num=length(sat_array);
M_array=zeros(1,sat_num);
group_flag=1;
sat_group=zeros(1,sat_num*2);
for i=1:sat_num
    M_array(i)=[sat_array{i}.M];
end

[M_array, M_index] = sort(M_array);

M_vector=cell(1,sat_num);
for i=1:sat_num
    M_vector{i}=[cos(deg2rad(M_array(i))),sin(deg2rad(M_array(i)))];
end

M_vector=[M_vector,M_vector,M_vector];
for i=sat_num+1:sat_num*2
    angle_M0=abs(acos(dot(M_vector{i},M_vector{i-1})));
    angle_M1=abs(acos(dot(M_vector{i},M_vector{i+1})));
    if angle_M0<deg2rad(M_bar)
        % 和前一颗卫星距离小于M_bar,置1
        sat_group(group_flag,i)=1;
    else
        % 和前一颗卫星距离大于M_bar,换行，检测和后一颗卫星的距离
        group_flag=1+group_flag;
        if angle_M1<deg2rad(M_bar)
            sat_group(group_flag,i)=1;
        end
    end
end
sat_group=sat_group(:,sat_num+1:sat_num*2);
if sat_group(1,1)~=0
sat_group(1,:) = sat_group(1,:) + sat_group(end,:);
sat_group(end,:) = [];
end


trim_flag=1;
if iftrim
    for i=1:size(sat_group,1)
        group=sat_group(i,:);
        if sum(group)==0
            continue
        else
            group=group(M_index);
            sat_group_temp(trim_flag,:)=group;
            trim_flag=trim_flag+1;
        end
    end
else
    for i=1:size(sat_group,1)
        group=sat_group(i,:);
        group=group(M_index);
        sat_group_temp(i,:)=group;
    end
end
sat_group=sat_group_temp;
end