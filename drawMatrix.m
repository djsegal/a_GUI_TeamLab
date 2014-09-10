
function drawMatrix

L        =  5  ;

figPos   =  [ .5 .2 .4 .6 ]  ;

curMat   =  zeros( L )  ;

clickOn  =  false  ;

curVal   =  0      ;

curFig   =       figure(         'menubar'      ,    'none'     , ...
    'units'  ,  'normalized'  ,  'position'     ,    figPos     , ...
    'name'   ,  'drawMatrix'  ,  'numbertitle'  ,    'off'      )  ;

curAx    =       axes( ...
    'units'  ,  'normalized'  ,  'position'     ,  [ 0 0 1 1 ]  , ...
    'xtick'  ,   [ ]          ,  'ytick'        ,  [         ]  )  ;

hold all

for i = 1 : L
    
    plot( [ 0 L ] , [ i i ] , 'k' )
    plot( [ i i ] , [ 0 L ] , 'k' )
    
end

set( curFig , 'WindowButtonDownFcn'   , @begClick ) ;
set( curFig , 'WindowButtonMotionFcn' , @midClick ) ;
set( curFig , 'WindowButtonUpFcn'     , @endClick ) ;


    function begClick(varargin)
        
        [         curPos , newVal , newDot ] = getPosition ;
        
        addPoint( curPos , newVal , newDot )
        
        clickOn  =  true    ;
        
        curVal   =  newVal  ;
        
    end


    function midClick(varargin)
        
        if ~clickOn          ,  return  ,  end
        
        [ curPos , newVal , newDot ] = getPosition ;
        
        if newVal ==   -1    ,  return  ,  end
        if newVal ~= curVal  ,  return  ,  end
        
        addPoint( curPos , newVal , newDot )
        
    end


    function endClick(varargin)
        
        clickOn  =  false    ;
        
    end


    function [ curPos , newVal , newDot ] = getPosition
        
        curPt  = get( curAx , 'currentpoint' ) ;
        
        curPos = floor( curPt(1,1:2) + 1 ) ;
        
        newVal = -1 ;  %  set for early returns
        newDot = '' ;  %  set for early returns
        
        if curPos(1) < 1               ,  return  ,  end
        if curPos(2) < 1               ,  return  ,  end
        
        if curPos(1) > size(curMat,1)  ,  return  ,  end
        if curPos(2) > size(curMat,2)  ,  return  ,  end
        
        switch curMat( curPos(1) , curPos(2) )
            
            case 0  ,  newVal = 1  ;  newDot = '.k'  ;
            case 1  ,  newVal = 0  ;  newDot = '.w'  ;
                
        end
        
    end


    function addPoint( curPos , newVal , newDot )
        
        curMat( curPos(1) , curPos(2) ) = newVal ;
        
        plot( ...
            curPos(1) - 0.5 , ...
            curPos(2) - 0.5 , ...
            newDot, ...
            'MarkerSize'    , 100 )
        
    end


end