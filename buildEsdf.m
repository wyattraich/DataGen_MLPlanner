function sim = buildEsdf(sim,en_borders)

% sim.map = zeros([20 20]);
% sim.map(2:end-1,2) = 1;
% sim.map(2,2:end-1) = 1;
% sim.occ_nodes = find(sim.map);
% esdf = zeros(size(sim.map));
% Nnodes = numel(sim.map);
% all_nodes = 1:Nnodes;
% sim.nodes = zeros(2,Nnodes);
% nodes(1,:) = idivide(int32(all_nodes)-1,int32(size(sim.map,1)))+1;
% nodes(2,:) = mod(all_nodes-1,size(sim.map,2))+1;
% figure

sim.esdf = zeros(size(sim.map));
for ii=1:numel(sim.map)
    if ismember(ii,sim.occ_nodes)
        continue;
    end
    
    start_pos = sim.nodes(:,ii);
    goal_pos = [nan nan];
    if ii==13
        1;
    end
    sim = fastMarch(sim,sim.map,start_pos,goal_pos,en_borders);
    sim.esdf(ii) = sim.goal_dist;

%     imagesc(sim.esdf)
end

end
