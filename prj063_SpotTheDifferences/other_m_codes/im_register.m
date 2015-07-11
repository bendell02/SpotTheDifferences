function [] = im_register(AA,BB)
% IM_REGISTER ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 12-Mar-2015 19:38:16 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : im_register.m 


%% 两幅图像同维度化
s_a = size(AA);                             %获取两图像尺寸
s_b = size(BB);

min_r = min(s_a(1),s_b(1));                 %取最小尺寸
min_c = min(s_a(2),s_b(2));

t_ra = (s_a(1) - min_r)/2;                  %%% 获取两幅图像同维度化的行列坐标
t_ra = floor(t_ra);
t_rb = (s_b(1) - min_r)/2;
t_rb = floor(t_rb);

ra1 = 1 + t_ra;
ra2 = t_ra + min_r;
rb1 = 1 + t_rb;
rb2 = t_rb + min_r;

t_ca = (s_a(2) - min_c)/2;
t_ca = floor(t_ca);
t_cb = (s_b(2) - min_c)/2;
t_cb = floor(t_cb);

ca1 = 1 + t_ca;
ca2 = t_ca + min_c;
cb1 = 1 + t_cb;
cb2 = t_cb + min_c;

AA_s = AA(ra1:ra2,ca1:ca2,:);
BB_s = BB(rb1:rb2,cb1:cb2,:);

% figure(1); imshow(AA_s)
% figure(2); imshow(BB_s)

%% 设定可移动范围，此处采用了手动指定，也可设成图像长度、宽度的十分之一
m_r = 10;
m_c = 10;

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

i = rows - (m_r+1);  j = cols - (m_c+1);
ra1 = max(i,1); ra2 = min(s(1),s(1)+i); %计算平移后重叠图像的行列坐标
ca1 = max(j,1); ca2 = min(s(2),s(2)+j);

rb1 = max(1,-i+1); rb2 = min(s(1)-i+1,s(1));
cb1 = max(1,-j+1); cb2 = min(s(2)-j+1,s(2));

temp_AA = AA_s(ra1:ra2,ca1:ca2,:);      %获取重叠后的图像
temp_BB = BB_s(rb1:rb2,cb1:cb2,:);

temp2_BB = rgb2gray(temp_BB);
% figure(2); imshow(temp2_BB)

temp_AA = double(temp_AA);
temp_BB = double(temp_BB);

diff_AB = temp_AA - temp_BB;            %作差并统计重叠元素个数
rlt_AB = sqrt(diff_AB(:,:,1).^2+diff_AB(:,:,2).^2+diff_AB(:,:,3).^2);

rlt_AB = im2bw(rlt_AB);
% figure(1); imshow(rlt_AB)
% figure(1); imshow(rlt_AB,[0,median(rlt_AB(:))])
% figure(1); imshow(rlt_AB,[0,max(rlt_AB(:))/3])
% imtool(rlt_AB,[])

%% 识别结果与灰度原图组合
rlt_red(:,:,1) = uint8(255*rlt_AB);         %识别结果用红色表示
rlt_red(:,:,2) = uint8(0);
rlt_red(:,:,3) = uint8(0);

rlt_c(:,:,1) = temp2_BB;                    %把二维灰度原图转换成三维灰度原图
rlt_c(:,:,2) = temp2_BB;
rlt_c(:,:,3) = temp2_BB;

rlt_t(:,:,1) = rlt_AB;                      %二维逻辑型结果三维化
rlt_t(:,:,2) = rlt_AB;
rlt_t(:,:,3) = rlt_AB;

rlt = double(rlt_red).*double(rlt_t) + double(rlt_c).*double(1-rlt_t);
rlt = uint8(rlt);
figure(1);imshow(rlt)

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [im_register.m] ======  
