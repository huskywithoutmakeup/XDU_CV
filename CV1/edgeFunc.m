clc;
clear all;
I = imread('testPhoto.png');
I=rgb2gray(I);  
H = fspecial('gaussian',5,0.5);
I1 = edge(I,'sobel');
I2 = edge(I,'canny');

figure
subplot(1,2,1)
imshow(I1);title('sobel');
subplot(1,2,2)
imshow(I2);title('canny');

