
clear
clc
%%
script_Gillespie_parameters
 
%% calculate stochastic parameters   
% Initial
for p = 1:81
      X0(p,:)  = [round(rand*100*(rand >= 0.3)) , (rand>=0.9) ];  
end
    tlim = 34;
    it = 1;

%%
tic
    [t, x] = iva_Gillespie( X0, tlim );
toc
x1 = permute(x, [1 3 2]); % so the dimensions in x1 are [patch, time, species]
ts = 1:tlim;
simA = fixsample(t, x1(:,:,1), ts);
simL = fixsample(t, x1(:,:,2), ts);
%% plot examples
p =5;
    myplot(ts,sum(simA),'S');hold on
    myplot(ts,sum(simL),'S',2);
%%
myplotyy(ts,sum(simA), ts,sum(simL), 'S', 'S', 3, 2);
%% Demo
 %A = [1 2 3 4 ; 4 5 6 0; 0 0  0 10];
 A=simA;
im = imagesc(A);
colormap(mycolormap(3));
im.AlphaData = .8;
colorbar
set(gca,'xtick', [], 'ytick', []);
            [r, c] = size(A);
    for i = 1 : r
            for j = 1 : c
                    myLatext(j, i, num2str(A(i, j)), 7, 5);
            end
    end
figure
L=simL;
im = imagesc(L);
colormap(mycolormap(2));
im.AlphaData = .8;
colorbar
set(gca,'xtick', [], 'ytick', []);
            [r, c] = size(L);
    for i = 1 : r
            for j = 1 : c
                    myLatext(j, i, num2str(L(i, j)), 7, 5);
            end
    end