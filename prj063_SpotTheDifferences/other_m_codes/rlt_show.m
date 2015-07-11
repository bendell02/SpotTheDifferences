function [] = rlt_show(AA_s,BB_s,r_i,r_j)
% RLT_SHOW ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 13-Mar-2015 18:35:41 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : rlt_show.m 

s = size(AA_s);                             %同维度化后图像的尺寸

ra1 = max(r_i,1); ra2 = min(s(1),s(1)+r_i); %计算平移后重叠图像的行列坐标
ca1 = max(r_j,1); ca2 = min(s(2),s(2)+r_j);

rb1 = max(1,-r_i+1); rb2 = min(s(1)-r_i+1,s(1));
cb1 = max(1,-r_j+1); cb2 = min(s(2)-r_j+1,s(2));

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
% ===== EOF ====== [rlt_show.m] ======  
