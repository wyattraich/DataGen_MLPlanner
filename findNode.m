function idx = findNode(nodes,node_pos)
    idx = [];
    for ii=1:length(nodes)
        if nodes(1,ii)==node_pos(1) & nodes(2,ii)==node_pos(2)
            idx = [idx ii];
        end
    end
end