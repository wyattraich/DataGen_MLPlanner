function [ map,start,goal ] = mapGen( size_in, density_in)
%generates random map of 0's 1's representing freespace and obstacles.
%outputs vehicle map and valid start/goal poses

map = 255*zeros(size_in,size_in);% i
num_black = 0;

while (num_black < (size_in^2)/density_in) %if the amount of obstacles is suitable
    
    low_bound = 1;
    up_bound = size_in/5;
    
    rand_dim1 = uint8((up_bound-low_bound).*rand(1,1) + low_bound);
    rand_dim2 = uint8((up_bound-low_bound).*rand(1,1) + low_bound);
    
    black = 255*ones(rand_dim1,rand_dim2);
    
    size_b = size(black);
    
    x_low_bound = size_b(1)/2;
    x_up_bound = size_in - size_b(1)/2;
    
    x_bound =  uint8((x_up_bound-x_low_bound).*rand(1,1) + x_low_bound);
    
    y_low_bound = size_b(2)/2;
    y_up_bound = size_in - size_b(2)/2;
    
    y_bound = uint8((y_up_bound-y_low_bound).*rand(1,1) + y_low_bound);
    
    map(x_bound+rand_dim1-size_b(1):x_bound+rand_dim1+size_b(1),y_bound+rand_dim2-size_b(2):y_bound+rand_dim2+size_b(2))=255;
    
    num_black = num_black + size_b(1)*size_b(2);
    
end

map = map(1:size_in,1:size_in); %resize map to size
map = map./255; %normalize map %binary matrix map


start = [0,0,0];
goal = [0,0,0];

while(pdist([start(1:2);goal(1:2)])<3)
    start = [[randi([1,size_in]),randi([1,size_in])], 0]; %random initial start
    goal  = [[randi([1,size_in]),randi([1,size_in])], 0]; %random initial goal

    start_bool = 0;
    goal_bool = 0;
    while( start_bool == 0)   
        start(1) = randi([1+1,size_in-1]);
        start(2) = randi([1+1,size_in-1]);   

        if(map(start(2),start(1)) == 1)
            start_bool = 0;
        end
        if(map(start(2),start(1)) == 0)
            start_bool = 1;
        end

    end

    while( goal_bool == 0)   
        goal(1) = randi([1+1,size_in-1]);
        goal(2) = randi([1+1,size_in-1]);  

        if(map(goal(2),goal(1)) == 1)
            goal_bool = 0;
        end
        if(map(goal(2),goal(1)) == 0)
            goal_bool = 1;
        end
    end
end

% figure()
% imagesc(~map)
% hold on
% plot(start(1),start(2),'r*')
% plot(goal(1),goal(2),'b*')

ck = 1;
end

