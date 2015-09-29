% Script for printing simulation data

fprintf(fileID,'MODEL : with B,D of P? = %s \n\n', num2str(withBDofP));
fprintf(fileID,'NOTE : %s\n\n%s \n\n', date, note);
fprintf(fileID,'\n * Parameters:\n');
fprintf(fileID,'\n\tDisperEvent = %s \n', num2str(DisperEvent));
fprintf(fileID,'\n\tgH = %.4g \t eP = %.4g \t H_0 = %.4g \t aP = %.4g \t KH = %.4g\n',gH,eP,H_0,aP,KH);
fprintf(fileID,'\n\tmH = %.4g \t mP = %.4g \t stoc_mH = %.4g \t stoc_mP = %.4g\n',mH,mP,stoc_mH,stoc_mP);
fprintf(fileID,'\n\tdH = %.4g \t dP = %.4g \t dHz = %.4g \t dPz = %.4g\n',dH,dP,dHz,dPz);
fprintf(fileID,'\n\tH_thH = %.4g \t H_thP = %.4g \t cH = %.4g \t cP = %.4g\n',H_thH,H_thP,cH,cP);
fprintf(fileID,'\n\tsH = %.4g \t sP = %.4g \n',sH,sP);

fprintf(fileID,'\n * Simulation settings:\n');

fprintf(fileID,'\n\tSeed = %s\n', num2str(seed));
fprintf(fileID,'\tItteration : \n\t\t Random initial : %.4g \n\t\t Simulation time : %.4g\n', ittInit,ittSim);

fileID = fclose(fileID); 
