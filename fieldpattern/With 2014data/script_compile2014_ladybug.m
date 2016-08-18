%% Compiling ladybug and aphid data
           Amat14 = nan( P14, 20);
            Lmat14 = nan( P14, 20);
            Lallmat14 = nan( P14, 20);
            LLmat14 = nan( P14, 20);
    sample = 1; % first sample
    for p = 1 : P14
            patch = ind_patch14(p,:); % [ site, patch] 
                temp1 = find(((InsectData14(:,1) == patch(1)) + (InsectData14(:,2) == patch(2)))==2); % index for this patch
                tl = length(temp1); % time series length: how many samples were taken for this patch
            Amat14(p, 1:tl) = InsectData14(temp1, 8)' ;         
            Lmat14(p, 1:tl) = InsectData14(temp1, 15)' ;         
            Lallmat14(p, 1:tl) =sum( InsectData14(temp1, [14 15 16 ])') ;  % 3 taxa; adults      
            LLmat14(p,  1:tl) =sum( InsectData14(temp1, [14 15 16 19])') ;   % 3 taxa; adults and larva
    end
