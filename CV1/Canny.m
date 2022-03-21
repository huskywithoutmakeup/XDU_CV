function I_canny=Canny(I,I_x,I_y)       %canny算子
    [m,n] = size(I);
    newGradDricetion=zeros(m,n);                                
    for i=1:m  
        for j=1:n  
            Mx=I_x(i,j);  
            My=I_y(i,j);  
      
            if My~=0  
                o = atan(Mx/My);      %求边缘的法线弧度  
            elseif My == 0 && Mx > 0  
                o = pi/2;  
            else  
                o = -pi/2;              
            end           
   % 将梯度方向取0°，45°，90°，135°四个方向
            if ( ( o>=( -22.5/180*pi ) && o<( 22.5/180*pi ) ) || ( o>=( 157.5/180*pi ) && o<=pi ) || ( o<=( -157.5/180*pi ) && o>=-pi ) )  
                dir=0;  
            elseif ( ( o>= ( 22.5/180*pi ) && o<( 67.5/180*pi ) ) || ( o>= ( -157.5/180*pi ) && o<( -112.5/180*pi)))  
                dir=45;  
            elseif ( ( o>= ( 67.5/180*pi ) && o<( 112.5/180*pi) ) || ( o>= ( -112.5/180*pi ) && o<( -67.5/180*pi )))     
                dir=90;  
            else        
                dir=135;  
            end             
            newGradDricetion(i,j)=dir;  
        end  
    end  
    
    I_canny = I;
    
    %非极大值抑制
    for i=3:m-2  
        for j=3:n-2  
            if( newGradDricetion(i,j)==0 )  
                A=[I_canny(i-1,j),I_canny(i+1,j)];  
                if( abs(I_canny(i,j))< max( abs(A) ) )  
                    I_canny(i,j)=0;  
                end  
            elseif( newGradDricetion(i,j)==45 )  
                A=[I_canny(i-1,j-1),I_canny(i+1,j+1)];  
                if( abs(I_canny(i,j))< max( abs(A) ))  
                    I_canny(i,j)=0;  
                end  
            elseif( newGradDricetion(i,j)==90 )  
                A=[I_canny(i,j-1),I_canny(i,j+1)];  
                if( abs(I_canny(i,j))< max( abs(A) ) )  
                    I_canny(i,j)=0;  
                end              
            elseif( newGradDricetion(i,j)==135 )  
                A=[I_canny(i-1,j+1),I_canny(i+1,j-1)];  
                if( abs(I_canny(i,j))< max( abs(A) ) )  
                   I_canny(i,j)=0;  
                end    
            end  
        end  
    end 
    
    %用双阈值算法检测和连接边缘
    up=200;     %上阈值  
    low=35;     %下阈值  
    set(0,'RecursionLimit',10000);  %设置最大递归深度  
    for i=1:m  
        for j=1:n  
          if I_canny(i,j)>up &&I_canny(i,j)~=255  %判断上阈值  
                I_canny(i,j)=255;  
                I_canny=connect(I_canny,i,j,low);  
          end  
        end  
    end  
end