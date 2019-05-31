function neighbors = findNeighbors(nodes,lonely_nodes)

% neighbors = [];
% for ii=1:length(nodes)
%     for jj=1:length(lonely_nodes)
%         if rms(nodes(ii)-nodes(lonely_nodes(jj)))<=1
%             neighbors = [neighbors ii];
%             if length(neighbors)>length(nodes)
%                 error('Something`s wrong')
%             end
%         end
%     end
% end
% neighbors = neighbors(~ismember(neighbors,lonely_nodes));
neighbors = [];
for ii=1:length(lonely_nodes)
neighbors = [neighbors ...
    find(rssq(nodes-nodes(:,lonely_nodes(ii)),1)<=sqrt(2)+0.001)];
end
neighbors = neighbors(~ismember(neighbors,lonely_nodes));

end