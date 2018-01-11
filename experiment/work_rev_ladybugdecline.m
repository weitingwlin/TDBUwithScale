% trim to remove decline in ladybug population
L81 = sum(ladybug); % total ladybeetle population
D_in = ones(D, 1); % who should stay
thresh = 3;
decline = diff(L81)<0; % 
for i =1: D-3 % for each interval d~d+1
      frame =  decline(i: i+thresh-1); % a frame of three intervals
      if all(frame) % decline  in three day consecutively, remove the third day
            D_in(i+thresh) = 0; 
      end
end
%%
D_in = L81>2;

%%
ladybug1 = ladybug(:, D_in > 0);% ladybug2 = ladybug(:,18:end);
aphid1 = aphid(:, D_in > 0);   %     aphid2 = aphid(:, 18:end);
dayID1=dayID(D_in > 0);      %  dayID2=dayID(18:end);
%%
sh = 10000;
figure
tic 
TDBU1 =   TDBU_bootstrap_logreg_diff(aphid1, ladybug1, dayID1,sh,1);
toc
%%
figure
mysubplot(6,1, 0, {'Remove days ladybeetles declined', '> 3 consecutive days'})
TDBU_plot(TDBU1)
figure
mysubplot(6,1, 0, {'Remove days ladybeetles declined', '> 3 consecutive days'})
TDBU_diff_plot(TDBU1)
%%
figure
mysubplot(3,1, 0, {'Remove days ladybeetles declined', '> 3 consecutive days'})
[~,~,~] = TDBU_trend_plot(aphid1, ladybug1, dayID1);
