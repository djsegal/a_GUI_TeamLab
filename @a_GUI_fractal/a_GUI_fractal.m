%%%        Lab : Fractals  ( or Diffusion Limited Aggregation )
%    Author(s) : qwer uiop ( quiop@wisc.edu )
%                asdf hjkl ( ahjkl@wisc.edu )
%                zxcv vbnm ( zvbnm@wisc.edu )
%         Date : 10/12/14

classdef a_GUI_fractal < handle
    
    
    properties
       
        % ======================
        %  Tweakable Parameters 
        % ======================
       
        gridSize        % Grid size to put particles
        maxParticle     % Number of particles to be used
        
        startRadius     % Radius of start circle
        
        killFactor      % Radius to kill particles
        diffFactor      % Radius to use diffusion accelerator
        
        seedColor       % Seed color is initially red
        dotsColor       % Dots color is initially blue
        dotsShape       % Dots shape is initially a dot
        
        movieLength     % Movie set to last 10 seconds
        movieName       
        
        radX            % Height  =  1 + 2 * radX
        radY            % Width   =  1 + 2 * radY
        
        
    end
    
    
    properties
        
        % ======================
        %  Parameters Important
        %      to the User
        % ======================
        
        seedMatrix       =   [] ;     % Matrix that holds seed shape
        
        seedMass
        dotsMass

        mass
        aggregateRadius
        
        numParts         =    0 ;
        
        curFig
        curAxes
        curPanel
        
        seedList
        pointList
        
        
    end
    
    properties( Hidden )
        
        % ==================
        %  Hidden Variables
        % ==================
        
        boxPos
        
        curMarkerSize
        
        diffusionRadius
        diffusionRadiusSquared
        
        killRadius
        killRadiusSquared
        
        diffAccelRadius
        
        x0
        y0
        Grid
        
        aggText  =  zeros( 1 , 4 )
        
        flipBook
        
        curButtons
        
        
    end
    
    
    methods
        
        % ====================
        %  Constructor Method
        % ====================
        
        function obj = a_GUI_fractal
            
            buildLayout(    obj  )
            
            createText(     obj  )
            
            alterSettings(    obj  ,  true  )
                        
            addButtons(     obj  )
            
            plantSeed(      obj  )
            
        end
        
        
    end
    
    
    methods( Hidden )
       
        % ==================
        %  Button Functions
        % ==================
        
        alterSettings(    obj  ,  isFirstCall  )
        
        changeName(       obj  )
        
        drawSeed(         obj  )
        
        growFractal(      obj  )
        
        saveLoadFractal(  obj  )
        
        scrapFractal(     obj  )
        
        
    end
    
    
    methods( Hidden )
        
        % =================
        %  Other Functions
        % =================
        
        addButtons(       obj  )
        
        buildLayout(      obj  )
        
        createText(       obj  )
        
        initVariables(    obj  )
        
        makeMovie(        obj  )
        
        plantSeed(        obj  )
        
        plotPoints(       obj  ,   varargin  )
        
        
    end
    
    
end
