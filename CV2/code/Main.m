clear all;
clc;

% 读取图像
I1=imread('I1.png');
I2=imread('I2.png');

ISize=size(I1); 
I2 = imresize(I2,[ISize(1),ISize(2)]);

% 并排显示两幅待拼接图像
Imgs=[I1,I2];
figure,imshow(Imgs);
title('待拼接图像');

% 转化为灰度图
img1=rgb2gray(I1);
img2=rgb2gray(I2);

% 对图像进行滤波
img1=medfilt2(img1);
img2=medfilt2(img2);

% SURF算法读取特征点
points1 = detectSURFFeatures(img1);
points2 = detectSURFFeatures(img2);
% 特征点图像
drawPoint(I1,points1.Location,I2,points2.Location);

% 提取特征向量  
[f1, vpts1] = extractFeatures(img1, points1,'Method','SURF');  
[f2, vpts2] = extractFeatures(img2, points2,'Method','SURF'); 

% 进行匹配，检索匹配点的位置  
indexPairs = matchFeatures(f1, f2, 'Prenormalized', true) ;  
matched_pts1 = vpts1(indexPairs(:, 1)); 
matched_pts2 = vpts2(indexPairs(:, 2)); 

% 显示匹配,但仍存在离群点的影响
figure('name','匹配后的图像'); 
showMatchedFeatures(I1,I2,matched_pts1,matched_pts2,'montage');  
title('匹配后的图像');
legend('matched points 1','matched points 2'); 

% 从匹配点对估计几何变换
% 该函数使用随机样本一致性（RANSAC）算法的变体MSAC算法实现，去除误匹配点
[tform,inlierIdx] = estimateGeometricTransform2D(matched_pts2,matched_pts1,'similarity');
inlier_pts1 = matched_pts1(inlierIdx,:);
inlier_pts2 = matched_pts2(inlierIdx,:);
figure
showMatchedFeatures(I1,I2,inlier_pts1,inlier_pts2,'montage');
title('RANSAC算法消除离群点影响后的图像')

% 利用图像几何变换算法实现图像变换和拼接
Rfixed = imref2d(size(I1)); %获取图像的世界坐标
[B, RB] = imwarp(I2, tform);%根据几何变换 tform 来变换I2
figure
imshowpair(I1,Rfixed,B,RB,'blend');
title('初步拼接的图像')

[xlim, ylim] = outputLimits(tform, [1 ISize(2)], [1 ISize(1)]);
% 找到输出空间限制的最大最小值
xMin = min([1; xlim(:)]);%1
xMax = max([ISize(2); xlim(:)]);
yMin = min([1; ylim(:)]);
yMax = max([ISize(1); ylim(:)]);

% 全景图的宽高
width  = round(xMax - xMin);
height = round(yMax - yMin);

% 创建2D空间参考对象定义全景图尺寸
xLimits = [xMin xMax];
yLimits = [yMin yMax];
% 创建全景图
panoramaView = imref2d([height width], xLimits, yLimits);

% 变换图像I2到全景图
warped_img = imwarp(I2, tform, 'OutputView', panoramaView);

%亮度归一化
mask2 = (warped_img(:,:,1)>0 |warped_img(:,:,2)>0 | warped_img(:,:,3)>0);% 获取变换图像掩膜
Idone = zeros(size(warped_img));
Idone(1:size(I1,1), 1: size(I1,2),:) = I1; % I1不变
mask1 = (Idone(:,:,1)>0 | Idone(:,:,2)>0 | Idone(:,:,3)>0); % 获取非变换图像掩膜
mask = and(mask2, mask1);% 重叠区图像掩膜

% 获得重叠区透明度(i2)
[~,col] = find(mask);
left = min(col);
right = max(col);
mask = ones(size(mask));
mask(:,left:right) = repmat(linspace(0,1,right-left+1),size(mask,1),1);% 复制平铺矩阵

% 融合RGB通道(I2)
warped_img=double(warped_img);
warped_img(:,:,1) = warped_img(:,:,1).*mask;
warped_img(:,:,2) = warped_img(:,:,2).*mask;
warped_img(:,:,3) = warped_img(:,:,3).*mask;

% 反转透明度值(I1)
mask(:,left:right) = repmat(linspace(1,0,right-left+1),size(mask,1),1);
% 融合RGB通道(I1)
Idone(:,:,1) = Idone(:,:,1).*mask;
Idone(:,:,2) = Idone(:,:,2).*mask;
Idone(:,:,3) = Idone(:,:,3).*mask;

% 相加得出后处理图像
Idone(:,:,1) = warped_img(:,:,1) + Idone(:,:,1);
Idone(:,:,2) = warped_img(:,:,2) + Idone(:,:,2);
Idone(:,:,3) = warped_img(:,:,3) + Idone(:,:,3);
Idone=uint8(Idone);
figure
imshow(Idone);
title('后处理图像');