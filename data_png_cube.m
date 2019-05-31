%% Wyatt Raich
% change matrix data to rgb png

clear all
close all

load('map.mat')
load('path.mat')

%549 is bad and so is 131
map(:,:,131) = map(:,:,130);
map(:,:,549) = map(:,:,548);

path(:,:,131) = path(:,:,130);
path(:,:,549) = path(:,:,548);

sz_in = size(map(:,:,1));

for i = 1:length(map)
    
    img_map = zeros(sz_in(1),sz_in(2),3);
    img_path = zeros(sz_in(1),sz_in(2),3);
    img_both = zeros(sz_in(1),2*sz_in(2),3);
   
    c_map = map(:,:,i);
    c_path = path(:,:,i);
    
    red_ind = find(c_map == 1);
    blue_ind = find(c_map == 0.5);
    
    img_map(red_ind) = 1;
    img_map(blue_ind+(2*sz_in(1)^2)) = 1;
    
    %figure()
    %imshow(img_map)
    
    img_map_big = imresize(img_map,[256, 256],'nearest');
    
    file_map = sprintf('map_cube/m_%d.png',i);
    imwrite(img_map_big, file_map);
    
    % deal with green overlapping blue at start and end
    green_ind = find(c_path == 0.5);
    duplicate = ~ismember(green_ind,blue_ind);
    green_ind = duplicate.*green_ind;
    remove = find(green_ind == 0);
    green_ind(remove) = [];
    
    %change path to rgb
    img_path(red_ind) = 1; 
    img_path(blue_ind+(2*sz_in(1)^2)) = 1;
    img_path(green_ind+(sz_in(1)^2)) = 1; 
    
    img_path_big = imresize(img_path,[256, 256],'nearest');
    
    %figure()
    %imshow(img_path)
    
    file_path = sprintf('path_cube/p_%d.png',i);
    imwrite(img_path_big, file_path);   
    
    img_both(:,1:sz_in(2),1) = img_map(:,:,1);
    img_both(:,sz_in(2)+1:2*sz_in(2),1) = img_path(:,:,1);
    
    img_both(:,1:sz_in(2),2) = img_map(:,:,2);
    img_both(:,sz_in(2)+1:2*sz_in(2),2) = img_path(:,:,2);
    
    img_both(:,1:sz_in(2),3) = img_map(:,:,3);
    img_both(:,sz_in(2)+1:2*sz_in(2),3) = img_path(:,:,3);
   
    img_both_big = imresize(img_both,[256, 512],'nearest');
    
    %figure(2)
    %imshow(img_both)
    
    file_both = sprintf('both_cube/b_%d.png',i);
    imwrite(img_both_big, file_both);
    
end