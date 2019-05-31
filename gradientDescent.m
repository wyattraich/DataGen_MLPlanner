function sim = gradientDescent(sim)
% clear all; close all; clc;
% sim.map = zeros([20 20]);
% sim.start_pos = [1 1];
% sim.goal_pos = [20 20];
% sim.map(2:end-1,2) = 1;
% sim.map(2,2:end-1) = 1;
% sim = fastMarch(sim);

trial = findNode(sim.nodes,sim.goal_pos);
sim.path_nodes = [trial];
done = 0;
while ~done
    neighbors = findNeighbors(sim.nodes,trial);
    neighbors = neighbors(~ismember(neighbors,sim.path_nodes));
%     [~,idx] = max( sim.cost_map(trial) - sim.cost_map(neighbors) );
    [~,idx] = min( sim.cost_map(neighbors) );
    if length(idx)>1
        idx = idx(round(rand*(length(idx)-1)+1));
    end
    trial = neighbors(idx);
    sim.path_nodes = [sim.path_nodes trial];
    
%     clear node_stat_fig
%     plotNodeStatus(alive_nodes,close_nodes,far_nodes,path_nodes,occ_nodes);
%     title('Descending gradient...')
%     drawnow
%     frames(end+1) = getframe(gca);
    
    if trial==findNode(sim.nodes,sim.start_pos)
        done = 1;
    end
end

% figure
% imagesc(sim.cost_map);
% set(gca,'YDir','normal');
% hold on
% plot(sim.nodes(1,sim.path_nodes),sim.nodes(2,sim.path_nodes),'k-','Linewidth',3)

end
