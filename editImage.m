function editImage


% ========================
%  create figure and axes
% ========================

figPos       =  get(0,'ScreenSize') ;

figPos(1:2)  =  figPos(3:4) * 0.2 ;
figPos(3:4)  =  figPos(3:4) * 0.6 ;

obj.fig      =  figure(          'menubar'      ,    'none'     , ...
    'units'  ,  'pixels'      ,  'position'     ,    figPos     , ...
    'name'   ,  'editImage'   ,  'numbertitle'  ,    'off'      )  ;

obj.ax       =  axes( ...
    'units'  ,  'normalized'  ,  'position'     ,  [ 0 0 1 1 ]  , ...
    'xtick'  ,   [ ]          ,  'ytick'        ,  [         ]  )  ;


% ======================
%  display the image at
%  a reduced resolution
% ======================

[Y.X,Y.map] = rgb2ind( imread('campRandallAtNight.jpg') , 256 ) ;

obj.IMG = ind2rgb( Y.X , Y.map ) ;
obj.IH  = image( obj.IMG ) ;


% ==========================
%  setup button information
% ==========================

tmpButtonPos  = { ...
    [ 0.8 0.0 .20 .33 ] ; [ 0.8 .33 .20 .33 ] ; [ 0.8 .66 .20 .33 ] ; ...
    [ 0.0 0.0 .20 .33 ] ; [ 0.0 .33 .20 .33 ] ; [ 0.0 .66 .20 .33 ] }  ;

obj.buttonStr = { ...
    'Restart' ; 'Gray'  ;  'Blur'  ;  ...
    'Red'     ; 'Green' ;  'Blue'  }   ;

% ----------------------------------------------------
%  transform buttonPos from normalized to pixel units
%  and flip the order of values (putting them in obj)
% ----------------------------------------------------

for ii = 1 : length(tmpButtonPos)
    
    curButtonPos       =  tmpButtonPos{ length(tmpButtonPos) - (ii-1) } ;
    curButtonPos(1:2)  =  curButtonPos(1:2) .* figPos(3:4) ;
    curButtonPos(3:4)  =  curButtonPos(3:4) .* figPos(3:4) ;
    obj.buttonPos{ii}  =  curButtonPos ;
    
end


% =============
%  add buttons
% =============

for ii = 1 : length(obj.buttonPos)
    
    F  =  getframe( obj.ax , obj.buttonPos{ii} )  ;
    
    obj.pb(ii)  =  uicontrol(            'style'      , 'push' , ...
        'units'    , 'pixels'          , 'visible'    , 'off'  , ...
        'position' , obj.buttonPos{ii} , 'fontsize'   ,  20    , ...
        'string'   , obj.buttonStr{ii} , 'fontweight' , 'bold' )  ;
    
    set( obj.pb(ii) , 'foregroundcolor' ,  [ 1 1 1 ]  )
    
end

restartImage


% ===============
%  add callbacks
% ===============

set( obj.pb( 1 ) , 'callback' , {@restartImage} )
set( obj.pb( 2 ) , 'callback' , {@greyImage   } )
set( obj.pb( 3 ) , 'callback' , {@blurImage   } )
set( obj.pb(4:6) , 'callback' , {@recolorImage} )


% ======================
%  the called functions
% ======================


    function restartImage(varargin)
        
        obj.curBlur  =  0 ;
        obj.grey     =  0 ;
        obj.red      =  0 ;
        obj.blue     =  0 ;
        obj.green    =  0 ;
        
        set(  obj.IH   ,  ...
            'cdata'    ,               obj.IMG  )
        
        fixButtons
        
    end


    function greyImage(varargin)
        
        obj.grey     =  1 ;
        obj.red      =  0 ;
        obj.blue     =  0 ;
        obj.green    =  0 ;
        
        if    obj.curBlur == 0  ,  obj.curBlur = 4  ;  ...
        else  obj.curBlur  =       obj.curBlur - 1  ;  end
        
        blurImage
        
    end


    function blurImage(varargin)
      
        % ---------------------
        %  do initial blurring
        % ---------------------
        
        obj.curBlur = mod( obj.curBlur + 1 , 5 ) ;
        
        switch obj.curBlur
                            
            case 0  ,  blurEffect  =     []                             ; 
            case 1  ,  blurEffect  =  fspecial( 'average'  ,  5      )  ;
            case 2  ,  blurEffect  =  fspecial( 'gaussian' , 10 ,  5 )  ;   
            case 3  ,  blurEffect  =  fspecial( 'motion'   , 20 , 45 )  ;
            case 4  ,  blurEffect  =  fspecial( 'disk'     , 10      )  ;
                
        end
        
        if isempty( blurEffect )
            blurred  =    obj.IMG ;
        else
            blurred  =      ...
                imfilter( obj.IMG , blurEffect , 'replicate' ) ;
        end
        
        cla( obj.IH )
        
        obj.IH  = image( blurred ) ;
       
        % --------------------------
        %  recolor image after blur
        % --------------------------
        
        tmp  =  get( obj.IH , 'cdata' )  ;
        
        if obj.grey , tmp = repmat( mean(blurred,3) , [1,1,3] )  ;  end
       
        tmp(:,:,1) = max( tmp(:,:,1) , min(1,tmp(:,:,1)*1.05*obj.red  ) ) ;
        tmp(:,:,2) = max( tmp(:,:,2) , min(1,tmp(:,:,2)*1.05*obj.green) ) ;
        tmp(:,:,3) = max( tmp(:,:,3) , min(1,tmp(:,:,3)*1.05*obj.blue ) ) ;
        
        set( obj.IH , 'cdata' , tmp )
        
        fixButtons
            
    end


    function recolorImage(varargin)
 
        % ---------------------------------
        %  find index and increase counter
        % ---------------------------------
        
        switch get( gcbo , 'string' )
            
            case 'Red'    ,  ind = 1  ;  obj.red   = obj.red   + 1  ;
            case 'Green'  ,  ind = 2  ;  obj.green = obj.green + 1  ;
            case 'Blue'   ,  ind = 3  ;  obj.blue  = obj.blue  + 1  ;
            otherwise
                error('An unknown error occured in the callback.')
                
        end
        
        % ---------------------------------------
        %  increase a bit, but not exceeding one
        % ---------------------------------------
        
        tmp  =  get( obj.IH , 'cdata' )  ;
        
        tmp(:,:,ind)  =  min( 1 , tmp(:,:,ind)*1.05 ) ;
        
        set(obj.IH,'cdata',tmp)
        
        fixButtons
        
    end


    function fixButtons
        
        % --------------------------------
        %   makes each button's cdata is
        %  equal to the image underneath.
        % --------------------------------
        
        for jj = 1:length(obj.pb)
            
            set( obj.pb(jj) , 'visible' , 'off' )
            
            F = getframe( obj.ax , obj.buttonPos{jj} )  ;
            
            set( obj.pb(jj) , 'cdata'   , F.cdata )
            
            set( obj.pb(jj) , 'visible' , 'on'  )
            
        end
        
    end


end