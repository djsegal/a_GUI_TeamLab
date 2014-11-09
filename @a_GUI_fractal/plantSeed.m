function plantSeed(obj)


% ============================
%  clear plot and points grid
% ============================

scrapFractal( obj )


% ===========================
%   if seedMatrix is empty, 
%  add a point at the center
% ===========================

if ~any( obj.seedMatrix )
    
    obj.seedMatrix( obj.radX+1 , obj.radY+1 )  = 1 ;
    
end


% ====================================
%  add seed defined by the seedMatrix
% ====================================

obj.seedList = zeros(0,2) ;

for     i = 1 : 2*obj.radX + 1
    for j = 1 : 2*obj.radY + 1
        
        if obj.seedMatrix(i,j) == 1
            
            obj.mass  =  obj.mass + 1  ;
            
            curX = ( obj.x0 + i ) - ( obj.radX + 1 ) ;
            curY = ( obj.y0 + j ) - ( obj.radY + 1 ) ;
            
            obj.seedList(end+1,:) = [  curX  curY  ]  ;
                        
        end
        
    end
end

plotPoints( obj , obj.seedList , obj.seedColor )


% ===============
%  restart movie
% ===============

obj.flipBook  =  getframe( obj.curFig , obj.boxPos )   ; % Get initial frame

end

