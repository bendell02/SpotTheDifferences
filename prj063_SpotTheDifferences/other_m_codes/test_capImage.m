% TEST_CAPIMAGE ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 11-Mar-2015 09:14:41 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : test_capImage.m 

I = imread('20100203190019-286688109.jpg');
hf1 = figure(1); imshow(I)
set(gcf,'outerposition',get(0,'screensize'));
[x,y] = ginput(2);
BB = imcrop(I,[min(x(1),x(2)),min(y(1),y(2)),abs(x(2)-x(1)),abs(y(2)-y(1))]);
hf2 = figure(2); imshow(BB)
pause(1); close(hf2)
imwrite(BB,'AA.jpg')

[x,y] = ginput(2);
BB = imcrop(I,[min(x(1),x(2)),min(y(1),y(2)),abs(x(2)-x(1)),abs(y(2)-y(1))]);
hf2 = figure(2); imshow(BB)
pause(1); close(hf2)
imwrite(BB,'BB.jpg')









%% End_of_File  
% Created with NM.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [test_capImage.m] ======  
