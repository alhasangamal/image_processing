function [h]=exp_noise(I,a)
[w,h2,l2]=size(I);
new_image=I;
%figure,imshow(I);  
for k=1:l2
for i=1:255
    ns=a*exp(-a*i);
    for j=0:ns
    x=randi(w,1);
    y=randi(h2,1);
    new_image(x,y,k)=I(x,y,k)+i;
    end
end
end
h=uint8(new_image);
%figure,imshow(h);
end