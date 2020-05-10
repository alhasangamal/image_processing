function [ new_image ] = Gama( image,g )
image=im2double(image);
[H  W  L]=size(image);
if L==3
    for i=1:H
        for j=1:W
                new_image(i,j,1)=power(image(i,j,1),g);
                new_image(i,j,2)=power(image(i,j,2),g);
                new_image(i,j,3)=power(image(i,j,3),g);
        end
    end 
else
    for i=1:H
        for j=1:W
              new_image(i,j)=power(image(i,j),g);
         end
     end
end
imshow(new_image),title('gam-image');
end

