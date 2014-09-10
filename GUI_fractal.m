%%%        Lab : Fractals  ( or Diffusion Limited Aggregation )
%    Author(s) : qwer uiop ( quiop@wisc.edu )
%                asdf hjkl ( ahjkl@wisc.edu )
%                zxcv vbnm ( zvbnm@wisc.edu )
%         Date : 10/12/14

close all  ;  clear all  ;  clc

% =========================================================================
%  Quick Tip:
% =========================================================================
%
%     >> Put " close all ; clear all ; clc " into a shortcut.
%
%     >> To do this,
%
%          + copy  ( ctrl + c ) the above text without the quotes
%     /----* click the "Create new command shortcut" button
%     |    + paste ( ctrl + v ) the commands into the Callback section
%     |
%     |   /------------------------------------------------------------
%     |   | The "New Shortcut" button is the icon with a:
%     |   |   + black  arrow pointing to its   top  - right corner
%     |   |   + yellow  plus      in     its bottom - right corner
%     \---|
%         | If your notepad's undocked, it will be in the toolbar:
%         |   + at the   top-right   of the window
%         |   + in the furthest slot to the left
%         \------------------------------------------------------------
%
% =========================================================================

%%  Initializion Section


% ----------------------
%  Tweakable Parameters
% ----------------------

gridSize         =  5e3 ;     % Grid size to put particles
maxParticle      =  5e3 ;     % Number of particles to be used
startRadius      =  1e2 ;     % Radius of start circle
killFactor       =  1.1 ;     % Radius to kill particles
aggregateRadius  =    0 ;     % Radius of aggregate
diffFactor       =  2.0 ;     % Radius to use diffusion accelerator
videoNum         =    0 ;     % Index  of current fractal video
seedColor        =  'r' ;     % Seed color is initially red
dotsColor        =  'b' ;     % Dots color is initially blue
dotsShape        =  '*' ;     % Dots shape is initially a dot

% -------------------
%  Derived Variables
% -------------------

seedColor               =  [ seedColor , dotsShape ]  ; 
dotsColor               =  [ dotsColor , dotsShape ]  ;  

diffusionRadius         =   diffFactor * startRadius  ;
killRadius              =   killFactor * startRadius  ;

diffusionRadiusSquared  =  diffusionRadius ^ 2 ;   % Radii squared
killRadiusSquared       =       killRadius ^ 2 ;   % for efficiency

%                          Diffusion Acceleration Radius
diffAccelRadius         =  diffusionRadius - startRadius ;

% -------------
%  Grid Matrix
% -------------

Grid  = zeros(2*gridSize + 1) ;  % Define grid to store stuck particles
x0           =  gridSize + 1  ;  % Define origin using offset coordinates
y0           =  gridSize + 1  ;
Grid(x0,y0)  =             1  ;  % Place seed at origin

% -----------
%  Make Plot 
% -----------

curFig       =   figure(         'menubar'      ,      'none'       , ...
    'units'  ,  'normalized'  ,  'position'     ,  [ .4 .1 .5 .6 ]  , ...
    'name'   ,  'Fractal'     ,  'numbertitle'  ,      'off'        )  ;

set(  curFig , 'units' , 'pixels'  )

curPos       =   get( curFig , 'position' ) ;

tmpLen       =   curPos(3) - .9 * curPos(4) ;

axesPos      =   [       0            0      .9*curPos(4) .9*curPos(4) ] ;
textPos1     =   [       0      .9*curPos(4) .5*curPos(4) .1*curPos(4) ] ;
textPos2     =   [ .5*curPos(4) .9*curPos(4) .4*curPos(4) .1*curPos(4) ] ;
panPos       =   [ .9*curPos(4)       0         tmpLen       curPos(4) ] ;
curPos       =   [       0            0      .9*curPos(4)    curPos(4) ] ;   
     
curAxes      =   axes( 'units' , 'pixels' , 'position' , axesPos )  ;

curPanel     =  uipanel( ...
    'parent' ,  curFig , 'units'    , 'pixels' , ...
    'position'         ,  panPos    ) ;

axis([ x0-1 x0+1 y0-1 y0+1 ])                 % Do initial Scaling
hold on                                       % Plot all points on same fig

set( gca , 'xtick' , Inf , 'ytick' , Inf )    % Remove tick marks                

