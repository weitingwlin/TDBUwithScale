
%% Load Data
% main data
    InsectData = load('./data/InsectData2014.txt');  
    InsectData13 = load('./data/InsectData2013.txt');  
% variable names in main data: InsectData and InsectData13
    fileID = fopen('./data/InsectDataName.txt');
            temp = textscan(fileID,'%s');
            InsectDataNames = temp{1}'; % variable names for each column stored in  [Data]
    fclose(fileID); 
% date of sampling 
    fileID = fopen('./data/InsectSampleDate2014.txt');
            Date = textscan(fileID,'%s');
            Date =datenum(Date{1},'dd-mmm-yyyy') ; % variable names for each column stored in  [Data]
    fclose(fileID); 
    %%%%%%
    fileID = fopen('./data/InsectSampleDate2013.txt');
            Date13 = textscan(fileID,'%s');
            Date13 =datenum(Date13{1},'dd-mmm-yyyy') ; % variable names for each column stored in  [Data]
    fclose(fileID); 
         % date saved as "double"; to disply as string : datestr(date(1))
 % patch metrics
    PatchData13=load('./data/PatchData.txt');  
            ind2014 = PatchData13(:,16)~=999; % remove the patches not sampled in 2014
    PatchData = PatchData13(ind2014,:);
% variable names in main data
    fileID = fopen('./data/PatchDataName.txt');
            temp = textscan(fileID,'%s');
            PatchDataNames = temp{1}'; % variable names for each column stored in  [Data]
    fclose(fileID);   
%% overall frequency of each species at each patch, lumped over all observations
        P=length( PatchData(:,1));% number of patch
        P13=length( PatchData13(:,1));% number of patch surveyed in 2013
        ind_patch = PatchData(:,1:2);
        ind_patch13 = PatchData13(:,1:2);
 % prepare data sheet
 InsectFreq = zeros(P,16);
 InsectFreq13 = zeros(P13,16);
  
for p=1:P % for each patch
      patch = ind_patch(p,:); % [ site, patch] 
      temp1 = find(InsectData(:,1) == patch(1) & InsectData(:,2) == patch(2)); % index for this patch
      D=length(temp1); % number of observation
    for s=1:16  % for each species           
      InsectFreq(p,s) = sum( InsectData( temp1, s + 3 ) )/D; 
    end
end
%%%% 2013%%%
for q=1:P13 % for each patch
      patch = ind_patch13(q,:); % [ site, patch] 
      temp1 = find(InsectData13(:,1) == patch(1) & InsectData13(:,2) == patch(2)); % index for this patch
      D=length(temp1); % number of observation
    for s=1:16  % for each species           
      InsectFreq13(q,s) = sum( InsectData13( temp1, s + 3 ) )/D; 
    end
end
%%
 TabPatch = tnames( array2table(PatchData), PatchDataNames);
 TabPatch13 = tnames( array2table(PatchData13), PatchDataNames);
 TabInsect = tnames( array2table(InsectData), InsectDataNames);
 TabInsect13 = tnames( array2table(InsectData13), InsectDataNames);
 TabFreq = tnames( array2table(InsectFreq), InsectDataNames(4:end));
 TabFreq13 = tnames( array2table(InsectFreq13), InsectDataNames(4:end));
 writetable(TabPatch,'./data/TabPatch.txt','Delimiter',' ')
 writetable(TabPatch13,'./data/TabPatch13.txt','Delimiter',' ')
  writetable(TabInsect,'./data/TabInsect.txt','Delimiter',' ')
   writetable(TabInsect13,'./data/TabInsect13.txt','Delimiter',' ')
    writetable(TabFreq,'./data/TabFreq13.txt','Delimiter',' ')
     writetable(TabFreq13,'./data/TabFreq13.txt','Delimiter',' ')
%%
clear fileID temp ind2014 p patch temp1 s D ans q 
save ./data/Iva2014Data
  