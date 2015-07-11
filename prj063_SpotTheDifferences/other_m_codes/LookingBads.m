% LOOKINGBADS ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 10-Mar-2015 11:15:42 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : LookingBads.m 

%% 初始化
Iscr = capScreen2();                                %截全屏
hf = figure(1); imshow(Iscr)
set(gcf,'outerposition',get(0,'screensize'));

[x,y] = ginput(4);                                  %手动选取两图框的位置

close(hf)                                           %关闭figure

%% 截图
pause(0.5)                                          %防止闪屏，截图不稳定

Iall = capScreen2();                                %截全屏

AA = imcrop(Iall,[min(x(1),x(2)),min(y(1),y(2)),abs(x(2)-x(1)),abs(y(2)-y(1))]);
figure(1); imshow(AA)

BB = imcrop(Iall,[min(x(3),x(4)),min(y(3),y(4)),abs(x(4)-x(3)),abs(y(4)-y(3))]);
figure(2); imshow(BB)

%% 图像处理


%% 显示结果


%% End_of_File  
% Created with NM.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [LookingBads.m] ======  
