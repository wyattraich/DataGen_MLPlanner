function cost_map = calcCost(nodes,sim,cost_map,speed_map,nodes_to_calc)
    map_y_size = size(sim.map,1);
    map_x_size = size(sim.map,2);
    h = 1;
    for ii=1:length(nodes_to_calc)
        this_node_to_calc = nodes_to_calc(ii);
        
        min_set = [];
        if nodes(1,this_node_to_calc)<map_x_size
            min_set_new = findNode(nodes,nodes(:,this_node_to_calc)+[1 0]');
            min_set = [min_set min_set_new];
        end
        if nodes(1,this_node_to_calc)>1
            min_set_new = findNode(nodes,nodes(:,this_node_to_calc)+[-1 0]');
            min_set = [min_set min_set_new];
        end
        uh = min(cost_map(min_set));
        
        min_set = [];
        if nodes(2,this_node_to_calc)<map_y_size
            min_set_new = findNode(nodes,nodes(:,this_node_to_calc)+[0 1]');
            min_set = [min_set min_set_new];
        end
        if nodes(2,this_node_to_calc)>1
            min_set_new = findNode(nodes,nodes(:,this_node_to_calc)+[0 -1]');
            min_set = [min_set min_set_new];
        end
        uv = min(cost_map(min_set));
        
        if abs(uh-uv)<h/speed_map(this_node_to_calc)
            this_u = 0.5*( uh + uv + sqrt( (uh+uv)^2 - 2*(uh^2+uv^2-h^2/speed_map(this_node_to_calc)^2) ) );
        else
            this_u = min(uh,uv)+h/speed_map(this_node_to_calc);
        end
        
        if this_u < cost_map(this_node_to_calc)
            cost_map(this_node_to_calc) = this_u;
        end
    end
end