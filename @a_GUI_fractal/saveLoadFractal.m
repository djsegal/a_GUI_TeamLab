function saveLoadFractal( obj )


% ===========================================
%  fork function depending on what called it
% ===========================================

curString = get( obj.curButtons(1) , 'string' )  ;

isSave = ~isempty( strfind( lower(curString) , 'save' ) ) ;


% =====================
%  save grid operation
% =====================

if isSave
    
    tmpGrid = zeros( 2*obj.aggregateRadius+1 ) ;
    
    for      i  =  -obj.aggregateRadius : 1 : obj.aggregateRadius
        for  j  =  -obj.aggregateRadius : 1 : obj.aggregateRadius
            
            curX = obj.x0 + i ;
            curY = obj.y0 + j ;
            
            if obj.seedMatrix(i,j) == 1
                
                curX = ( obj.x0 + i ) - ( obj.radX + 1 ) ;
                curY = ( obj.y0 + j ) - ( obj.radY + 1 ) ;
                
                tmpGrid( curX , curY )  =  2   ;
                
            end
            
        end
    end
    
    dlmwrite( 'myFile.txt' , tmpGrid ) ;
    
    return
    
end


% =====================
%  load grid operation
% =====================
333
tmpGrid = dlmread( 'myFile.txt' ) ;
222
for     i = size( tmpGrid , 1 )
    for j = size( tmpGrid , 2 )
        
        if tmpGrid(i,j) == 0  ,  continue  ,  end
        
        obj.Grid(i,j)  =  1 ;
        obj.Mass       =  obj.Mass + 1 ;
        
        switch tmpGrid(i,j)
            
            case 1      ,  curColor = obj.dotsColor ;
            case 2      ,  err('curColor = obj.seedColor') ;
            otherwise   ,  curColor = obj.seedColor ;
        
        end
        
%         if tmpGrid(i,j) == 1
%             curColor = obj.dotsColor ;
%         else % tmpGrid(i,j) == 2
%             curColor = obj.seedColor ;
%         end
        
        plot( obj.curAxes , i , j , curColor  ) ;
        
        radiusSquared  =  ( i - obj.x0 )^2 + ( j - obj.y0 )^2  ;
        
        aggRadSquared  =  max( aggRadSquared , radiusSquared ) ;
        
    end
end

obj.aggregateRadius  =  ceil( sqrt( aggRadSquared ) ) ;

end

