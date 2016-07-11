% Scripts to produce supplement figures: 
% example TS, example 'scaling up', effect of spider, effect of larva and other species

clear;clc
load TDBU_expData

%% create TS for 3-,9-,27-plant scales
data_L = ladybug;
data_A = aphid;
% prepare data sheets 
L_3=zeros(27,D);A_3=zeros(27,D);
L_9=zeros(9,D); A_9=zeros(9,D);
L_27=zeros(3,D); A_27=zeros(3,D);
%%%%%%%%%%%% 3-plant TS
for i=0:26
    ind=[i*3+1:i*3+3];
    L_3(i+1,:)=sum(data_L(ind,:));
    A_3(i+1,:)=sum(data_A(ind,:));
end
%%%%%%%%%%%%%% 9-plant TS
for i=0:8
    ind=[i*9+1:i*9+9];
    L_9(i+1,:)=sum(data_L(ind,:));
    A_9(i+1,:)=sum(data_A(ind,:));
end
%%%%%%%%%%%%%%% 27-plant TS
for i=0:2
    ind=[i*27+1:i*27+27];
    L_27(i+1,:)=sum(data_L(ind,:));
    A_27(i+1,:)=sum(data_A(ind,:));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculate temporal CV for each scale for two species
CV_L_27 = std(L_27')./mean(L_27');
CV_L_9 = std(L_9')./mean(L_9');
CV_L_3 = std(L_3')./mean(L_3');
CV_L_1 = std(data_L')./mean(data_L');

CV_A_27 = std(A_27')./mean(A_27');
CV_A_9 = std(A_9')./mean(A_9');
CV_A_3 = std(A_3')./mean(A_3');
CV_A_1 = std(data_A')./mean(data_A');
%% Plot
myplot(repmat(1,81,1), CV_A_1,'S'); hold on
myplot(repmat(1.2,81,1), CV_L_1,'S',2); hold on
myplot(1:4, [mean(CV_A_1(~isnan(CV_A_1))) mean(CV_A_3) mean(CV_A_9) mean(CV_A_27)],'L')
myplot([1:4]+0.2, [mean(CV_L_1(~isnan(CV_L_1))) mean(CV_L_3(~isnan(CV_L_3))) mean(CV_L_9(~isnan(CV_L_9))) mean(CV_L_27)],'L',2)

myplot(2, CV_A_3,'S');
myplot(3, CV_A_9,'S');
myplot(4, CV_A_27,'S');
myplot(2.2, CV_L_3,'S',2);
myplot(3.2, CV_L_9,'S',2);
myplot(4.2, CV_L_27,'S',2);

axis([0.5 4.5 0 7])

title('Temporal CV across scales')
legend('CV_A_p_h_i_d', 'CV_L_a_d_y_b_u_g','mean of CV_A_p_h_i_d ','mean of CV_L_a_d_y_b_u_g')
set(gca, 'Xtick',[1 2 3 4])
set(gca, 'Xticklabel',{'1' ,'3', '9', '27' })
xlabel('Scale (# of plants)')
ylabel('CV in population through time')
%%
%% Calculate spatial CV for each scale for two species
SCV_L_27 = std(L_27)./mean(L_27);
SCV_L_9 = std(L_9)./mean(L_9);
SCV_L_3 = std(L_3)./mean(L_3);
SCV_L_1 = std(data_L)./mean(data_L);

SCV_A_27 = std(A_27)./mean(A_27);
SCV_A_9 = std(A_9)./mean(A_9);
SCV_A_3 = std(A_3)./mean(A_3);
SCV_A_1 = std(data_A)./mean(data_A);
%% Plot
figure
myplot(repmat(1,34,1), SCV_A_1,'S'); hold on
myplot(repmat(1.2,34,1), SCV_L_1,'S',2); hold on
myplot(1:4, [mean(SCV_A_1(~isnan(SCV_A_1))) mean(SCV_A_3) mean(SCV_A_9) mean(SCV_A_27)],'L')
myplot([1:4]+0.2, [mean(SCV_L_1(~isnan(SCV_L_1))) mean(SCV_L_3(~isnan(SCV_L_3))) mean(SCV_L_9(~isnan(SCV_L_9))) mean(~isnan(SCV_L_27))],'L',2)

myplot(2, SCV_A_3,'S');
myplot(3, SCV_A_9,'S');
myplot(4, SCV_A_27,'S');
myplot(2.2, SCV_L_3,'S',2);
myplot(3.2, SCV_L_9,'S',2);
myplot(4.2, SCV_L_27,'S',2);

axis([0.5 4.5 0 7])

title('Spatial CV across scales')
legend('CV_A_p_h_i_d', 'CV_L_a_d_y_b_u_g','mean of CV_A_p_h_i_d ','mean of CV_L_a_d_y_b_u_g')
set(gca, 'Xtick',[1 2 3 4])
set(gca, 'Xticklabel',{'1' ,'3', '9', '27' })
xlabel('Scale (# of plants)')
ylabel('CV in population through time')