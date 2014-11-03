
function growFractal(obj)

if ~get(obj.curButtons(end),'value')  ,  return  ,  end

curString = get( obj.curButtons(1) , 'string' )  ;

newString = strrep( curString , 'Load' , 'Save' ) ;

set( obj.curButtons(1) , 'string' , newString ) ;

% set( obj.curButtons(end) , 'value' , 1 )
%
% if obj.fractalGrowing  ,  return  ,  end
% 
% obj.fractalGrowing = true ; 

% --------------------
%  History While Loop
% --------------------

while obj.numParts <= obj.maxParticle
    
    % ------------------------
    %  Start Current Particle
    % ------------------------
    
    particle_alive  =  true ;         % Set logical variable for movement loop
    
    obj.numParts  =  obj.numParts  +   1  ;
    phi           =  2 * pi * rand(1) ;
    
    rx            =  obj.x0 + round( obj.startRadius * cos(phi) ) ;
    ry            =  obj.y0 + round( obj.startRadius * sin(phi) ) ;
    rr            =       0 ;
    
    % ---------------------
    %  Movement While Loop
    % ---------------------
    
    while particle_alive
        
        die = randperm(4);     % Get Random Direction
        
        % -----------------
        %  Update Position
        % -----------------
        
        switch( die(1) )
            
            case 1  ,  rx = rx + 1  ; % right
            case 2  ,  rx = rx - 1  ; % left
            case 3  ,  ry = ry + 1  ; % up
            case 4  ,  ry = ry - 1  ; % down
                
        end
        
        % ---------------------
        %  Check for a "Kill"
        %         or a "Stick"
        % ---------------------
        
        radiusSquared  =  ( rx - obj.x0 )^2 + ( ry - obj.y0 )^2  ;
        
        if radiusSquared >= obj.killRadiusSquared   %   " Kill  "
            
            % --------------------------------
            %  Break Out of the Movement Loop
            %     and Start a New History
            % --------------------------------
            
            particle_alive = false ;
            
            continue
            
        end
            
        if ...                              %   " Stick "
                obj.Grid( rx + 1 , ry     ) + ...
                obj.Grid( rx - 1 , ry     ) + ...
                obj.Grid( rx     , ry + 1 ) + ...
                obj.Grid( rx     , ry - 1 ) >  0
            
            pause(1e-3) 
            
            if ~get(obj.curButtons(end),'value')  ,  return  ,  end
            
            % ---------------------------
            %  Required "Stick" Protocol
            % ---------------------------
            
            obj.mass  =  obj.mass + 1       ;       % Increment obj.mass
            obj.Grid( rx , ry )  =  1       ;       % Register  Point
            plot( rx , ry , obj.dotsColor ) ;       % Add Point
            
            % ----------------------------
            %  Check for Aggregate Growth
            % ----------------------------
            
            aggregateRadiusSquared  = obj.aggregateRadius ^ 2 ;
            
            if radiusSquared > aggregateRadiusSquared
                
                % -----------------------------
                %  Required Aggregate Protocol
                % -----------------------------
                
                obj.aggregateRadius    = ceil( sqrt( radiusSquared ) ) ;
                
                rr        = max( rr , ...
                    1.2  *  max(  5 , obj.aggregateRadius ) ) ;
                
                axis([ obj.x0-rr  obj.x0+rr obj.y0-rr obj.y0+rr ] )
                
            end
            
            % --------------------------
            %  Wrap-Up "Stuck" Particle
            % --------------------------
            
            set( obj.aggText(2) , 'string' , num2str(obj.mass) )
            set( obj.aggText(4) , 'string' , num2str(obj.aggregateRadius) )
            
            obj.flipBook(end+1) = getframe( obj.curFig , obj.boxPos ) ; % Capture Frame
            
            particle_alive  =  false ;
            
            continue
            
        end
        
    end
    
end

makeMovie(obj)

obj.fractalGrowing = false ;

set( obj.curButtons(end) , 'value' , 0 )

fprintf( ' \n done \n \n ' )

end