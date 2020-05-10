function [newimage ] = clipping( oldimage )
 [H W L]=size(oldimage);
oldimage=double(oldimage);
newimage=zeros(H,W,L);
for l=1:L
for i=1:H
 for j=1:W
     if(oldimage(i,j,l)>255)
        newimage(i,j,l)=255;
     elseif(oldimage(i,j,l)<0)
        newimage(i,j,l)=0;
     else
         newimage(i,j,l)=oldimage(i,j,l);
     end         
 end 
end
end
end

