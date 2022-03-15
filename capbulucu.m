
function [konumlar,mesafe,mesafe2] =capbulucu(A,aci)
% aci=60;
%  A=ENstrel(aci,50,5);
% imshow(A)

% [etiketler, nesnesayisi]= bwlabel(A,8);

% sinirlar= bwboundaries(etiketler);
%  nesnealan= regionprops(etiketler,'Area','Centroid');
%  lifmerkezler= nesnealan.Centroid(1,:);

cizgi=strel('line',30,aci+90);
capbulucueleman=cizgi.Neighborhood;
capbulucubilgi= regionprops(capbulucueleman,'Centroid');

% figure,imshow(capbulucueleman);


[satirc,sutunc]= size(capbulucueleman);
if ~islogical(A)
ABW= imbinarize(A);
else
    ABW=A;
end

etiketler= bwlabel(ABW,4);
lifmerkezler= regionprops(ABW,'Centroid');
konumlar= {};
for i=1:length(lifmerkezler)

    lifmerkez(i,1:2)=round(lifmerkezler(i).Centroid);
tempetiketler=etiketler==i;

x1=lifmerkez(i,1)-ceil(sutunc/2);
x2=x1+sutunc-1;
y1=lifmerkez(i,2)-ceil(satirc/2);
y2=y1+satirc-1;
% konumlar - olursa
if 0-x1>=0, x2=x2+1+(-x1); x1=1;  end

if 0-y1>=0, y2=y2+1+(-y1); y1=1;  end

%konumlar matristen taşarsa 
if x2>size(A,2), x1= x1-(x2-size(A,2)); x2=size(A,2); end
if y2>size(A,1), y1= y1-(y2-size(A,1)); y2=size(A,1); end

yerler=tempetiketler(y1:y2,x1:x2)+capbulucueleman(:,:);

[r,c]=find(yerler==2);
if isempty(r), continue; end    
mesafe(i)= sqrt((max(c)+1-min(c))^2 + (max(r)+1-min(r))^2);

mesafe2(i)= (max(r)+1-min(r))/sind(aci+90);
konumlar{i,1}= [x1-1+c y1-1+r]; 
end


% %%
% 
% for i=1:nesnesayisi
% lifmerkez(i,1:2)=lifmerkezler(i).Centroid
% x1(a)=lifmerkezler(a,1)- ceil(sutunc/2);
% x2(a)=x1(a)+sutunc-1;
% y1(a)=lifmerkezler(a,2)- ceil(satirc/2);
% y2(a)=y1(a)+satirc-1;
% end
% 
% % koordinatlar
% x1(1)=lifmerkezler(1,1)- ceil(sutunc/2);
% x2(1)=x1(1)+sutunc-1;
% y1(1)=lifmerkezler(1,2)- ceil(satirc/2);
% y2(1)=y1(1)+satirc-1;
% 
% for a=2:length(lifmerkezler)
% x1(a)=lifmerkezler(a,1)- ceil(sutunc/2);
% x2(a)=x1(a)+sutunc-1;
% y1(a)=lifmerkezler(a,2)- ceil(satirc/2);
% y2(a)=y1(a)+satirc-1;
% end
% 
% sutunfark= ceil(sutunc/2)-sutunc/2;
% satirfark= ceil(satirc/2)-satirc/2;
% 
% B(:,:,1)= uint8(A)*255;
% B(:,:,2)= uint8(A)*255;
% B(:,:,3)= uint8(A)*255;
% 
% for b= 1:length(x1)
% yerler=A(y1(b):y2(b),x1(b):x2(b))+capbulucueleman(:,:);
% % alfyerler= capbulucueleman(:,:)+A(x1(a):x2(a),y1(a):y2(a));
% [r,c]=find(yerler==2);
% for i= 1:length(r)
% B(y1(1)-1+r(i),x1(1)-1+c(i),1)=255;
% B(y1(1)-1+r(i),x1(1)-1+c(i),2)=0;
% B(y1(1)-1+r(i),x1(1)-1+c(i),3)=0;
% end
% mesafe(b)= sqrt((max(c)+1-min(c))^2 + (max(r)+1-min(r))^2);
% end
% end
% % [alfr,alfc]=find(alfyerler==2);
% % alfr=alfr+x1; alfc=alfc+y1;


% capbilgi= [r+x1-1 c+y1-1];
% imshow(A)
% B= uint8(A)*255;
% B(:,:,2)= B(:,:,1);
% B(:,:,3)= B(:,:,1);
% figure, imshow(B)
% r = [x1+-1+r];
%    c= [y1-1+c];
%    capbilgi= [r,c];


