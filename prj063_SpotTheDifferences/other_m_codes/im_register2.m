function [r_i,r_j] = im_register2(AA_s,BB_s,m_t)
% IM_REGISTER2 ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 13-Mar-2015 18:29:21 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : im_register2.m 

%% �趨���ƶ���Χ���˴��������ֶ�ָ����Ҳ�����ͼ�񳤶ȡ���ȵ�ʮ��֮һ
m_r = m_t;
m_c = m_t;

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

r_i = rows - (m_r+1);  r_j = cols - (m_c+1);

%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [im_register2.m] ======  
