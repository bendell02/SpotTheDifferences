function Iscr = capScreen2()
% CAPSCREEN2 ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 10-Mar-2015 10:25:17 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.3.0.532 (R2014a) 
%% FILENAME  : capScreen2.m 

import java.awt.event.*;
rob=java.awt.Robot;
t = java.awt.Toolkit.getDefaultToolkit();
rectangle = java.awt.Rectangle(t.getScreenSize());
% if nargin   % nargin 是输入变量个数  无即为截全屏
%     set(rectangle,'Bounds',a)
% end
img = rob.createScreenCapture(rectangle);
filehandle = java.io.File('scr.png');
javax.imageio.ImageIO.write(img,'png',filehandle); 
Iscr=imread('scr.png');


%% End_of_File  
% Created with NFCN.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [capScreen2.m] ======  
