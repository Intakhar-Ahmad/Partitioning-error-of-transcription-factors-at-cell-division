%to count the average molecule production
%clear all
%load('C:\Users\Intakhar\Documents\MATLAB\withIPTG.mat')
%load('C:\Users\Intakhar\Documents\MATLAB\withoutIPTG.mat')
m=mean(data(:,1));
d=[data(:,2); data(:,3)];
b=mean(d);
K=m-b;%how many molecules is produced per cell per generation
Ampg=K % Average molecule per generation is K
%we can use this K value in the kscript.m
%to make a figure if we like
%figure
%hist(data(:,1))
%figure
%hist(d);


