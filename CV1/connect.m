function I_connect=connect(I_connect,y,x,low)       %���Ӷ�λ�����ͨ����
    neighbour=[-1 -1;-1 0;-1 1;0 -1;0 1;1 -1;1 0;1 1];  %����ͨ��Ѱ
    [m, n]=size(I_connect);
    for k=1:8
        y2=y+neighbour(k,1);
        x2=x+neighbour(k,2);
        if y2>=1 &&y2<=m &&x2>=1 && x2<=n  
            if I_connect(y2,x2)>=low && I_connect(y2,x2)~=255   
                I_connect(y2,x2)=255;
                I_connect=connect(I_connect,y2,x2,low);
            end
        end        
    end 
end