
function drawMatrix( varargin )

L        =  10  ;

N        =  L   ;
M        =  L*2   ;

figPos   =  [ .5 .2 .4 .6 ]  ;

curMat   =  zeros( N , M )  ;

clickOn  =  false  ;

curVal   =  0      ;

dotSize  =  0      ;

curFig   =       figure(          'windowstyle'  ,     'modal'    , ...
    'units'  ,  'normalized'   ,  'position'     ,     figPos     , ...
    'name'   ,  'drawMatrix'   ,  'numbertitle'  ,      'off'     )  ;

curAx    =       axes(             ...
    'units'  ,  'normalized'   ,  'parent'       ,     curFig     , ...
    'xtick'  ,   [ ]           ,  'ytick'        ,    [      ]    )  ;

done     =       uicontrol(        ...
    'callback'  , @drawDone    ,  'string'       ,     'done'     )  ;

cancel   =       uicontrol(        ...
    'callback'  , @drawCancel  ,  'string'       ,    'cancel'    )  ;

set(     [ done , cancel ]     ,   ...
    'units'     , 'normalized' ,  'parent'       ,     curFig     , ...
    'fontUnits' , 'normalized' ,  'style'        ,   'pushButton' )  ;

hold all

resize

set( curFig , 'WindowButtonDownFcn'   , {@(src,event)begClick} ) ;
set( curFig , 'WindowButtonMotionFcn' , {@(src,event)midClick} ) ;
set( curFig , 'WindowButtonUpFcn'     , {@(src,event)endClick} ) ;
set( curFig , 'resizefcn'             , {@(src,event)resize  } ) ;

    % ===============
    %  sub-functions
    % ===============


    function begClick(varargin)
        
        [         curPos , newVal ] = getPosition ;
        
        addPoint( curPos , newVal )
        
        clickOn  =  true    ;
        
        curVal   =  newVal  ;
        
    end


    function midClick(varargin)
        
        if ~clickOn          ,  return  ,  end
        
        [         curPos , newVal ] = getPosition ;
        
        if newVal ==   -1    ,  return  ,  end
        if newVal ~= curVal  ,  return  ,  end
        
        addPoint( curPos , newVal )
        
    end


    function endClick(varargin)
        
        clickOn  =  false    ;
        
    end


    function drawDone(varargin)
        
        close( curFig )
        
    end


    function drawCancel(varargin)
        
        close( curFig )
        
    end


    function resize(varargin)
        
        set( curAx , 'units'     , 'normalized' )
        
        set( curAx , 'position'  , [ 0 .1 1 .9 ]  )
        
        set( curAx , 'units'     ,   'inches'   )
        
        set( done  , 'position'  , [ 0 0 .5 .1 ]  )
        
        set( cancel , 'position' , [ .5 0 .5 .1 ] )
        
        set( [ done , cancel ]    ,  'fontsize' , .6 ) ;
        
        tmpVector  =  get( curAx ,  'position'  ) ;
        
        dotSize    =  min( tmpVector(3:4) ) ;
        
        dotSize    =  dotSize * 72 * 2 / max( N , M )  ; % 72 dots per inch
        
        remake
        
    end


    function remake
        
        cla( curAx )
        
        for     i = 1 : N  ,  plot( [ i i ] , [ 0 M ] , 'k' )  ,  end
        for     j = 1 : M  ,  plot( [ 0 N ] , [ j j ] , 'k' )  ,  end
        
        for     i = 1 : N
            for j = 1 : M
                
                if curMat(i,j) == 1
                    
                    addPoint( [ i j ] , 1 )
                    
                end
                
            end
        end
        
    end


    function [ curPos , newVal ] = getPosition
        
        curPt  = get( curAx , 'currentpoint' ) ;
        
        curPos = floor( curPt(1,1:2) + 1 ) ;
        
        newVal = -1 ;  %  set for early returns
        
        if  curPos(1) < 1 || curPos(1) > N  ,  return  ,  end
        if  curPos(2) < 1 || curPos(2) > M  ,  return  ,  end
        
        newVal = mod( 1 + curMat(curPos(1),curPos(2)) , 2 ) ;
        
    end


    function addPoint( curPos , newVal )
        
        curMat( curPos(1) , curPos(2) ) = newVal ;
        
        switch newVal
            
            case 0  ,  newDot = '.w' ;
            case 1  ,  newDot = '.k' ;
                
        end
        
        plot( ...
            curPos(1) - 0.5 , ...
            curPos(2) - 0.5 , ...
            newDot, ...
            'MarkerSize'    , dotSize )
        
    end


end