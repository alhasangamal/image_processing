function [ nimage ] = gaussianNoise( i,p,m,sigma )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[h,w,l2]=size(i);
nimage=i;
%figure,imshow(i);
for k=1:l2
for I=0 :255
    m1=(I-m)/(2*power(sigma , 2));
    m11=exp(-m1);
    m2=sqrt(2*3.14)*sigma;
    ns=(m11/m2)*w*h*p ;
    ns=uint8(ns);
    for j=1 :ns
    x=randi(h,1,1);
    y=randi(w,1,1);
    nimage(x,y,k)=i(x,y,k)+I;
    end
end
end
%figure,imshow((nimage));
end