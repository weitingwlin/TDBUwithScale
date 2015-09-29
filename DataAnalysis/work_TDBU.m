% top-down & bottom-up indices from time series
% Wei-Ting Lin
% This work_ file makes compiled original data into two series of R calues, for TD and BU effect at each of 4 spatial scales 
clear;clc
cd 'C:\Users\ASUS\Desktop\Weiting Brain_brain\Files\CFC26219-6EB2-83FC-A81F-64377771BF19'
work_compile
%%
% prepare data sheets 
ladybug_3=zeros(27,D);
 aphid_3=zeros(27,D);
  ladybug_9=zeros(9,D);
 aphid_9=zeros(9,D);
 ladybug_27=zeros(3,D);
 aphid_27=zeros(3,D);
%%%%%%%%%%%% 3-plant TS
for i=0:26
    ind=[i*3+1:i*3+3];
    ladybug_3(i+1,:)=sum(ladybug(ind,:));
      aphid_3(i+1,:)=sum(aphid(ind,:));
end
%%%%%%%%%%%%%% 9-plant TS
for i=0:8
    ind=[i*9+1:i*9+9];
    ladybug_9(i+1,:)=sum(ladybug(ind,:));
      aphid_9(i+1,:)=sum(aphid(ind,:));
end
%%%%%%%%%%%%%%% 27-plant TS
for i=0:2
    ind=[i*27+1:i*27+27];
    ladybug_27(i+1,:)=sum(ladybug(ind,:));
      aphid_27(i+1,:)=sum(aphid(ind,:));
end
%%
clear ind i 
%%
t=1; %temporal data point
for d=1:D-1
    if day(d+1)-day(d)==1
        for p=1:81
            MA_L_1(p,t) = mean(ladybug(p,d:d+1));
            DF_L_1(p,t) = ladybug(p,d+1)-ladybug(p,d);
            MA_A_1(p,t) = mean(aphid(p,d:d+1));
            DF_A_1(p,t) = aphid(p,d+1)-aphid(p,d);
        end
        t=t+1;
    end
end
%%
t=1; %temporal data point
for d=1:D-1
    if day(d+1)-day(d)==1
        for p=1:27
            MA_L_3(p,t) = mean(ladybug_3(p,d:d+1));
            DF_L_3(p,t) = ladybug_3(p,d+1)-ladybug_3(p,d);
            MA_A_3(p,t) = mean(aphid_3(p,d:d+1));
            DF_A_3(p,t) = aphid_3(p,d+1)-aphid_3(p,d);
        end
        t=t+1;
    end
end

%%
t=1; %temporal data point
for d=1:D-1
    if day(d+1)-day(d)==1
        for p=1:9
            MA_L_9(p,t) = mean(ladybug_9(p,d:d+1));
            DF_L_9(p,t) = ladybug_9(p,d+1)-ladybug_9(p,d);
            MA_A_9(p,t) = mean(aphid_9(p,d:d+1));
            DF_A_9(p,t) = aphid_9(p,d+1)-aphid_9(p,d);
        end
        t=t+1;
    end
end
%%
t=1; %temporal data point
for d=1:D-1
    if day(d+1)-day(d)==1
        for p=1:3
            MA_L_27(p,t) = mean(ladybug_27(p,d:d+1));
            DF_L_27(p,t) = ladybug_27(p,d+1)-ladybug_27(p,d);
            MA_A_27(p,t) = mean(aphid_27(p,d:d+1));
            DF_A_27(p,t) = aphid_27(p,d+1)-aphid_27(p,d);
        end
        t=t+1;
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

%%
plot(1:4,TD,'r.')
axis([0 5 -0.4 0])
plot(1:4,BU,'k.')
axis([0 5 0 0.1])