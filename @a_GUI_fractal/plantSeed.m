function plantSeed(obj)


% ============================
%  clear plot and points grid
% ============================

scrapFractal( obj )


% ===============================================
%  add a one-pixel seed if one hasn't been given
% ===============================================

if isempty( obj.seedMatrix )
    
    obj.mass             =  1 + obj.mass             ;
    obj.aggregateRadius  =  1 + obj.aggregateRadius  ;
    
    obj.Grid(obj.x0,obj.y0)   = 1  ;          % Place seed at origin
    
    plot( obj.curAxes , obj.x0 , obj.y0 , obj.seedColor ) % Plot the seed
    
    set( obj.aggText(2) , 'string' , num2str(obj.mass) )
    set( obj.aggText(4) , 'string' , num2str(obj.aggregateRadius) )
    
    axis( obj.curAxes , [ obj.x0-6  obj.x0+6 obj.y0-6 obj.y0+6 ] )
    
    return
    
end


% ====================================
%  add seed defined by the seedMatrix
% ====================================

obj.Grid( obj.x0 , obj.x0 ) = 0 ;

aggRadSquared  =  1 ;

for     i = 1 : 2*obj.radX + 1
    for j = 1 : 2*obj.radY + 1
        
        if obj.seedMatrix(i,j) == 1
            
            obj.mass  =  obj.mass + 1  ;
            
            curX = ( obj.x0 + i ) - ( obj.radX + 1 ) ;
            curY = ( obj.y0 + j ) - ( obj.radY + 1 ) ;
            
            plot( obj.curAxes , curX , curY , obj.seedColor  ) ;
            obj.Grid( curX , curY )  =  1   ;
            
            radiusSquared  =  ( curX - obj.x0 )^2 + ( curY - obj.y0 )^2  ;
            
            aggRadSquared  =  max( aggRadSquared , radiusSquared ) ;
                        
        end
        
    end
end


% ==========================
%  resize axis to show seed
% ==========================

obj.aggregateRadius  =  ceil( sqrt( aggRadSquared ) ) ;

rr                   =  1.25  *  min( 5 , obj.aggregateRadius ) ;

axis( obj.curAxes , [ obj.x0-rr  obj.x0+rr obj.y0-rr obj.y0+rr ] )


% ===================
%  update text boxes
% ===================

set( obj.aggText(2) , 'string' , num2str(obj.mass            ) )
set( obj.aggText(4) , 'string' , num2str(obj.aggregateRadius ) )


end

