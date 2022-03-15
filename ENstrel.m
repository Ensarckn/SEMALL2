 function A= ENstrel(alfa,Lalfa,Kalfa)
% alfa= açı
% Lalfa= uzunluk
% Kalfa= kalınlık

elemanuzunluk=strel('line',Lalfa,alfa);
uzunluk=elemanuzunluk.Neighborhood;
elemankalinlik= strel('line',Kalfa,alfa+90);
kalinlik=elemankalinlik.Neighborhood;
[x,y]= size(kalinlik);
[row,col]=size(uzunluk);
midy=round(y/2);
midx=round(x/2);
eklesutun=midy-1;
eklesatir= midx-1;
B=false(2*eklesatir+row,2*eklesutun+col);

[elemanyerlerx,elemanyerlery]=find(uzunluk==1);

B(elemanyerlerx+eklesatir,elemanyerlery+eklesutun) = uzunluk(elemanyerlerx,elemanyerlery);

[Brow,Bcol]= find(B==1);

for i=1:length(Brow)
satir=Brow(i);
sutun= Bcol(i);

B( satir-eklesatir:satir+eklesatir , sutun-eklesutun:sutun+eklesutun)= kalinlik+...
    B( satir-eklesatir:satir+eklesatir , sutun-eklesutun:sutun+eklesutun);


end %1.for
A=B;

A= imfill(A,'holes');

% figure, imshow(A)