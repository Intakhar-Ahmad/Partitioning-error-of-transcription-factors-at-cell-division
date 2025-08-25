%Used to draw normal distribution 
%load simulation?.mat
ex_data = 0.3135;
mu = mean(simulationData);
s = std(simulationData);
f = gauss_distribution(simulationData,mu,s);
f1 = gauss_distribution(ex_data,mu,s);
figure,plot(simulationData,f,'.');
hold on
plot(ex_data,f1,'r*');