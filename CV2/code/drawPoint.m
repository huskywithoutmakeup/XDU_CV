function drawPoint(I1,pos1,I2,pos2)
diff=size(I1,2);
figure('name','SURF特征点提取')
imshowpair(I1,I2,'montage');
hold on
title('SURF特征点提取');
plot(pos1(:,1),pos1(:,2),'r*');
plot(pos2(:,1)+diff,pos2(:,2),'g*');
hold off
