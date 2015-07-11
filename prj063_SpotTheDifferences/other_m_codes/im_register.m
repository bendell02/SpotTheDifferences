function [] = im_register(AA,BB)
% IM_REGISTER ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 12-Mar-2015 19:38:16 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : im_register.m 


%% ����ͼ��ͬά�Ȼ�
s_a = size(AA);                             %��ȡ��ͼ��ߴ�
s_b = size(BB);

min_r = min(s_a(1),s_b(1));                 %ȡ��С�ߴ�
min_c = min(s_a(2),s_b(2));

t_ra = (s_a(1) - min_r)/2;                  %%% ��ȡ����ͼ��ͬά�Ȼ�����������
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

%% �趨���ƶ���Χ���˴��������ֶ�ָ����Ҳ�����ͼ�񳤶ȡ���ȵ�ʮ��֮һ
m_r = 10;
m_c = 10;

%% ƽ�Ƽ��㡣�����ص����������ͼ������
s = size(AA_s);                             %ͬά�Ȼ���ͼ��ĳߴ�
z_s = zeros(2*m_r+1,2*m_c+1);               %z_s���ں���ͳ��ƽ�ƺ�ͼ���غ�Ԫ�صĸ���

for i = -m_r:m_r
    for j = -m_c:m_c
        
        ra1 = max(i,1); ra2 = min(s(1),s(1)+i); %����ƽ�ƺ��ص�ͼ�����������
        ca1 = max(j,1); ca2 = min(s(2),s(2)+j);
        
        rb1 = max(1,-i+1); rb2 = min(s(1)-i+1,s(1));
        cb1 = max(1,-j+1); cb2 = min(s(2)-j+1,s(2));
        
        temp_AA = AA_s(ra1:ra2,ca1:ca2,:);      %��ȡ�ص����ͼ��
        temp_BB = BB_s(rb1:rb2,cb1:cb2,:);
        temp_AA = double(temp_AA);
        temp_BB = double(temp_BB);
        
        diff_AB = temp_AA - temp_BB;            %���ͳ���ص�Ԫ�ظ���
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

%% ������ƥ�� λ��ʱ��λ�ƣ����������ʱ�ص����������ͼ��
[rows,cols]=find(z_s==max(z_s(:)));

i = rows - (m_r+1);  j = cols - (m_c+1);
ra1 = max(i,1); ra2 = min(s(1),s(1)+i); %����ƽ�ƺ��ص�ͼ�����������
ca1 = max(j,1); ca2 = min(s(2),s(2)+j);

rb1 = max(1,-i+1); rb2 = min(s(1)-i+1,s(1));
cb1 = max(1,-j+1); cb2 = min(s(2)-j+1,s(2));

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
% ===== EOF ====== [im_register.m] ======  
