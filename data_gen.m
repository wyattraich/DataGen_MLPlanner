% generate 1000 images

close all; clear all;

for i = 1:1000
    
    [sim,map_sg,map_sgp] = FMM;
    
    sims(i) = sim;
    %map(:,:,i) = map_sg;
    %path(:,:,i) = map_sgp;
    %ESDF(:,:,i) = sim.esdf;
    %cost(:,:,i) = sim.cost_map;
    %speed(:,:,i) = sim.speed_map;

end

save('sims')
%save('map1.mat','map')
%save('path1.mat','path')
%save('ESDF1.mat','ESDF')
%save('cost1.mat','cost')
%save('speed1.mat','speed')

ck = 1;