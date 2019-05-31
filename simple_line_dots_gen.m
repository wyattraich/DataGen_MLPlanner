% Wyatt Raich

close all; clear all

size = 256;

%% Start and Goal
start = [0,0];
goal = [0,0];
vec = [start;goal];
dist = pdist(vec,'euclid');

for i = 1:150
    
    close all
    
    start = [0,0];
    goal = [0,0];
    vec = [start;goal];
    dist = pdist(vec,'euclid');
    
    
    while (dist < 100)
        start = [randi([25,231]), randi([25,231])];
        goal = [randi([25,231]), randi([25,231])];
        vec = [start;goal];
        dist = pdist(vec,'euclid');
    end

    RGB(start(1),start(2),3) = 1;
    RGB(goal(1),goal(2),3) = 1;

    %% Map without path
    figure()
    plot(start(1),start(2),'b.','MarkerSize',200)
    hold on
    plot(goal(1),goal(2), 'b.','MarkerSize',200)
    xlim([0,256])
    ylim([0,256])
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    pbaspect([1 1 1])

    imgm = frame2im(getframe(gca));
    imgm = imresize(imgm, [size size],'nearest');
    file = sprintf('map_simp/%d.png',i);
    imwrite(imgm, file);

    %figure()
    %imshow(imgm)

    %% Map with Path
    figure()
    plot([start(1),goal(1)],[start(2),goal(2)],'g','Linewidth',50)
    hold on
    plot(start(1),start(2),'b.','MarkerSize',200)
    plot(goal(1),goal(2), 'b.','MarkerSize',200)
    xlim([0,256])
    ylim([0,256])
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    pbaspect([1 1 1])

    imgp = frame2im(getframe(gca));
    imgp = imresize(imgp, [size size],'nearest');
    file = sprintf('path_simp/p_%d.png',i);
    imwrite(imgp, file);

    %figure()
    %imshow(imgp)

    %% Both
    img_both(:,1:256,:) = imgp;
    img_both(:,257:512,:) = imgm;

    %figure()
    %imshow(img_both)

    file_both = sprintf('both_simp/b_%d.png',i);
    imwrite(img_both, file_both);
    
end

ck =1;

       