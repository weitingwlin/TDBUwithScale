%%  write in the XY coordinate for the 81 plants array, as my TDBU experiment
% And make figure to illustrate the  plots

XY=zeros(81,2);
%%
XY(1,:) = [80*cos(pi/3),   80*sin(pi/3)];
XY(2,:) = [78*cos(pi/3),   78*sin(pi/3)];
XY(3,:) = [78*cos(pi/3)+2, 78*sin(pi/3)];
XY(4,:) = [74*cos(pi/3),   74*sin(pi/3)];
XY(5,:) = [72*cos(pi/3),   72*sin(pi/3)];
XY(6,:) = [72*cos(pi/3)+2, 72*sin(pi/3)];
XY(7,:) = [74*cos(pi/3)+6, 74*sin(pi/3)];
XY(8,:) = [72*cos(pi/3)+6, 72*sin(pi/3)];
XY(9,:) = [72*cos(pi/3)+8, 72*sin(pi/3)];
XY(10,:) = [62*cos(pi/3),   62*sin(pi/3)];
XY(11,:) = [60*cos(pi/3),   60*sin(pi/3)];
XY(12,:) = [60*cos(pi/3)+2, 60*sin(pi/3)];
XY(13,:) = [56*cos(pi/3),   56*sin(pi/3)];
XY(14,:) = [54*cos(pi/3),   54*sin(pi/3)];
XY(15,:) = [54*cos(pi/3)+2,   54*sin(pi/3)];
%%
  XY(16:18,:) = XY(13:15,:) + repmat([6 0],3,1);
  XY(19:27,:) = XY(10:18,:) + repmat([18 0],9,1);
XY(28,:) = [26*cos(pi/3),   26*sin(pi/3)];
XY(29,:) =  [24*cos(pi/3),   24*sin(pi/3)];
XY(30,:) = [24*cos(pi/3)+2,   24*sin(pi/3)];
XY(31,:) = [20*cos(pi/3),   20*sin(pi/3)];
XY(32,:) = [18*cos(pi/3),   18*sin(pi/3)];
XY(33,:) = [18*cos(pi/3)+2,   18*sin(pi/3)];
   XY(34:36,:) = XY(31:33,:) + repmat([6 0],3,1);
%%
XY(37,:) = [8*cos(pi/3),   8*sin(pi/3)];
XY(38,:) = [6*cos(pi/3),   6*sin(pi/3)];
XY(39,:) = [6*cos(pi/3)+2,   6*sin(pi/3)];
XY(40,:) = [2*cos(pi/3),   2*sin(pi/3)];
XY(41,:) = [0,0];
XY(42,:) = [2, 0];
 XY(43:45,:) = XY(40:42,:) + repmat([6 0],3,1);
  XY(46:54,:) = XY(37:45,:) + repmat([18 0],9,1);
     XY(55:81,:) = XY(28:54,:) + repmat([54 0],27,1);
     
%% plot to check
save D_mat2 XY
plot(XY(:,1),XY(:,2),'ok','MarkerEdgecolor',mycolor(12),'MarkerFacecolor',mycolor(12),'MarkerSize',8)
for p=1:81
    text(XY(p,1)-0.1, XY(p,2)-0.1,num2str(p),'FontSize',8)
end
axis off
box off
hold on
%% Save  XY to CSV
csvwrite('D_mat2.csv', XY)

%% plot the dispersal kernal
figure

temp = [0:80]';
dist_temp=Euclidean_D(temp);
disp_tempH=disp_incidence(dist_temp,cH);
disp_tempP=disp_incidence(dist_temp,cP);
plot(0:80,0,'-k')
plot(dist_temp(1,:),disp_tempH(1,:)*200,'-b','Linewidth',2)
plot(dist_temp(1,:),disp_tempP(1,:)*200,'-r','Linewidth',2)
%% 
global H_thH H_thP dH dP dPz dHz np DispH DispP B

Hsim = 1: 200;
Hsim2 = 1:100;
D_RealH =   (  dHz + (dH ./ ( 1 + exp( -1 .* B .* ( Hsim - H_thH ) ) ) ) ) ./event;
D_RealP = (  (dP + dPz) - dP ./ ( 1 + exp(-1 .* B .* ( Hsim2- H_thP) )  ) ) ./event;
myplot(Hsim2, D_RealP, 'L'); hold on
myplot(30, 1/9 + dPz,'S', 1, 5); myplot(10, 4/11+ dPz,'S', 1, 5); 