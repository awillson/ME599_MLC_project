load smallExample 
nodeColors = {'g','b','r','c'}; % if too few specified, it will cycle through
edgeColors = {'Tom', 'Bill', 'r'
              'Bill' 'all' , 'g'};

graphViz4Matlab('-adjMat',adj,'-nodeLabels',names,'-layout',treelayout,'-nodeColors',nodeColors,'-edgeColors', edgeColors);
