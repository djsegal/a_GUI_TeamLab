function plotPoints( obj , curPoints , curColor )

if isempty(curPoints)
    
    cla
    
    plotPoints( obj , obj.seedList , obj.seedColor )
    
    if obj.dotsMass == 0 , return , end
    
    plotPoints(                        ...
        obj                          , ...
        obj.pointList( 1:obj.dotsMass , : ) , ...
        obj.dotsColor )
    
    return
    
else
    
    maxRad  =  sqrt(        max(           ...
        ( curPoints(:,1) - obj.x0 ).^2  +  ...
        ( curPoints(:,2) - obj.y0 ).^2  )  ) ;
    
end


if obj.aggregateRadius == 0 || maxRad > obj.aggregateRadius

    obj.aggregateRadius  =  ceil( maxRad ) ;

    rr  =  ceil(  1.2  *  max( 5 , obj.aggregateRadius )  )  ;

    axis( [ obj.x0-rr  obj.x0+rr obj.y0-rr obj.y0+rr ] )

        prevUnits = get( gca , 'units' ) ;

        set( gca , 'units'     ,   'inches'   )

        tmpVector  =  get( gca ,  'position'  ) ;
        
        obj.curMarkerSize    =  min( tmpVector(3:4) ) ;
        
        obj.curMarkerSize    =  obj.curMarkerSize * 72 * 2 / ( 1 + 2*rr )  ; % 72 dots per inch
        
        set( gca , 'units'     ,  prevUnits   ) ;
        
        if maxRad >  0
        
            cla
        
            plotPoints( obj , obj.seedList , obj.seedColor )
            
            if obj.dotsMass == 0 , return , end
            
            plotPoints(                        ...
                obj                          , ...
                obj.pointList( 1:obj.dotsMass , : ) , ...
                obj.dotsColor )
            
        end
        

end

for i = 1 : size( curPoints , 1 )
   
    curX  =  curPoints(i,1) ;
    curY  =  curPoints(i,2) ;
     
    obj.Grid(           curX , curY )    =   1     ;   % Register Point
    plot( obj.curAxes , curX , curY , curColor , 'MarkerSize'    , obj.curMarkerSize )   ;   %   Add    Point
    
end
    

% =============
%  resize axis 
% =============

% ===================
%  update text boxes
% ===================

set(  obj.aggText(2)  ,  'string'  ,  num2str( obj.seedMass + obj.dotsMass )  )
set(  obj.aggText(4)  ,  'string'  ,  num2str(     obj.aggregateRadius     )  )

% ==================
%  redo axes bounds
% ==================

% ============
%  plot seeds
% ============

% =============
%  plot points
% =============

end