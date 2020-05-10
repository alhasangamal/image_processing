function [ new_image ] = his_eq( image )
[H W L]=size(image);

histo=zeros(256,1);
for i=1:H
    for j=1:W
          histo(image(i,j)+1)=  histo(image(i,j)+1)+1;
    end
end

CDF=zeros(256,1);
NCDF=zeros(256,1);
new_image=zeros(H,W,L);
%calculate CDF
 CDF(1) = histo(1);
 for i=2:256
       CDF(i)= CDF(i-1)+histo(i);
 end
 
Min_Cdf=min(CDF);
Max_Cdf=max(CDF);
%calculate Ncdf
for k=1:256
    NCDF(k)=round(((CDF(k)-Min_Cdf) / (Max_Cdf-Min_Cdf) )*255);
end

for m=1:256
    for l=1:L
        for h=1:H
            for w=1:W
                if(image(h,w,l)==m)
                    new_image(h,w,l)=NCDF(m);  
                end
            end
        end
    end
end
new_image=uint8(new_image);
fig3;
subplot(2,2,1);imshow(image),title('Old Image');
subplot(2,2,2);bar(histo),title('Hist of old image');
subplot(2,2,3);imshow(new_image),title('Equalized Image');
subplot(2,2,4);bar(NCDF),title('Equalized Hist of Image');
end

