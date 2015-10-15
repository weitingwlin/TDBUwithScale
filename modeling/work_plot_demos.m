%% make plot for elements in the model like dispersal kernel, can be used in presentation
load D_mat2
cP = 0.05;        % dispersal parameter c for H , small number means long distance travel
cH = 0.02;       % dispersal parameter c for P
Dist = Euclidean_D(XY); % X
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
%%
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
