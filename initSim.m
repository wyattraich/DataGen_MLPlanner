function sim = initSim(sim)
% required to be defined before calling this function
% sim.map
% sim.start_pos
% sim.goal_pos

% map
sim.map_size = size(sim.map);

% nodes
sim.all_nodes = 1:numel(sim.map);
sim.occ_nodes = find(sim.map);
sim.nodes = zeros(2,length(sim.all_nodes));
sim.nodes(1,:) = idivide(int32(sim.all_nodes)-1,int32(sim.map_size(1)))+1;
sim.nodes(2,:) = mod(sim.all_nodes-1,sim.map_size(2))+1;
sim.start = findNode(sim.nodes,sim.start_pos);
sim.goal = findNode(sim.nodes,sim.goal_pos);

% more maps
sim.speed_map = ones(sim.map_size);
sim.speed_map(sim.occ_nodes) = 0;
sim.cost_map = zeros(sim.map_size);
sim.cost_map(:) = Inf;
sim.cost_map(sim.start) = 0;

% termination mode
% if isnan(sim.goal_pos(1)) || isnan(sim.goal_pos(2))
%     sim.termination_mode = 0;
% else
%     sim.termination_mode = 1;
% end


end