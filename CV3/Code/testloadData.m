%% load data
imageDim = 28;
% 训练数据
train_Images = loadMNISTImages('train-images.idx3-ubyte');
train_Images = reshape(train_Images,imageDim,imageDim,[]);
train_Images = train_Images(1:28,1:28,1:1000);
train_Labels = loadMNISTLabels('train-labels.idx1-ubyte');
train_Labels(train_Labels == 0) = 10;
train_Labels = train_Labels(1:1000,1);
% 测试数据
test_Images = loadMNISTImages('t10k-images.idx3-ubyte');
test_Images = reshape(test_Images,imageDim,imageDim,[]);
test_Images = test_Images(1:28,1:28,1:1000);
test_Labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
test_Labels(test_Labels == 0) = 10;
test_Labels = test_Labels(1:1000,1);

%% 对60000条训练数据处理，使对应图像分别进入对应标签的子文件夹
for i=1:1000
    if train_Labels(i) == 10
    imwrite(train_Images(:,:,i),sprintf('%s%d%s','./train_data/0/',i,'.png'));
    elseif train_Labels(i) == 1
    imwrite(train_Images(:,:,i),sprintf('%s%d%s','./train_data/1/',i,'.png'));
    elseif train_Labels(i) == 2
    imwrite(train_Images(:,:,i),sprintf('%s%d%s','./train_data/2/',i,'.png'));
    elseif train_Labels(i) == 3
    imwrite(train_Images(:,:,i),sprintf('%s%d%s','./train_data/3/',i,'.png'));
    elseif train_Labels(i) == 4
    imwrite(train_Images(:,:,i),sprintf('%s%d%s','./train_data/4/',i,'.png'));
    elseif train_Labels(i) == 5
    imwrite(train_Images(:,:,i),sprintf('%s%d%s','./train_data/5/',i,'.png'));
    elseif train_Labels(i) == 6
    imwrite(train_Images(:,:,i),sprintf('%s%d%s','./train_data/6/',i,'.png'));
    elseif train_Labels(i) == 7
    imwrite(train_Images(:,:,i),sprintf('%s%d%s','./train_data/7/',i,'.png'));
    elseif train_Labels(i) == 8
    imwrite(train_Images(:,:,i),sprintf('%s%d%s','./train_data/8/',i,'.png'));
    elseif train_Labels(i) == 9
    imwrite(train_Images(:,:,i),sprintf('%s%d%s','./train_data/9/',i,'.png'));
    end
end


%% 对10000条测试数据处理，使对应图像分别进入对应标签的子文件夹
for i=1:1000
    if test_Labels(i) == 10
    imwrite(test_Images(:,:,i),sprintf('%s%d%s','./test_data/0/',i,'.png'));
    elseif test_Labels(i) == 1
    imwrite(test_Images(:,:,i),sprintf('%s%d%s','./test_data/1/',i,'.png'));
    elseif test_Labels(i) == 2
    imwrite(test_Images(:,:,i),sprintf('%s%d%s','./test_data/2/',i,'.png'));
    elseif test_Labels(i) == 3
    imwrite(test_Images(:,:,i),sprintf('%s%d%s','./test_data/3/',i,'.png'));
    elseif test_Labels(i) == 4
    imwrite(test_Images(:,:,i),sprintf('%s%d%s','./test_data/4/',i,'.png'));
    elseif test_Labels(i) == 5
    imwrite(test_Images(:,:,i),sprintf('%s%d%s','./test_data/5/',i,'.png'));
    elseif test_Labels(i) == 6
    imwrite(test_Images(:,:,i),sprintf('%s%d%s','./test_data/6/',i,'.png'));
    elseif test_Labels(i) == 7
    imwrite(test_Images(:,:,i),sprintf('%s%d%s','./test_data/7/',i,'.png'));
    elseif test_Labels(i) == 8
    imwrite(test_Images(:,:,i),sprintf('%s%d%s','./test_data/8/',i,'.png'));
    elseif test_Labels(i) == 9
    imwrite(test_Images(:,:,i),sprintf('%s%d%s','./test_data/9/',i,'.png'));
    end
end


