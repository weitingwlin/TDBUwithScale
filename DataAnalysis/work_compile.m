% Organizing the Spatial array data of ladybug-aphid relationship, 2014
% Wei-Ting Lin
%
% laptop, school
cd 'C:\Users\ASUS\Dropbox\PhD_projects\TDBU\DataAnalysis'
%%
%Data=load('data_temp.txt');
Data=load('DataLA.txt');
% line 1~4  ==> site info
% line 5    ==> plant ID
% line 6    ==> date 
array=Data(1:81,1:4);% 4-digit code for location
    [D_all,S]=size(Data);
D=D_all/81;% total number of days 
    temp=find(Data(:,1)==1 & Data(:,2)==1 & Data(:,3)==1 & Data(:,4)==1);
day=Data(temp,6); % Day from 5/17/2014, vector length is D
% prepare data sheets 
 ladybug = zeros(81,D); % time series of ladybug
 aphid = zeros(81,D);   % time series of ladybug
 spider = zeros(81,D);
  larva = zeros(81,D);
   otherlb = zeros(81,D);
names={'code1','code2','code3','code4','plant', 'day','Aphid','ladybug','molt','larva','spider','ant','other LB'};
 %% 
 %%%%%%%%%%%%% 1-plant TS
for L1 = 1:3
    for L2 = 1:3
        for L3 = 1:3
            for L4 = 1:3
                temp = find(Data(:,1)==L1 & Data(:,2)==L2 & Data(:,3)==L3 & Data(:,4)==L4);
                temp2 = ((L1-1)*27 + (L2-1)*9 +(L3-1)*3 +L4);% site in number 1~81
                aphid(temp2,:) = Data(temp,7)';
                ladybug(temp2,:) = Data(temp,8)';
                spider(temp2,:) = Data(temp,11)';
                larva(temp2,:) = Data(temp,10)';
                otherlb(temp2,:) = Data(temp,13)';
            end
        end
    end
end
%%% 
clear L1 L2 L3 L4 temp temp2

