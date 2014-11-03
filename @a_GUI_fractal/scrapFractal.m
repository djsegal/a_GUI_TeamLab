function scrapFractal(obj)


cla( obj.curAxes )

obj.Grid  =  zeros(2*obj.gridSize + 1) ;  % Define grid to store stuck particles

obj.mass             =  0   ;
obj.aggregateRadius  =  0   ;
obj.numParts         =  0   ;

set(obj.curButtons(end),'value',0)


curString = get( obj.curButtons(1) , 'string' )  ;

newString = strrep( curString , 'Save' , 'Load' ) ;

set( obj.curButtons(1) , 'string' , newString ) ;


end

