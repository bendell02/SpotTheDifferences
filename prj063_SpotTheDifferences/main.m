function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 13-Mar-2015 19:47:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global hf1 flag_reg m_t
hf1 = true;
% handle(hf1)
flag_reg = false;
m_t = 5;

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y flag_reg hf1
%% 初始化
Iscr = capScreen2();                                %截全屏
hf = figure(1); imshow(Iscr)
set(gcf,'outerposition',get(0,'screensize'));

[x,y] = ginput(4);                                  %手动选取两图框的位置

close(hf)                                           %关闭figure

% 是开始按钮有效
set(handles.pushbutton2,'Enable','on')

flag_reg = false;
% hf1 = 0;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y hf1 flag_reg
global r_i r_j m_t
%% 截图
Iall = capScreen2();                                %截全屏

AA = imcrop(Iall,[min(x(1),x(2)),min(y(1),y(2)),abs(x(2)-x(1)),abs(y(2)-y(1))]);
% figure(1); imshow(AA)

BB = imcrop(Iall,[min(x(3),x(4)),min(y(3),y(4)),abs(x(4)-x(3)),abs(y(4)-y(3))]);
% figure(2); imshow(BB)

%% 设定好结果figure的位置，方便浏览

if ~ishandle(hf1)
    hf1 = figure(1);
    h=get(figure(1),'Position');
    s = get(0,'ScreenSize');
    d = s - h;
    h=[d(3) s(4)/6 h(3) h(4)];
    set(figure(1),'Position',h)
    figure(1)
end

if ~flag_reg
    flag_reg = true;                                %配准
    [AA_s,BB_s] = same_size(AA,BB);
    [r_i,r_j] = im_register2(AA_s,BB_s,m_t);
else
    [AA_s,BB_s] = same_size(AA,BB);
end

rlt_show(AA_s,BB_s,r_i,r_j)


% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global m_t flag_reg
switch get(hObject,'tag')
    case 'radiobutton_5'
        m_t = 5;
    case 'radiobutton_10'
        m_t = 10;
end
flag_reg = false;


function Iscr = capScreen2()

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


function [AA_s,BB_s] = same_size(AA,BB)
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


function [] = rlt_show(AA_s,BB_s,r_i,r_j)

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

function [r_i,r_j] = im_register2(AA_s,BB_s,m_t)

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