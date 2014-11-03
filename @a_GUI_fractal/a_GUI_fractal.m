%%%        Lab : Fractals  ( or Diffusion Limited Aggregation )
%    Author(s) : qwer uiop ( quiop@wisc.edu )
%                asdf hjkl ( ahjkl@wisc.edu )
%                zxcv vbnm ( zvbnm@wisc.edu )
%         Date : 10/12/14

classdef a_GUI_fractal < handle
    
    properties
        
        % ----------------------
        %  Tweakable Parameters
        % ----------------------
              
        mass             =    1 ;     % Initially one seed at center
        aggregateRadius  =    0 ;     % Radius of aggregate
        
        gridSize         =  5e3 ;     % Grid size to put particles
        maxParticle      =  5e9 ;     % Number of particles to be used
        
        startRadius      =  1e2 ;     % Radius of start circle
        
        killFactor       =  1.1 ;     % Radius to kill particles
        diffFactor       =  2.0 ;     % Radius to use diffusion accelerator
        
        videoNum         =    0 ;     % Index  of current fractal video
        
        seedColor        =  'r' ;     % Seed color is initially red
        dotsColor        =  'b' ;     % Dots color is initially blue
        dotsShape        =  '.' ;     % Dots shape is initially a dot
        
        boxPos
        
        seedMatrix       =   [] ;     % Matrix that holds seed shape
        
        movieLength      =   10 ;     % Movie set to last 10 seconds
        movieName        =  'Fractal_0.avi' ;
        
        radX             =    1 ;     % Height  =  1 + 2 * radX
        radY             =    2 ;     % Width   =  1 + 2 * radY
        
        numParts         =    1 ;
        
        curFig
        curAxes
        curPanel
        
    end
    
    properties( Hidden )
        
        diffusionRadius
        diffusionRadiusSquared
        
        killRadius
        killRadiusSquared
        
        diffAccelRadius
        
        x0
        y0
        Grid
        
        aggText  =  zeros( 1 , 4 ) ;
        
        flipBook
        
        curButtons
        
        fractalGrowing = false ;
        
    end
    
    methods
        
        function obj = a_GUI_fractal
            
            set(0,'DefaultLineMarkerSize',40);
            
            initVariables( obj )
            
            buildLayout( obj )
            
            createText( obj )
            
            addButtons( obj )
            
            plantSeed( obj )
            
            obj.flipBook  =  getframe( obj.curFig , obj.boxPos )   ; % Get initial frame
            
        end
        
    end
    
    methods( Hidden )
        
        initVariables(obj)
        
        buildLayout(obj)
        
        createText(obj)
        
        addButtons(obj)
        
        growFractal(obj)
        
        makeMovie(obj)
        
        changeFile(obj)
        
        plantSeed(obj)
        
        drawMatrix(obj)
        
        scrapFractal(obj)
        
        saveLoadFractal(obj)
        
    end
    
end
