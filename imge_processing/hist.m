function [r b g] = hist( image )
I=double(image);
[H  W  L]=size(I);
hist_gray=zeros(256,1);
hist_red=zeros(256,1);  
hist_green=zeros(256,1);
hist_blue=zeros(256,1);
  if L==3
for i=1:H
    for j=1:W
			 hist_red(I(i,j,1)+1)=  hist_red(I(i,j,1)+1)+1;
             hist_green(I(i,j,2)+1)=  hist_green(I(i,j,2)+1)+1;
             hist_blue(I(i,j,3)+1)=  hist_blue(I(i,j,3)+1)+1;
    end
end
r=hist_red;
b=hist_green;
g=hist_blue;
% subplot(3,1,1);bar(hist_red),title('red');
% subplot(3,1,2);bar(hist_green),title('green');
% subplot(3,1,3);bar(hist_blue),title('blue'); 
  else
        for i=1:H
              for j=1:W
                 hist_gray(I(i,j)+1)=  hist_gray(I(i,j)+1)+1;
              end
        end
  r=hist_gray;

%  %bar(r);
%   imshow( plot(bar(r)));
% %   figure,bar(r),title('gray');
  end
end   
   

    



  




