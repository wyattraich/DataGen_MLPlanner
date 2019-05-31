%% Wyatt Raich
% change matrix data to rgb png

clear all
close all

load('map.mat')
load('path.mat')
load('sims.mat')

%sims(78) = sims(77);
%sims(86) = sims(86);
sims(37) = sims(433);
sims(47) = sims(1);
%sims(49) = sims(230);

%549 is bad and so is 131
%map(:,:,131) = map(:,:,130);
%map(:,:,549) = map(:,:,548);

%path(:,:,131) = path(:,:,130);
%path(:,:,549) = path(:,:,548);

sz_in = size(map(:,:,1));

for i = 1:length(map)
    
    img_map = zeros(sz_in(1),sz_in(2),3);
    img_path = zeros(sz_in(1),sz_in(2),3);
    img_both = zeros(256,2*256,3);
   
    c_map = sims(i).map;
    %c_path = path(:,:,i);
    
    red_ind = find(c_map == 1);
    blue_ind = find(c_map == 0.5);
    
    img_map(red_ind) = 1;
    img_map(sims(i).start+(2*sz_in(1)^2)) = 1;
    img_map(sims(i).goal+(2*sz_in(1)^2)) = 1;
    
    img_map_big = imresize(img_map,[256, 256],'nearest');
    
    %figure()
    %imshow(img_map_big)
    
    file_map = sprintf('map_line/m_%d.png',i);
    imwrite(img_map_big, file_map);

    %change path to rgb
    img_path(red_ind) = 1; 
    img_path(sims(i).start+(2*sz_in(1)^2)) = 1;
    img_path(sims(i).goal+(2*sz_in(1)^2)) = 1;
    %img_path(green_ind+(sz_in(1)^2)) = 1;
    
    [x,y] = ind2sub(sz_in,sims(i).path_nodes);
    
    figure()
    imshow(img_path)
    hold on
    plot(y,x,'g','linewidth',1)
    set(gcf, 'Position',  [100, 100, 1000, 1000])
    
    img_path_pic = frame2im(getframe(gca)); 
    img_path_big = imresize(img_path_pic,[256, 256],'nearest');    
    img_path_small = imresize(img_path_pic,[20, 20],'nearest');
    
    %figure()
    %imshow(img_path_big)
    
    file_path = sprintf('path_line/p_%d.png',i);
    imwrite(img_path_big, file_path);   
    
    img_both(:,1:256,:) = img_path_big;
    img_both(:,257:512,:) = img_map_big;
    img_both(1,:,:) = 0;
    img_both(256,:,:) = 0;
    
    figure()
    imshow(img_both)
 
    file_both = sprintf('both_line/b_%d.png',i);
    imwrite(img_both, file_both);
    
    close all
    
end