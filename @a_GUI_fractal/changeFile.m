
function changeFile(obj)

[fname,pathstr,~] = uiputfile('.avi','Change Video File',obj.movieName) ;

if  fname == 0  ,  return  ,  end

[~,fname,~] = fileparts(fname) ;

obj.movieName = [ pathstr , fname , '.avi' ] ;

end