function [I_sobel,I_sobel_x,I_sobel_y,GradValue,GradDirection]=Sobel(I)       %sobel算子
    hx = [-1 0 1;-2 0 2;-1 0 1;];
    hy = hx';
    sobel = double(I);
    I_sobel_x = conv2( sobel,hy,'same');
    I_sobel_y = conv2( sobel,hx,'same');
    I_sobel = sqrt(I_sobel_x.^2+I_sobel_y.^2); 
    GradValue = I_sobel/8;
    GradDirection  = atan2(I_sobel_y,I_sobel_x);
    
    %for x=2:m-1
        %for y=2:n-1
            %Gx = I(x+1,y-1) + 2*I(x+1,y) + I(x+1,y+1)-I(x-1, y-1) - 2*I(x-1,y) - I(x-1,y+1);
            %Gy = I(x-1,y-1) + 2*I(x,y-1) + I(x+1,y-1)-I(x-1, y+1) - 2*I(x,y+1) - I(x+1,y+1);
            %I_sobel_x(x,y) = Gx;
            %I_sobel_y(x,y) = Gy;
            %I_sobel(x,y) = sqrt(Gx^2+Gy^2); 
        %end
    %end
    
end