clear all;
clc;

I=imread('testPhoto.png');
I=rgb2gray(I);
figure;
subplot(2,3,1);
imshow(I),title('原图');
I=double(I);

%高斯滤波
%h= fspecial('gaussian',[5 5]);
%I=imfilter(I,h);
I_g = Gaussian(I,[5 5],0.5);
subplot(2,3,2);
imshow(uint8(I_g)),title('高斯滤波');

%sobel边缘检测
[I_s,I_sx,I_sy,GradValue,GradDirection] =Sobel(I_g);
subplot(2,3,3);
imshow(uint8(I_sx)),title('sobel_x方向梯度');

subplot(2,3,4);
imshow(uint8(I_sy)),title('sobel_y方向梯度');

subplot(2,3,5);
imshow(uint8(I_s)),title('sobel边缘检测');

xlswrite('result.xlsx',I_sx,'X方向梯度');
xlswrite('result.xlsx',I_sy,'Y方向梯度');
xlswrite('result.xlsx',GradValue,'梯度幅度');
xlswrite('result.xlsx',GradDirection,'梯度角度');

%canny边缘检测
I_c =Canny(I_s,I_sx,I_sy);
subplot(2,3,6);
imshow(uint8(I_c)),title('canny边缘检测');

