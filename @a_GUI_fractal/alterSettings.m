
function alterSettings(obj,isFirstCall)


curFile = [ pwd '/@a_GUI_fractal/user.settings' ] ;


% ====================
%  read initial input
% ====================

fileID = fopen(curFile,'r');
C = textscan(fileID,'%q %q','Delimiter',',');
fclose(fileID);


% ================
%  get user input
% ================

if isFirstCall
    D = C{2} ;
else
    D = inputdlg( C{1} , 'Alter Settings' , 1 , C{2} ) ;
end


% ================
%  set new values
% ================

for i = 1 : length( C{1} )
    curVal = D{i} ;
    [ ~ , curStatus ] = str2num( curVal ) ;
    if curStatus == 0
        curVal = [ '''' curVal '''' ] ;
    end
    eval(  [ 'obj.' C{1}{i} ' = ' curVal ]  )
end

initVariables(obj)


% =======================
%  return for first call
% =======================

if  isFirstCall  
    return
end


% ==================
%  write new output
% ==================

plotPoints(obj,[],[])

fileID = fopen(curFile,'w');
for i = 1 : length( C{1} )
    fprintf(fileID,'%s,%s\n',C{1}{i},D{i});
end
fclose(fileID);


end