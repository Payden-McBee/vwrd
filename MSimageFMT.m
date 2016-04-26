function simg = MSimageFMT(img)

RGB = img(:,:,1:3) ;
DRGB = double(RGB) ;
[n1, n2, n3] = size(DRGB) ;
simg=[] ;
for i=1:3
    v=reshape(DRGB(:,:,i),n1*n2,1) ;
    lo = prctile(v,5) 
    hi = prctile(v,95) 
    temp = (DRGB(:,:,i) - lo) / (hi - lo ) ;
    temp(temp>1)= 1.0 ;
    temp(temp<0)= 0.0 ;
   % figure(i);
   % imshow(temp) ;
    simg(:,:,i) = temp ;
end
imshow(simg) ;


