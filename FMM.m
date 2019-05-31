function [sim,map_sg,map_sgp] = FMM(varargin)

clear all; close all; clc;

sim.units = 'm';

for ii=1:nargin
    switch ii
        case 1 % map
            if isnumeric(varargin{ii})
                sim.map = varargin{ii};
            elseif isstring(varargin{ii}) || ischar(varargin{ii})
                sim.map = load(varargin{ii});
            end
        case 2 % start_pos
            sim.start_pos = varargin{ii};
        case 3 % goal_pos
            sim.goal_pos = varargin{ii};
        case 4 % does nothing rn
            sim.units = varargin{ii};
    end
end
                

% sim.map = load('map1.txt');
% sim.start_pos = [1 1];
% sim.goal_pos = [5 6];

% Make map 
% sim.map = zeros([20 20]);
% sim.map(2:end-1,2:end-12) = 1;
% sim.map(2:end-5,2:end-1) = 1;
% sim.start_pos = [1 1];
% sim.goal_pos = [20 20];


[ map,start,goal ] = mapGen(20, 20);
sim.map = map;
sim.start_pos = start;
sim.goal_pos = goal;

% manipulate data
map_sg = sim.map;%255.*sim.map;
map_sg(sim.start_pos(2),sim.start_pos(1)) = 0.5;
map_sg(sim.goal_pos(2),sim.goal_pos(1)) = 0.5;

%figure()
%imshow(map_sg)



sim = initSim(sim);

%%{
sim = buildEsdf(sim,1);

for ii=1:numel(sim.map)
    if sim.esdf(ii) == 0
        sim.speed_map(ii) = 0;
    else
%         sim.speed_map(ii) = (tanh(sim.esdf(ii)-exp(1))+1)/2; % slow-near-walls 
        sim.speed_map(ii) = 1; % constant speed (shortest path)
    end
end

sim = fastMarch(sim,sim.map,sim.start_pos,sim.goal_pos,0,1);

sim = gradientDescent(sim);

path = sim.path_nodes;
map_sgp = sim.map;

map_sgp(path) = 0.5;

%figure()
%imshow(map_sgp)


%{
figure
%imagesc(~sim.map);
imshow(sim.map);
title('Map')
set(gca,'YDir','normal');
hold on
plot(sim.nodes(1,sim.path_nodes),sim.nodes(2,sim.path_nodes),'r-','Linewidth',0.01)


plot(sim.start_pos(1),sim.start_pos(2),'cd',...
    'MarkerSize',0.1,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r');
plot(sim.goal_pos(1),sim.goal_pos(2),'md',...
    'MarkerSize',0.1,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r');

img = frame2im(getframe(gca));
img_bw = rgb2gray(img);

ck =1;


figure
imagesc(sim.cost_map);
title('Cost')
set(gca,'YDir','normal');
hold on
plot(sim.nodes(1,sim.path_nodes),sim.nodes(2,sim.path_nodes),'k-','Linewidth',3)
plot(sim.start_pos(1),sim.start_pos(2),'cd',...
    'MarkerSize',10,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor','g');
plot(sim.goal_pos(1),sim.goal_pos(2),'md',...
    'MarkerSize',10,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r');

figure
imagesc(sim.esdf);
title('ESDF');
set(gca,'YDir','normal');
hold on
plot(sim.nodes(1,sim.path_nodes),sim.nodes(2,sim.path_nodes),'k-','Linewidth',3)
plot(sim.start_pos(1),sim.start_pos(2),'cd',...
    'MarkerSize',10,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor','g');
plot(sim.goal_pos(1),sim.goal_pos(2),'md',...
    'MarkerSize',10,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r');

figure
imagesc(sim.speed_map);
title('Speed');
set(gca,'YDir','normal');
hold on
plot(sim.nodes(1,sim.path_nodes),sim.nodes(2,sim.path_nodes),'k-','Linewidth',3)
plot(sim.start_pos(1),sim.start_pos(2),'cd',...
    'MarkerSize',10,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor','g');
plot(sim.goal_pos(1),sim.goal_pos(2),'md',...
    'MarkerSize',10,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r');
%}
end
    

