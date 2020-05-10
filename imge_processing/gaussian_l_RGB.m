function  [ni]=gaussian_l_RGB( RGB,d0 )
%figure,imshow(RGB),title('orignal');
R1=gaussianlowRGB(RGB(:,:,1),d0 );
G1=gaussianlowRGB(RGB(:,:,2),d0 );
B1=gaussianlowRGB(RGB(:,:,3),d0 );
ni=cat(3,uint8(R1),uint8(G1),uint8(B1));
%figure,imshow(ni,[]),title('RGB high butterworth PASS FILTER');
end