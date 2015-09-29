% This is a function to calculate TD, BU effects 
% from (real or simulated) TS of aphids and ladybugs
function out=TDBU_scale(data_A, data_L,Day)
% out:[TD_1 TD_3 TD_9 TD_27]
%     [BU_1 BU_3 BU_9 BU_27]

nd=length(Day); % number of days, D 

%% create TS for 3-,9-,27-plant scales
% prepare data sheets 
L_3=zeros(27,nd);A_3=zeros(27,nd);
L_9=zeros(9,nd); A_9=zeros(9,nd);
L_27=zeros(3,nd); A_27=zeros(3,nd);
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
%%  calculate moving averageand (MA) and difference (DF)
t = 1; %temporal data point
for d = 1:nd-1
    if Day(d+1)-Day(d)==1 % find 2 consecutive days
        %%% 1-plant
         for k=1:81
            MA_L_1(k,t) = mean(data_L(k,d:d+1));
            DF_L_1(k,t) = data_L(k,d+1)-data_L(k,d);
            MA_A_1(k,t) = mean(data_A(k,d:d+1));
            DF_A_1(k,t) = data_A(k,d+1)-data_A(k,d);
        end
        %%%  3-plant
        for p=1:27
            MA_L_3(p,t) = mean(L_3(p,d:d+1));
            DF_L_3(p,t) = L_3(p,d+1)-L_3(p,d);
            MA_A_3(p,t) = mean(A_3(p,d:d+1));
            DF_A_3(p,t) = A_3(p,d+1)-A_3(p,d);
        end
        %%% 9-plant
         for q=1:9
            MA_L_9(q,t) = mean(L_9(q,d:d+1));
            DF_L_9(q,t) = L_9(q,d+1)-L_9(q,d);
            MA_A_9(q,t) = mean(A_9(q,d:d+1));
            DF_A_9(q,t) = A_9(q,d+1)-A_9(q,d);
         end
        %%% 27-plant
         for r=1:3
            MA_L_27(r,t) = mean(L_27(r,d:d+1));
            DF_L_27(r,t) = L_27(r,d+1)-L_27(r,d);
            MA_A_27(r,t) = mean(A_27(r,d:d+1));
            DF_A_27(r,t) = A_27(r,d+1)-A_27(r,d);
         end      
        t = t+1;
    end
end

%%
BU=zeros(1,4);
temp=corrcoef(MA_A_1,DF_L_1);BU(1,1)=temp(1,2);
temp=corrcoef(MA_A_3,DF_L_3);BU(1,2)=temp(1,2);
temp=corrcoef(MA_A_9,DF_L_9);BU(1,3)=temp(1,2);
temp=corrcoef(MA_A_27,DF_L_27);BU(1,4)=temp(1,2);

TD=zeros(1,4);
temp=corrcoef(MA_L_1,DF_A_1);TD(1,1)=temp(1,2);
temp=corrcoef(MA_L_3,DF_A_3);TD(1,2)=temp(1,2);
temp=corrcoef(MA_L_9,DF_A_9);TD(1,3)=temp(1,2);
temp=corrcoef(MA_L_27,DF_A_27);TD(1,4)=temp(1,2);
out= [TD;BU];