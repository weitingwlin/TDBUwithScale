%% make plot for elements in the model like dispersal kernel, can be used in presentation
clear;clc
script_parameters
%% plot dispersal incidence
figure
        distX = 0: 0.5: 80; % example of distance between patches
        incP = exp((-1) *cP * distX .* ones(size(distX))); % relative incidence
        incH = exp((-1) *cH * distX .* ones(size(distX))); 
    myplot(distX, incH, 'L', 2); hold on
    myplot(distX, incP, 'L', 3);
        xlabel('Distance between patches')
        ylabel('Relative settlement rate')
        legend('Aphid (c_H = 0.1)','Ladybug (c_P = 0.2)' )
    vline(2);
    vline(6);
    vline(18)
    vline(54)
%% Directed dipersal
figure 
    X = [ 0 : 150 ];% the aphid population
    D_RealH =    dHz  +  (dH ./ (1 + exp(-1 * B * ( X - H_thH) )) );
    D_RealP =   (dPz + dP) - dPz ./  ( 1 + exp(-1 * B * ( X - H_thP) )  ) ;


% aphid
myplot(X,D_RealH,'L',2);hold on
%ladybug
myplot(X,D_RealP,'L',3)
% vline(H_thH)
%hline(dH)
myplot(X,D_RealH,'L',2);
xlabel('H_i_,_t (herbivore population)')
ylabel('Dispersal rate')
legend('Aphid (Herbivore)','Ladybug (Hredator)')

    
%% plot the dispersal kernal
figure

disp_tempH=disp_incidence(Dist,cH, ones(size(Dist)));
disp_tempP=disp_incidence(Dist,cP, ones(size(Dist)));
% plot(0:80,0,'-k')
myplot(Dist(19,:),disp_tempH(19,:),'S',2); hold on
myplot(Dist(19,:),disp_tempP(19,:),'S',3)
legend('Aphid','Ladybug')

%% plot for functional response
% + gH*xt(i,1)*(KH - xt(i,1))/KH - eP*xt(i,1)*xt(i,2)/(xt(i,1) + H_0) - mHi*xt(i,1); 
A = [0 : 150]; % space of possible population size t=n
B = A + gH.*A.*(KH - A)./KH - eP.*20*A./(A + H_0) ;% population size t = n+1; with 1 predator
C = A + gH.*A.*(KH - A)./KH ; % without predator
myplot(A, B ,'S') ; hold on
myplot(A,C, 'S',4)
myplot(A,A, 'L',7)
for i = 1:sum(B>0)
myplot([A(i) A(i)] , [B(i) B(i)-mP*stoc_mP*A(i)],'L',28)
myplot([A(i) A(i)] , [C(i) C(i)-mP*stoc_mP*A(i)],'L',12)
end
legend('H_t_+_1 w/ 1 predator','H_t_+_1 w/o  predator', 'isocline','Stochastic mortalisty' ,'')
xlabel('H_t')
ylabel('H_t_+_1')
%% close up of functional response
A = [0:20];
B = A + gH.*A.*(KH - A)./KH - eP.*20*A./(A + H_0) ; % with one predator
C = A + gH.*A.*(KH - A)./KH ; % without predator
myplot(A, B ,'S') ; hold on
myplot(A,C, 'S',4)
myplot(A,A, 'L',7)
myplot(A,repmat(1,1,length(A)),'L',2)
for i = 1:sum(B>0)
myplot([A(i) A(i)] , [B(i) B(i)-mP*stoc_mP*A(i)],'L',28)
myplot([A(i) A(i)] , [C(i) C(i)-mP*stoc_mP*A(i)],'L',12)
end
legend('H_t_+_1 w/ 1 predator','H_t_+_1 w/o  predator', 'isocline','Danger Zone','Stochastic mortalisty' ,'')
xlabel('H_t')
ylabel('H_t_+_1')
title('Close up')
