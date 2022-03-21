function I_gaussian=Gaussian(I,hsize, sigma)       %高斯滤波
    size = (hsize-1)/2;
    [m,n] = meshgrid(-size(2):size(2),-size(1):size(1));
    arg = -(m.*m + n.*n)/(2*sigma*sigma);
    h = exp(arg);
    h(h<eps*max(h(:))) = 0;
    sumh = sum(h(:));
    if sumh ~= 0
       h = h/sumh;
    end
    
    I_gaussian = double(I);
    I_gaussian=conv2( I_gaussian,h,'same'); 
end

