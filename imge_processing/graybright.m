function [ gray ] = graybright( gray , op , offset )
[w,h] =size(gray);
if(op=='+')
  for i=1:w
    for j=1:h   
          x = gray(i,j)+offset;   
          gray(i,j)=x;
    end
  end
else if(op=='-')
  for i=1:w
    for j=1:h 
          x = gray(i,j)-offset;   
          gray(i,j)=x;
    end
 end 
else if(op=='*')
  for i=1:w
    for j=1:h  
          x = gray(i,j)*offset;   
          gray(i,j)=x;
    end
 end 
else if(op=='/')
  for i=1:w
    for j=1:h  
          x = gray(i,j)/offset;   
          gray(i,j)=x;
    end
 end 
    end
    end
    end
end
%imshow(gray),title('gray');
end