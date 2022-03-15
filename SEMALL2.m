clear all; close all; clc;

IMGr= imread('16_Y12_PVA_TEK_04.tif');


figure
imshow(IMGr)
%%
h = imdistline;
fcn = makeConstrainToRectFcn( 'imline' ,get(gca, 'XLim' ),get(gca, 'YLim' ));
setDragConstraintFcn(h,fcn);  

 olcu= input('ÖLÇÜ: ')
olcu2pixel= input('PİXEL: ')
oran= olcu/olcu2pixel;

IMGv=rgb2gray(IMGr);

% imshow(IMGv)

% figure, imhist(IMGv);
% title('Histogrm veri')


IMGv= imadjust(IMGv);
% figure, imhist(IMGv)
% figure, imshow(IMGv)

[row,column]= size(IMGv);
row= row-78;
%78

 IMG= IMGv;

%   IMG(IMG<100)=0; % karanlığa gömüyoruz


IMG1= imbinarize(IMG(1:row,:),'adaptive','ForegroundPolarity','bright','Sensitivity',0.9);
%%
for i = [7,8,9,20,22,23,25,30,40,41,49,50,51,53,70,80,83,94,96,102,110,115,119,129,133,146,149,157,171,173]
    %aci= [7,8,9,20,22,23,25,30,40,41,49,50,51,53,70,80,83,94,96,102,110,115,119,129,133,146,149,157,171,173]
pause(1);

%   se2 = strel('line',250,i); 
se= strel('arbitrary',ENstrel(i,100,5));
% çok düşük olunca karısıyor.
 IMG2= imopen(IMG1,se);
% figure, imshow(IMG2)

IMG2=bwareaopen(IMG2,300,8);

% figure
% imshow(IMG)

 se = strel('line',100,i);

IMG2= imerode(IMG2,se);
IMG2=bwareaopen(IMG2,700,8);
se= strel('square',3); 
IMG2= imdilate(IMG2,se);



[etiketler, nesnesayisi]= bwlabel(IMG2,8);

sinirlar= bwboundaries(etiketler);
nesnemerkez= regionprops(etiketler,'Centroid');

for j=1:nesnesayisi
lifmerkezler(j,1:2)=nesnemerkez(j).Centroid;
end

%capbulunur
[konumlar,mesafe,mesafe2]=capbulucu(IMG2,i);



%
   IMGrcopy= IMGr;


% Kırmızı ile çaplar çiziliyor
for d=1:length(konumlar)
    if isempty(konumlar{d}), continue; end
    
    konumx= konumlar{d}(1:end,1);
    konumy= konumlar{d}(1:end,2);
    IMGrcopy(konumy,konumx,1)= 255;
    IMGrcopy(konumy,konumx,2)= 0;
    IMGrcopy(konumy,konumx,3)= 0;
end


figure, imshow(IMGrcopy)

baslik= sprintf('%d degrees',i);
title(baslik)
hold on


if length(konumlar) < nesnesayisi
    cevir= length(konumlar);
else
    cevir= nesnesayisi;
end


for k=1:cevir


    text(lifmerkezler(k,1)+1,lifmerkezler(k,2)-3,sprintf('%.2f',mesafe(k)*oran),'Color','y','FontWeight','bold','FontSize',8)
        
% text(lifmerkezler(k,1)+1,lifmerkezler(k,2)-20,sprintf('%d',k),'Color','b','FontWeight','bold','FontSize',8)

%     text(lifmerkezler(k,1)+15,lifmerkezler(k,2)-3,sprintf('%.2f',mesafe2(k)),'Color','g','FontWeight','bold','FontSize',8)
sinir= sinirlar{k};
   plot(sinir(:,2),sinir(:,1),'c','LineWidth',2);

end



hold off

end
%%
%    IMGrcopy= IMGr;
% for d=1:length(konumlar)
%     if isempty(konumlar{d}), continue; end
%     
%     konumx= konumlar{d}(1:end,1);
%     konumy= konumlar{d}(1:end,2);
%     IMGrcopy(konumy,konumx,1)= 255;
%     IMGrcopy(konumy,konumx,2)= 0;
%     IMGrcopy(konumy,konumx,3)= 0;
%     
% end
% figure, imshow(IMGrcopy)



% %%
% for j=1:nesnesayisi % lif sınırlar çizilir
%    sinir= sinirlar{j};
%    plot(sinir(:,2),sinir(:,1),'c','LineWidth',2);
%       
% end
% hold off
% figure, imshow(B)
% hold off
% end
% 
% 
% 
% 
% % for k= 1:nesnesayisi % lif Çap ölçümü
% % sinir= sinirlar{k};
% % merkez=round(nesnealan(k).Centroid);
% % merkez(1)= merkez(1);
% % merkez(2)= merkez(2);
% % 
% % xmin= min(sinir(:,2));
% % ymin= min(sinir(:,1));
% % xmax= max(sinir(:,2));
% % ymax= max(sinir(:,1));
% % 
% % lifuzunluk= [lifuzunluk; abs(sqrt(((xmax-xmin)^2) - ((ymax-ymin)^2)))];
% % cap= [cap; (nesnealan(k).Area/lifuzunluk(k))*(olcu/olcu2pixel)];
% % text(merkez(1)-5,merkez(2)-5,sprintf('%.2f',cap(k)),'Color','r','FontWeight','bold','FontSize',8)
% % end
% 
% 
% 
% hold off