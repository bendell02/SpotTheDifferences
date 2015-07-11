function [r_i,r_j] = im_register2(AA_s,BB_s,m_t)
% IM_REGISTER2 ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 13-Mar-2015 18:29:21 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : im_register2.m 

%% 设定可移动范围，此处采用了手动指定，也可设成图像长度、宽度的十分之一
m_r = m_t;
m_c = m_t;

%% 平移计算。计算重叠区域的两幅图像；作差
s = size(AA_s);                             %同维度化后图像的尺寸
z_s = zeros(2*m_r+1,2*m_c+1);               %z_s用于后面统计平移后图像重合元素的个数

for i = -m_r:m_r
    for j = -m_c:m_c
        
        ra1 = max(i,1); ra2 = min(s(1),s(1)+i); %计算平移后重叠图像的行列坐标
        ca1 = max(j,1); ca2 = min(s(2),s(2)+j);
        
        rb1 = max(1,-i+1); rb2 = min(s(1)-i+1,s(1));
        cb1 = max(1,-j+1); cb2 = min(s(2)-j+1,s(2));
        
        temp_AA = AA_s(ra1:ra2,ca1:ca2,:);      %获取重叠后的图像
        temp_BB = BB_s(rb1:rb2,cb1:cb2,:);
        temp_AA = double(temp_AA);
        temp_BB = double(temp_BB);
        
        diff_AB = temp_AA - temp_BB;            %作差并统计重叠元素个数
        diff_AB = abs(diff_AB);
        diff_AB = sum(diff_AB,3);
%         mesh(diff_AB);
        diff_AB = logical(diff_AB);
        diff_AB = ~diff_AB;
%         mesh(double(diff_AB));
        temp = sum(diff_AB(:));
        
        m = i+m_r+1;
        n = j+m_c+1;
        z_s(m,n) = temp;
    end
end

%% 求出最佳匹配 位置时的位移，并计算出此时重叠区域的两幅图像
[rows,cols]=find(z_s==max(z_s(:)));

r_i = rows - (m_r+1);  r_j = cols - (m_c+1);

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [im_register2.m] ======  
