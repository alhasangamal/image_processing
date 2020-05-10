function [ image new_image new_image1 y ] = fourier_transfomation_gray( image )
[w,h] = size(image);
image=image;
new_image=fft2(image);
y=fft2(image);
for width=1:w
    for hight=1:h
        r=real(new_image(width,hight));
        im=imag(new_image(width,hight));
        res=sqrt((r*r)+(im*im));
        new_image(width,hight)=res;
    end
end
new_image=log2(new_image+1);
new_image=mat2gray(new_image);
for width=1:w
    for hight=1:h
        r=real(new_image(width,hight));
        im=imag(new_image(width,hight));
        res=sqrt((r*r)+(im*im));
        new_image(width,hight)=res;
    end
end
fig3;
subplot(2,2,1);imshow(image),title('before process');
new_image=log2(new_image+1);
new_image=mat2gray(new_image);
subplot(2,2,2);imshow(new_image),title('Before Shift');
new_image1=fftshift(new_image);
subplot(2,2,3);imshow(new_image1),title('After Shift');
y=ifft2(y);
y=uint8(y);
subplot(2,2,4);imshow(y),title('after process');
end

