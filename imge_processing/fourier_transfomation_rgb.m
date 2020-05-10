function [ new_image ] = fourier_transfomation_rgb( image )
[w,h,l] = size(image);
new_image(:,:,1)=fft2(image(:,:,1));
new_image(:,:,2)=fft2(image(:,:,2));
new_image(:,:,3)=fft2(image(:,:,3));
y(:,:,1)=fft2(image(:,:,1));
y(:,:,2)=fft2(image(:,:,2));
y(:,:,3)=fft2(image(:,:,3));
for width=1:w
    for hight=1:h
        for n=1:l
            r=real(new_image(width,hight,n));
            im=imag(new_image(width,hight,n));
            res=sqrt((r*r)+(im*im));
            new_image(width,hight,n)=res;
        end
    end
end
new_image=log2(new_image+1);
new_image(:,:,1)=mat2gray(new_image(:,:,1));
new_image(:,:,2)=mat2gray(new_image(:,:,2));
new_image(:,:,3)=mat2gray(new_image(:,:,3));
for width=1:w
    for hight=1:h
        for n=1:l
            r=real(new_image(width,hight,n));
            im=imag(new_image(width,hight,n));
            res=sqrt((r*r)+(im*im));
            new_image(width,hight,n)=res;
        end
    end
end
fig3;
subplot(2,2,1);subplot(2,2,1);imshow(image),title('before process');
new_image=log2(new_image+1);
new_image(:,:,1)=mat2gray(new_image(:,:,1));
new_image(:,:,2)=mat2gray(new_image(:,:,2));
new_image(:,:,3)=mat2gray(new_image(:,:,3));
subplot(2,2,2);imshow(new_image),title('Before Shift');
new_image(:,:,1)=fftshift(new_image(:,:,1));
new_image(:,:,2)=fftshift(new_image(:,:,2));
new_image(:,:,3)=fftshift(new_image(:,:,3));
subplot(2,2,3);imshow(new_image),title('After Shift');
y(:,:,1)=ifft2(y(:,:,1));
y(:,:,2)=ifft2(y(:,:,2));
y(:,:,3)=ifft2(y(:,:,3));
subplot(2,2,4);imshow(uint8(y)),title('after process');


end

