%to test the distribution logic
clear all
disp('How many molecules you want to test?');
CM = input('Entre number + press entre:');
disp('select you case');
disp('1.equally distributed between two daughter cells');
disp('2.binomially distributed between two daughter cells');
disp('3.distributed following the hitchhiking machanism');
selection = input('Enter a number according to your case + press entre:');
mycase = selection;
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