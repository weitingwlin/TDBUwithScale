%% Load Data
% main data
    InsectData14 = load('./data2014/InsectData2014.txt');  
% variable names in main data: InsectData and InsectData13
    fileID = fopen('./data2014/InsectDataName.txt');
            temp = textscan(fileID,'%s');
            InsectDataNames = temp{1}'; % variable names for each column stored in  [Data]
    fclose(fileID); 
% date of sampling 
    fileID = fopen('./data2014/InsectSampleDate2014.txt');
            Date14 = textscan(fileID,'%s');
            Date14 =datenum(Date14{1},'dd-mmm-yyyy') ; % variable names for each column stored in  [Data]
    fclose(fileID); 
         % date saved as "double"; to disply as string : datestr(date(1))
 % patch metrics
    PatchData13=load('./data2014/PatchData.txt');  
        ind2014 = PatchData13(:,16)~=999; % remove the patches not sampled in 2014
    PatchData14 = PatchData13(ind2014,:);
% variable names in main data
    fileID = fopen('./data2014/PatchDataName.txt');
            temp = textscan(fileID,'%s');
            PatchDataNames = temp{1}'; % variable names for each column stored in  [Data]
    fclose(fileID);   
%% overall frequency of each species at each patch, lumped over all observations
        P14=length( PatchData14(:,1));% number of patch surveyed in 2013
        ind_patch14 = PatchData14(:,1:2);
 % prepare data sheet
 InsectFreq14 = zeros(P14,16);
  
for q = 1 : P14 % for each patch
      patch = ind_patch14(q,:); % [ site, patch] 
      temp1 = find(InsectData14(:,1) == patch(1) & InsectData14(:,2) == patch(2)); % index for this patch
      D = length(temp1); % number of observation
    for s = 1 : 16  % for each species           
      InsectFreq14(q,s) = sum( InsectData14( temp1, s + 3 ) )/D; 
    end
end
%%
 TabPatch14 = tnames( array2table(PatchData14), PatchDataNames);
 TabInsect14 = tnames( array2table(InsectData14), InsectDataNames);
 TabFreq14 = tnames( array2table(InsectFreq14), InsectDataNames(4:end));
 writetable(TabPatch14,'./data2014/TabPatch14.txt','Delimiter',' ')
   writetable(TabInsect14,'./data2014/TabInsect14.txt','Delimiter',' ')
     writetable(TabFreq14,'./data2014/TabFreq14.txt','Delimiter',' ')
%%
clear fileID temp patch temp1 s D ans q 
save ./data2014/FieldData
  