% --------------
%  Initial Plot
% --------------

mass            =  1 ;                        % Initialize aggregate mass

aggText1     =  uicontrol( ...
    'style'  , 'text'  , 'Fontsize' ,    20    , ...
    'parent' ,  curFig , 'units'    , 'pixels' , ...
    ...
    'position'         ,  textPos1             , ...
    'string'           ,  num2str(mass) )  ;

aggText2     =  uicontrol( ...
    'style'  , 'text'  , 'Fontsize' ,    20    , ...
    'parent' ,  curFig , 'units'    , 'pixels' , ...
    ...
    'position'         ,  textPos2             , ...
    'string'           ,  num2str(aggregateRadius) )  ;

plot(  x0 , y0 , seedColor  )                 % Plot the seed
         
flipBook        =  getframe( gcf , curPos )   ;     % Get initial frame


%%  Main Program Section

% ------------------------------------
%  (Re)set Initial Testing Conditions
% ------------------------------------

particle        =  1 ;            % Initialize particle history counter
particle_alive  =  1 ;            % Set logical variable for movement loop

% --------------------
%  History While Loop
% --------------------

while particle <= maxParticle
    
    % ------------------------
    %  Start Current Particle
    % ------------------------
    
    particle  =  particle  +   1  ;
    phi       =  2 * pi * rand(1) ;
    
    rx        =  x0 + round( startRadius * cos(phi) ) ;
    ry        =  y0 + round( startRadius * sin(phi) ) ;
    rr        =   0 ;
    
    % ---------------------
    %  Movement While Loop
    % ---------------------
    
    while true
        
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
        
        radiusSquared  =  ( rx - x0 )^2 + ( ry - y0 )^2  ;
        
        if radiusSquared >= killRadiusSquared   %   " Kill  "
            
            % --------------------------------
            %  Break Out of the Movement Loop
            %     and Start a New History
            % --------------------------------
            
            break
            
        elseif ...                              %   " Stick "
                Grid( rx + 1 , ry     ) + ...
                Grid( rx - 1 , ry     ) + ...
                Grid( rx     , ry + 1 ) + ...
                Grid( rx     , ry - 1 ) >  0
            
            % ---------------------------
            %  Required "Stick" Protocol
            % ---------------------------
            
            mass  =  mass + 1           ;       % Increment Mass
            Grid( rx , ry )  =  1       ;       % Register  Point
            plot( rx , ry , dotsColor ) ;       % Add Point
            
            % ----------------------------
            %  Check for Aggregate Growth
            % ----------------------------
            
            aggregateRadiusSquared  = aggregateRadius ^ 2 ;
            
            if radiusSquared > aggregateRadiusSquared
                
                % -----------------------------
                %  Required Aggregate Protocol
                % -----------------------------
                
                aggregateRadius        = ceil( sqrt( radiusSquared ) ) ;
                aggregateRadiusSquared = aggregateRadius ^ 2           ;
                
                rr        = max( rr , ...
                    1.2  *  max(  5 , aggregateRadius ) ) ;
                
                axis([ x0-rr  x0+rr y0-rr y0+rr ] )
                
                testFrame = getframe( gcf , curPos ) ; % test frame for correct dims
                
            end
            
            % --------------------------
            %  Wrap-Up "Stuck" Particle
            % --------------------------
            
            set( aggText1 , 'string' , num2str(mass) )
            set( aggText2 , 'string' , num2str(aggregateRadius) )
            
            flipBook(end+1) = getframe( curFig , curPos ) ; % Capture Frame
            
            break; %  Break Out of Movement Loop and Start a New History
            
        end
        
    end
    
end

%% Finish Program Section

% ------------
%  Make Movie
% ------------

videoName = [ 'Fractal_' , ...              % Name File:
    num2str(videoNum) , '.avi' ] ;          %  "Fractal_#.avi"
writerObj = VideoWriter( videoName ) ;      % Create Video Obj

reqFrameRate = ...                          % Make a video
    ceil( size( flipBook , 2 ) / 10 ) ;     %  that lasts
set(writerObj,'FrameRate',reqFrameRate)     %  for 10secs

open( writerObj )                           % Open     File
writeVideo( writerObj , flipBook ) ;        % Write to File
close(writerObj)                            % Close    File

hold off

fprintf( '\n done \n\n' )
