
function makeMovie(obj)

tmpName = [ obj.movieName , '.avi' ] ;      %  "Fractal_#.avi"
writerObj = VideoWriter( tmpName ) ;        % Create Video Obj

reqFrameRate = ceil( size( obj.flipBook , 2 ) / obj.movieLength ) ;     %  that lasts
set(writerObj,'FrameRate',reqFrameRate)     %  for 10secs

open( writerObj )                           % Open     File
writeVideo( writerObj , obj.flipBook ) ;        % Write to File
close(writerObj)                            % Close    File

end