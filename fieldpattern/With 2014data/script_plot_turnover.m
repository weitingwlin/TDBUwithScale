style = [];
style.barcolor = mycolor(1);
style.BarOn = 1;
texts = [];
texts.xlabels = {'Aphids','Ladybugs'};
%%
% figure
subplot(6,2, [1 3 ])
texts.ylabel ='Patch Occupancy Rate'
myplot_bar([occA' occL'], style, texts)
text(-0.3, 1.05, 'a', 'FontSize',16)
axis([0 3 0 1])
%%
% figure
subplot(6, 2, [5 7 ])
texts.ylabel ='Per capita Colonization Rate';
myplot_bar([Adetail. perCapitaAdjTS' Ldetail. perCapitaAdjTS'], style, texts)
axis([0 3 0 0.5])
text(-0.3, 5.05, 'b', 'FontSize',16)
text(1, 0.2, num2str(stroutAind.m,3), 'Fontsize',14, 'HorizontalAlignment', 'center')
text(1, 0.1, ['(SE : ' num2str(stroutAind.SE,3) ')'], 'Fontsize',14, 'HorizontalAlignment', 'center')

%%
% figure
subplot(6, 2, [9 11 ])
texts.ylabel ='Net Colonization Rate';
myplot_bar([Adetail.perPatchTS' Ldetail.perPatchTS'], style, texts)
axis([0 3 0 0.4])
text(-0.3, 0.43, 'c', 'FontSize',16)