function [AA_s,BB_s] = same_size(AA,BB)
% SAME_SIZE ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 13-Mar-2015 18:27:11 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : same_size.m 

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



%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [same_size.m] ======  
