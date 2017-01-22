% codes for plotting raw experimental data
clear;clc
load TDBU_expData
%%
figure
A=aphid;
im = imagesc(A); hold on
colormap(mycolormap(3));
im.AlphaData = .8;
colorbar
set(gca,'xtick', [], 'ytick', []);
            [r, c] = size(A);
    for i = 1 : r
            for j = 1 : c
                    mytext(j, i, num2str(A(i, j)), 7, 5);
            end
    end
% add gap    
    gap = setdiff(1:max(dayID), dayID);
    realgap = gap([2, diff(gap)]~=1); % "2" is the spaceholder for the first element
    newday = [];
    for j=1:length(realgap)
         temp = sum(dayID < realgap(j));
          vline( temp + 0.5 , [], [], 1);
          newday = [newday temp+1 ];
    end 
    % 9-plant sets
    for s = 1:8
        hline(s*9 + 0.5, 1, [], 1);
    end
    % texts
mytext(0, 82,  'Day', 10, 9 );
  dayloci = [1 2 3 4 newday length(dayID)];
        xnames = {};
        for i=1:length(newday)
                xnames{i} = num2str(dayID(newday(i))); 
        end
  daytext = {'1', '2', '3', '...', xnames{:}, num2str(dayID(end))};
  for d = 1:length(dayloci)
      mytext(dayloci(d), 82, daytext(d), 10, 8);
  end
mytext(0, 0,  'Plant', 10, 3 );
    plantloci = [1 2 3 4 5 6 10 19 28 37 46 55 64 73 81];
    planttext = {'1', '2', '3', '.','.', '.', '10', '19', '28', '37', '46', '55', '64', '73', '81'};
 for p = 1:length(plantloci)
      mytext(0, plantloci(p), planttext(p), 10, 6);
 end
  set(gca, 'linewidth', 1.5)
%%
figure
L=ladybug;
im = imagesc(L); hold on
colormap(mycolormap(2));
im.AlphaData = .8;
hcb = colorbar;
set(hcb,'YTick', [0 1 2]);
 set(gca,'xtick', [], 'ytick', []);
            [r, c] = size(L);
    for i = 1 : r
            for j = 1 : c
                    mytext(j, i, num2str(L(i, j)), 7, 5);
            end
    end
 for j=1:length(realgap)
          vline(sum(dayID < realgap(j)) + 0.5, [], [], 1);       
 end 
    
 % 9-plant sets
    for s = 1:8
        hline(s*9 + 0.5, 1, [], 1);
    end
% texts
mytext(0, 82,  'Day', 10, 9 );
  dayloci = [1 2 3 4 newday length(dayID)];
        xnames = {};
        for i=1:length(newday)
                xnames{i} = num2str(dayID(newday(i))); 
        end
  daytext = {'1', '2', '3', '...', xnames{:}, num2str(dayID(end))};
  for d = 1:length(dayloci)
      mytext(dayloci(d), 82, daytext(d), 10, 8);
  end

mytext(0, 0,  'Plant', 10, 3 );
    plantloci = [1 2 3 4 5 6 10 19 28 37 46 55 64 73 81];
    planttext = {'1', '2', '3', '.','.', '.', '10', '19', '28', '37', '46', '55', '64', '73', '81'};
 for p = 1:length(plantloci)
      mytext(0, plantloci(p), planttext(p), 10, 6);
 end
  set(gca, 'linewidth', 1.5)
