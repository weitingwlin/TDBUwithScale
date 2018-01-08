% work: 
% after running run_iva_6.m
%% Permutation setting
sh=1000; % time of permutation
%%
tic
    TDBUsim = TDBU_bootstrap(sim_A, sim_L, sim_D, sh, 1); % sample  with replacement
toc
%% Making figure (using myplot_CI)
figure
subplot(5,1,[1 2])
        mytexts=[];
                mystyle.limcolor =mycolor(4,'gray'); 
        mystyle.limwidth = 5;
        mystyle.midcolor = mycolor(1);% = mycolor(2,:);
          mytexts.title ='Top-Down effects';
               mytexts.ylabel = 'R_T_D';
%%%%%%%%%%%%%%
myplot_CI((-1)*TDBUsim.real(1,:), (-1)*TDBUsim.ciTD, (-1)*TDBUsim.medTD, 4, mytexts, mystyle);
%%%%%%%%%%%%%%
subplot(5,1,[3 4])
        mytexts=[];
        mytexts.title ='Bottom-Up effects';
            mytexts.ylabel = 'R_B_U';
%%%%%%%%%%%%%%
myplot_CI(TDBUsim.real(2,:), TDBUsim.ciBU, TDBUsim.medBU, 4, mytexts, mystyle);
%%%%%%%%%%%%%%
subplot(5, 1, 5)
text(0.1,1, ['cP = ' num2str(cP)  ';        dPz = ' num2str(dPz) ';      dP + dPz = ' num2str( dP + dPz)] )
text(0.1,0.7, ['aP = ' num2str(aP) ';     eP = ' num2str(eP) ';        BDofP = ' num2str(withBDofP)])
text(0.1, 0.3, ['initial = ' num2str(ittInit) ';    sh = ' num2str(sh)] )
text(0.1, 0, ['resTD: ' num2str(TDBUsim.resTD,4)] )
text(0.1, -0.3, ['resBU: ' num2str(TDBUsim.resBU,4)] )
axis off
box off
