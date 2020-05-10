function [ stretch ] =contrast(I,bits)
[H W L]=size(I);
I=double(I);
stretch=zeros(H,W,L);
newmin=0;
newmax=(2^bits) - 1;
oldmin=min(min(min(I)));
oldmax=max(max(max(I)));
for i=1:H
    for j=1:W
        for l=1:L
        stretch(i,j,l)=(((I(i,j,l)-oldmin)/(oldmax-oldmin))*(newmax-newmin))+newmin;
        end
    end
end
stretch=uint8(stretch);

imshow(stretch),title('contrast');
end

