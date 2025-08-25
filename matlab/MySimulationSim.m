% the simualtion script
clear all
clc
%Initialization of Variables
basename = 'simulation';
ext = '.mat';

%disp('How many hours do you want to run the experiment?');
%myDT = input('Entre number + press entre:');
myDT=100;
%disp('select you case');
%disp('1.equally distributed between two daughter cells');
%disp('2.binomially distributed between two daughter cells');
%disp('3.distributed following the hitchhiking machanism');
%selection = input('Enter a number according to your case + press entre:');
selection=1;

totalSim = 1000;
simulationData = zeros(1,totalSim);
for simNo = 1:totalSim
DT=myDT*60;%Experiment duration(minitutes)
RT=0;%Experimental run time initialization
CA=0;%Cell Age initialization
%CM=round(2 + 1.*rand);%Number of Molecule in the cell to start with
CM=0;
%Tr=0;%Initalization of Replication point of a cell
%Td=0;%Initalization  of Division point of a cell
Td=24 + 3.*randn;
Tr=6.8;
Gn=0;%Generation number initialization
M=0;%initilize the number of molecules in mother cell
D1=0;%initilize the number of molecules in one daughter cell
D2=0;%initilize the number of molecules in other daughter cell
molecule=2.5;%2 molecules are produces per generation(~24 min) on average

k= 0.0867;%change depending on the data

A1=zeros(1000000,6);%Result matrix initialization(M,D1,D2,Tr,Td,CA)
index = 1;%initilize the index value fot the result matix
A1(index,5)=Td;
A1(index,4)=Tr;
B1=zeros(10000000,1);
deltcount=1;
%Main Loop

while RT < DT
%time opint generation
r=rand;
delt= -log(1-r)/k;%Production of new molecules 
RT = RT + delt;
B1(deltcount,1)=delt;
deltcount=deltcount+1;

CA=CA+delt;%incriment of the cell age

if (CA <= Tr) 
    CM=CM+1;%condition for the molecule production before replication point
elseif (CA >Tr && CA < Td)
    CM=CM+1;
   
    k=0.0434;

elseif (CA >= Td)%condition after division
  
    k= 0.0867;
   
    Td=24 + 3.*randn;% 24 mins of normallly distributed time/generation
    A1(index+1,5)=Td;
    Tr=6.8;
    A1(index+1,4)=Tr;
    deltSum=CA;
    A1(index,6)=deltSum;%summation of delt for a perticular generation
    CA=0;
    mycase = selection;
    
    %ways of distribution
    
switch mycase 
   case 1 
  dummy1=rand;
  if dummy1 <=0.5;%makes a random choice
  D1= round(CM/2);
  D2 = CM-D1;
  M=D1+D2;
  else
  D2= round(CM/2);
  D1 = CM-D2;
  M=D1+D2;
  end
    case 2
  dummy2 = rand(CM,1);%generate random number
  mol_D1 = (dummy2 >= 0.5);%makes binary depeding on the threshold
  D1= sum(mol_D1);
  D2 = CM - D1;
  M=D1+D2;
    case 3
     if CM == 1 || CM == 2
  dummy99 = rand(CM,1);
  mol_D1 = (dummy99 >= 0.5);
  D1= sum(mol_D1);
  D2 = CM - D1;
  M=D1+D2;
elseif CM == 3 || CM == 4
     dummy98=rand;
     if dummy98 <=0.5;
     D1= round(CM/2);
     D2 = CM-D1;
     M=D1+D2;
     else
     D2= round(CM/2);
     D1 = CM-D2;
     M=D1+D2;
     end
  elseif CM > 4
    D1_p1 = 2;
    D2_p1 = 2;
    rest = CM - 4;
    dummy97 = rand(rest,1);
    mol_p2D1 = (dummy97 >= 0.5);
    D1_p2= sum(mol_p2D1);
    D2_p2 = rest - D1_p2;
    D1 = D1_p1 + D1_p2;
    D2 = D2_p1 + D2_p2;
    M=D1+D2;
    end
        otherwise
        disp('wrong case selection so,weird result'); 
        
end

dummy6 = rand; %random selsection of a cell for next round
if dummy6 <=0.5;
CM = D1;
else
CM = D2;
end
  Gn=Gn+1;
  A1(index,1)=M;%updata the matix,m_for 1stCol,D1 for 2ndCol,D2 for 3rdCol
  A1(index,2)=D1;
  A1(index,3)=D2;
  index = index + 1;
end
  resultM =A1(1:Gn,1);
  resultD1=A1(1:Gn,2);
  resultD2=A1(1:Gn,3);
  FinalResultMatrix=[resultM resultD1 resultD2];


end %ends the while loop
%Result of the simulation
A=[A1(1:Gn,1) A1(1:Gn,2) A1(1:Gn,3) A1(1:Gn,4) A1(1:Gn,5) A1(1:Gn,6)];
%matix of the time points of new molecule generation
B=B1(1:deltcount-1,1);
%figure
%hist(B,20)
%xlabel('Delt points in min')
%ylabel('Frequency')
%figure
%hist(A(:,5),20)
%xlabel('Division points in min')
%ylabel('Frequency')
%figure
%hist(A(:,6),20)
%xlabel('delt Sum for a generation in min')
%ylabel('Frequency')
%plotting the result matix(D1,D2)

U=zeros(9,9);
P1=FinalResultMatrix;
N1=P1(:,2);
N2=P1(:,3);
NNa=max(N1);
NNb=max(N2);
if (NNa>NNb)
    NN=NNa;
else NN=NNb;
end
for i=0:NN
    for j=0:NN

        Na=N1==i & N2==j;
        U(i+1,j+1)=sum(Na);%counts the different combinations of D1 and D2

    end
end
Ua=sum(U);%sum of all the col in U matrix
Ub=sum(Ua);%Sum of all the values in U matix
Un=U/Ub;%U matrix weighed against Ub value

%figure
%bar3(Un)
%xlabel('Daughter 1')
%ylabel('Daughter 2')
mean(FinalResultMatrix,1);

% the variation calculation
res = (FinalResultMatrix(:,2) - FinalResultMatrix(:,3)).^2;
res1= FinalResultMatrix(:,1);
%Cu=[res res1];
res2 = res(res1~=0)./(res1(res1~=0));
res3 = sum(res2);
res4 = res3/size(FinalResultMatrix,1);

simulationData(1,simNo) = res4;

%  simNoStr = num2str(selection);
%  filename=[basename simNoStr ext];
 
%  save(filename,'U');
end

selectionStr = num2str(selection);
filename=[basename selectionStr ext];
save(filename,'simulationData');