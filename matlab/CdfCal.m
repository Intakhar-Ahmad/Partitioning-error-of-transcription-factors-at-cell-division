%CDF calculation
%load simulation?.mat
mypoint=0.3135;% withIPTG=0.3376 and without IPTG=3135
prob1 = cdf('Normal',simulationData,mean(simulationData),std(simulationData));
prob2 = cdf('Normal',mypoint,mean(simulationData),std(simulationData));
plot(simulationData,prob1,'*')
hold on
plot(mypoint,prob2,'r*')
ind = prob1 < prob2;
sum(prob1(ind))/(sum(prob1))