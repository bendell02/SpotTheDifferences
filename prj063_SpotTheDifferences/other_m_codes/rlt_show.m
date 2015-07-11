function [] = rlt_show(AA_s,BB_s,r_i,r_j)
% RLT_SHOW ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 13-Mar-2015 18:35:41 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : rlt_show.m 

s = size(AA_s);                             %ͬά�Ȼ���ͼ��ĳߴ�

ra1 = max(r_i,1); ra2 = min(s(1),s(1)+r_i); %����ƽ�ƺ��ص�ͼ�����������
ca1 = max(r_j,1); ca2 = min(s(2),s(2)+r_j);

rb1 = max(1,-r_i+1); rb2 = min(s(1)-r_i+1,s(1));
cb1 = max(1,-r_j+1); cb2 = min(s(2)-r_j+1,s(2));

temp_AA = AA_s(ra1:ra2,ca1:ca2,:);      %��ȡ�ص����ͼ��
temp_BB = BB_s(rb1:rb2,cb1:cb2,:);

temp2_BB = rgb2gray(temp_BB);
% figure(2); imshow(temp2_BB)

temp_AA = double(temp_AA);
temp_BB = double(temp_BB);

diff_AB = temp_AA - temp_BB;            %���ͳ���ص�Ԫ�ظ���
rlt_AB = sqrt(diff_AB(:,:,1).^2+diff_AB(:,:,2).^2+diff_AB(:,:,3).^2);

rlt_AB = im2bw(rlt_AB);
% figure(1); imshow(rlt_AB)
% figure(1); imshow(rlt_AB,[0,median(rlt_AB(:))])
% figure(1); imshow(rlt_AB,[0,max(rlt_AB(:))/3])
% imtool(rlt_AB,[])

%% ʶ������Ҷ�ԭͼ���
rlt_red(:,:,1) = uint8(255*rlt_AB);         %ʶ�����ú�ɫ��ʾ
rlt_red(:,:,2) = uint8(0);
rlt_red(:,:,3) = uint8(0);

rlt_c(:,:,1) = temp2_BB;                    %�Ѷ�ά�Ҷ�ԭͼת������ά�Ҷ�ԭͼ
rlt_c(:,:,2) = temp2_BB;
rlt_c(:,:,3) = temp2_BB;

rlt_t(:,:,1) = rlt_AB;                      %��ά�߼��ͽ����ά��
rlt_t(:,:,2) = rlt_AB;
rlt_t(:,:,3) = rlt_AB;

rlt = double(rlt_red).*double(rlt_t) + double(rlt_c).*double(1-rlt_t);
rlt = uint8(rlt);
figure(1);imshow(rlt)


%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [rlt_show.m] ======  
