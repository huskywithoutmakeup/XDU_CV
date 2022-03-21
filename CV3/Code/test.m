%% 测试手写数字
load Minist_LeNet5 net;   %导入训练好的LeNet5网络

I_test=imageDatastore('test_pic','FileExtensions',{'.jpg','.png','.bmp'},'IncludeSubfolders',false,'LabelSource','foldernames');

count=numel(I_test.Files);  %test_data文件夹中的文件个数

 
%% 画图并识别
figure('Name','手写数字识别测试_19049100002_张泽群','NumberTitle','off');
for i = 1:count 
    test_image =readimage(I_test,i);    %导入手写体数字图片
    subplot(3,3,i);
    imshow(I_test.Files{i});

    %输入图像处理

    %1. 把彩色图灰度化
    shape = size(test_image);
    dim=numel(shape);  
    if dim > 2
    test_image = rgb2gray(test_image);      
    end

    %2. 使得图像为28x28，并且使得图像变为黑色背景，白色字体
    test_image = imresize(test_image, [28,28]); 
    test_image = imcomplement(test_image);       

    result = classify(net, test_image);  

    title(['识别结果：' char(result)])
end

