%calculates the rate befor and after replication of lacI
mpg=1.7864;%molecule pergeneration(With IPTG=2.4190,without IPTG = 1.7864)
km=mpg/24;%generation time is 24 min
tr=6.8;%Replication point is 6.8 min after birth
td=24;%generation time corresponds to division time
k1=km/((tr/td)+2*((td-tr)/td))
k2=k1*2