function [ binary ] = grayTobinary ( gray , t )
%%%%% the convert range
	[w,h] = size(gray);
	%gray =im2double(gray)
	for x=1:w
		for y=1:h
			if(gray(x,y)>t)
				binary(x,y)= 1;
			else	
				binary(x,y)= 0;
			end
		end
	end
%imshow(binary),title('grayTobinary');
end 