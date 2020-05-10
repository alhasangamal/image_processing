function  [ni]=gaussian_h_RGB( RGB,d0 )
%figure,imshow(RGB),title('orignal');
R1=gaussianhighRGB(RGB(:,:,1),d0 );
G1=gaussianhighRGB(RGB(:,:,2),d0 );
B1=gaussianhighRGB(RGB(:,:,3),d0 );
ni=cat(3,uint8(R1),uint8(G1),uint8(B1));
%figure,imshow(ni,[]),title('RGB high butterworth PASS FILTER');
end