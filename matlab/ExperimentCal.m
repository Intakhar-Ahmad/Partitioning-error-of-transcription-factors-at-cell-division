% calculation of the variation in a experiment
res = (data(:,2) - data(:,3)).^2;%absolute difference in two daughters
res1= data(:,1);%number of molecules in mother cell
%VarM=[res res1];%Mother cell and distribution variation
res2 = res(res1~=0)./(res1(res1~=0));
res3 = sum(res2);%sum all the vation
res4 = res3/size(data,1);%normalize by the number of mother cells
V=res4%variance is a perticular experiment
