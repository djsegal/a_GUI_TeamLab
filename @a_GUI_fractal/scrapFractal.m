function scrapFractal(obj)


% ======================
%  restart fractal plot
% ======================

cla( obj.curAxes )

obj.Grid  =  zeros(2*obj.gridSize + 1) ;  % Define grid to store stuck particles

obj.seedMass         =  0   ;
obj.dotsMass         =  0   ;

obj.aggregateRadius  =  0   ;
obj.numParts         =  0   ;

set(obj.curButtons(end),'value',0)


% ============================
%  change save fractal button 
%  into a load fractal button
% ============================

curString = get( obj.curButtons(1) , 'string' )  ;

newString = strrep( curString , 'Save' , 'Load' ) ;

set( obj.curButtons(1) , 'string' , newString ) ;


end

