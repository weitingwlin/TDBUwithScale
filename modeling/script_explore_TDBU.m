sh=100; % time of permutation; 'sh' for shuffleing
tic
TDBUsim = TDBU_bootstrap_logreg(simA, simL, simD, sh, 1); % sample  with replacement
toc
% expect end 3/1 1:am
%% Making figure (using myplot_CI)
figure
subplot(5,1,[1 2])
       mytexts = [];
        mystyle = [];
        mystyle.limcolor =mycolor(4,'gray'); 
        mystyle.midcolor = mycolor(1);% = mycolor(2,:);
        mystyle.midsize = 6 ;
         mytexts.title ='Effects of ladybeetles on aphids';
        mytexts.ylabel = 'R_T_D';
%%%%%%%%%%%%%%
myplot_CI((-1) * TDBUsim.real(1,:), (-1) * TDBUsim.ciTD, (-1) * TDBUsim.medTD, 4, mytexts, mystyle)

%%%%%%%%%%%%%%
subplot(5, 1, [3 4])
mytexts=[];
        mytexts.title ='Effects of aphids on ladybeetles';
        mytexts.ylabel = 'R_B_U';
        mytexts.xmark = {'1','3','9','27'};
%%%%%%%%%%%%%%
myplot_CI(TDBUsim.real(2,:),TDBUsim.ciBU,TDBUsim.medBU,4,mytexts, mystyle)
%%%%%%%%%%%%%%
subplot(5, 1, 5)
script_Gillespie_parameters
text(0.1,1, ['cP = ' num2str(cP)  ';        dPz = ' num2str(dPz) ';      dP + dPz = ' num2str( dP + dPz)  ' H_thP = ' num2str(H_thP )] );
text(0.1,0.7, ['aP = ' num2str(aP) ';     eP = ' num2str(eP) ';   exitp = ' num2str(exitP) '   B = ' num2str(B) '  mH = ' num2str(mH)])
text(0.1, 0.3, ['scenario: ' num2str(scen) ' ;   t = ' num2str(ts(1)) ' ~ ' num2str(ts(10))] )
%text(0.1, 0, note)
%text(0.1, 0, ['initial = ' num2str(ittInit) ';    sh = ' num2str(sh)] )
axis off
box off

print(['Data\testdP' num2str(scen) num2str(dP*10) 'alt2' ], '-dpng')