
function growFractal(obj)

if ~get(obj.curButtons(end),'value')  ,  return  ,  end

curString = get( obj.curButtons(1) , 'string' )  ;

newString = strrep( curString , 'Load' , 'Save' ) ;

set( obj.curButtons(1) , 'string' , newString ) ;

% ====================
%  History While Loop
% ====================

if  obj.maxParticle < obj.numParts
   
    obj.maxParticle = obj.numParts * 2 ;
    
end

while obj.numParts <= obj.maxParticle
    
    
    % ========================
    %  Start Current Particle
    % ========================
    
    particle_alive  =  true ;         % Set logical variable for movement loop
    
    obj.numParts  =  obj.numParts  +   1  ;
    
    phi           =  2 * pi * rand(1) ;
    
    rx            =  obj.x0 + round( obj.startRadius * cos(phi) ) ;
    ry            =  obj.y0 + round( obj.startRadius * sin(phi) ) ;
    
    
    % =====================
    %  Movement While Loop
    % =====================
    
    while particle_alive
        
        
        % =================
        %  Update Position
        % =================
        
        radiusSquared  =  ( rx - obj.x0 )^2 + ( ry - obj.y0 )^2  ;
        
        if radiusSquared < obj.diffusionRadiusSquared
            
            switch( randi(4) )
                
                case 1  ,  rx = rx + 1  ;   %    right
                case 2  ,  rx = rx - 1  ;   %    left
                case 3  ,  ry = ry + 1  ;   %    up
                case 4  ,  ry = ry - 1  ;   %    down
                    
            end
            
        else
            
            phi           =  2 * pi * rand(1) ;
            
            rxDiffAccel  =  cos(phi)  *  obj.diffAccelRadius  ;
            ryDiffAccel  =  sin(phi)  *  obj.diffAccelRadius  ;
            
            rx           =  rx        +  round(rxDiffAccel)   ;
            ry           =  ry        +  round(ryDiffAccel)   ;
            
        end
        
        radiusSquared  =  ( rx - obj.x0 )^2 + ( ry - obj.y0 )^2  ;
        
        
        % =========================
        %  Kill Particle if Needed
        % =========================
        
        if  radiusSquared >= obj.killRadiusSquared ...
                ||   obj.Grid( rx , ry ) == 1
            
            particle_alive  =  false ;
            
            continue
            
        end
        
        
        % =======================
        %  Move to Next Particle
        %   if it's not a Stick
        % =======================
   
        if ...                              
                obj.Grid( rx + 1 , ry     )   +  ...
                obj.Grid( rx - 1 , ry     )   +  ...
                obj.Grid( rx     , ry + 1 )   +  ...
                obj.Grid( rx     , ry - 1 )  ==   0
        
            continue 
            
        end
        
        
        % ====================
        %   Quit Function If 
        %  Paused by the User
        % ====================
        
        pause(eps)
        
        if ~get(obj.curButtons(end),'value')  ,  return  ,  end
        
        
        % ==========================
        %  Stick Partcle to Fractal
        % ==========================
        
        obj.dotsMass  =  obj.dotsMass + 1 ;
        
        obj.pointList( obj.dotsMass , : ) = [ rx , ry ] ;
        
        plotPoints( obj , [ rx , ry ] , obj.dotsColor )
        
        obj.flipBook(end+1) = getframe( obj.curFig , obj.boxPos ) ; % Capture Frame
        
        particle_alive  =  false ;
        
    end
    
end


% ================
%  finish fractal
% ================

makeMovie(obj)

set( obj.curButtons(end) , 'value' , 0 )

fprintf( ' \n done \n \n ' )


end