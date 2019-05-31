function [from_vec,to_vec] = transferNode(node,from_vec,to_vec)

from_vec = from_vec(~ismember(from_vec,node));
to_vec = [to_vec node];