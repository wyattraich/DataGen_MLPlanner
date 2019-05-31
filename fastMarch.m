% FAST MARCHING PSEUDOCODE
%
% 1 Assign every node x_i the value of U_i = +inf and label them as far;
% for all nodes x_i in dOmega set U_i=0 and label x_i as accepted.
% 2 For every far node x_i, use the Eikonal update formula to calculate a
% new value for U^hat. If U^hat < U_i then set U_i = U^hat and label x_i as
% considered.
% 3 Let x^hat be the considered node with the smallest value U. Label x^hat
% as accepted.
% 4 For every neighbor x_i of x^hat that is not-accepted, calculate a
% tentative value U^hat.
% 5 If U^hat < U_i then set U_i = U^hat. If x_i as labeled as far, update
% the label to considered.
% 6 If there exists a considered node, return to step 3. Otherwise,
% terminate.

function sim = fastMarch(sim,map,start_pos,goal_pos,en_borders,plot_march)
% testing setup
% clear all; close all; clc;
% % map = load('map1.txt');
% % start_pos = [1 1];
% % goal_pos = [5 6];
% map = zeros([20 20]);
% start_pos = [1 1];
% goal_pos = [20 20];
% goal_pos = [nan nan];
% map(2:end-1,2) = 1;
% map(2,2:end-1) = 1;

switch nargin
    case 5-1
        en_borders = 1;
    case 6-1
        plot_march = 0;
end

% setup loop
% setup variables
% Nnodes = numel(map);
% map_size = size(map);
% all_nodes = 1:Nnodes;
% occ_nodes = find(map);
if isnan(goal_pos(1)) || isnan(goal_pos(2))
    termination_mode = 0; % march to nearest obstacle
else
    termination_mode = 1; % march to specified goal_pos
end
% % setup list of nodes
% nodes = zeros(2,Nnodes);
% nodes(1,:) = idivide(int32(all_nodes)-1,int32(map_size(1)))+1;
% nodes(2,:) = mod(all_nodes-1,map_size(2))+1;
% % init start and goal
% start = findNode(nodes,start_pos);
% goal = findNode(nodes,goal_pos);
% % setup maps
% % speed_map = zeros(map_size);
% speed_map = ones(map_size);
% speed_map(occ_nodes) = 0;
% cost_map = zeros(map_size);
% cost_map(:) = Inf;
% cost_map(start) = 0;

accepted_nodes = findNode(sim.nodes,start_pos);
considered_nodes = [];
far_nodes = sim.all_nodes(~ismember(sim.all_nodes,[accepted_nodes considered_nodes]));

% figure
done = 0;
count = 0;
while ~done
    considered_nodes = findNeighbors(sim.nodes,accepted_nodes);
    
    % terminate at nearest obstacle
    if termination_mode==0 & ( sum(ismember(sim.occ_nodes,considered_nodes))>0 )
        goal_pos = sim.nodes(:,sim.occ_nodes(find(ismember(sim.occ_nodes,considered_nodes))));
        done = 1;
        continue;
    end
    
    far_nodes = sim.all_nodes(~ismember(sim.all_nodes,[accepted_nodes considered_nodes]));
    
    sim.cost_map = calcCost(sim.nodes,sim,sim.cost_map,sim.speed_map,considered_nodes);
    considered_costs = sim.cost_map(considered_nodes);
    
    [~,trial] = min(considered_costs);
    if length(trial)>1
        trial = trial(round(rand*(length(trial)-1)+1));
    end
    trial = considered_nodes(trial);
    [considered_nodes,accepted_nodes] = transferNode(trial,considered_nodes,accepted_nodes);
    
    % terminate at specified goal
    if termination_mode==1 & ismember(findNode(sim.nodes,goal_pos),considered_nodes)
        done = 1;
        continue;
    end
    
%     if mod(count,300)==0
    if plot_march
        %plotNodeStatus(sim.nodes,sim,accepted_nodes,considered_nodes,far_nodes,[],sim.occ_nodes);
        %drawnow()
    end
    
    count = count + 1;
end
% plotNodeStatus(nodes,sim,accepted_nodes,considered_nodes,far_nodes,[],occ_nodes);
% drawnow()
if plot_march
close(gcf)
end

% figure
% imagesc(cost_map);
% set(gca,'YDir','normal');
% 
% sim.nodes = nodes;
% sim.occ_nodes = occ_nodes;
% sim.cost_map = cost_map;

sim.goal_dist = min( rssq( start_pos - goal_pos ));

if en_borders
    border = combvec(0:sim.map_size(1)+1,0:sim.map_size(2)+1);
    border = border(:,~( sum( ismember(border,sim.nodes') ,1)>=2 ));
    for ii=1:max(size(border))
        if rssq( start_pos - border(:,ii) )<sim.goal_dist
            sim.goal_dist = rssq( start_pos - border(:,ii) );
        end
    end
    
end

end