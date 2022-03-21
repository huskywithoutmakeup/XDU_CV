clc;
clear all;

%% 读取图片,显示双目视觉图
I_left = imread('LIma-000023.png');
I_right = imread('RIma-000023.png');

A = stereoAnaglyph(I_left,I_right);
figure(1)
imshow(A)
title('Red-Cyan composite view of the rectified stereo pair image')

%% 利用 Matlab 提供的 disparity 函数获取视差图
I_left = rgb2gray(I_left);
I_right = rgb2gray(I_right);

% 利用 disparitySGM 函数,测试
disparityRange = [0 88];
disparityMap = disparitySGM(I_left,I_right,'DisparityRange',disparityRange,'UniquenessThreshold',10);
figure(2)
imshow(disparityMap,disparityRange)
title('视差图 SGM')
colormap jet
colorbar

% 利用 disparityBM 函数,测试
disparityRange_BM = [0 96];
disparityMap_BM = disparitySGM(I_left,I_right,'DisparityRange',disparityRange_BM);
figure(3)
imshow(disparityMap_BM,disparityRange_BM)
title('视差图 BM')
colormap jet
colorbar

%% 求解深度图

[H,W]=size(disparityMap);

f = 7; % 焦距为7 mm

B = 500; % 基线为 500 mm

% 计算深度图
Z = ones(H,W);
Z = Z.*(B*f/4.8);

Z_BM = Z./disparityMap_BM;
Z_SGM = Z./disparityMap;


% 后处理步骤，为了让深度值过大但不是无穷的点显现
for i=1:H
    for j=1:W
        if Z_SGM(i,j)<=900 && Z_SGM(i,j)>85
            Z_SGM(i,j)=85;
        end
        if Z_BM(i,j)<=900 && Z_BM(i,j)>93
            Z_BM(i,j)=93;
        end
    end
end

showRange = [0 88];


% 突出对比，显现彩色图
figure(5) 
imshow(88-Z_SGM,showRange);
title('深度图 SGM')
colormap jet
colorbar


figure(6) 
imshow(96-Z_BM,disparityRange);
title('深度图 BM')
saveas(gcf,'深度图BM','png');  % 并保存结果图像
colormap jet
colorbar


