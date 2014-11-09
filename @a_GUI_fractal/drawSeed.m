
function drawSeed( obj )

N        =  2 * obj.radX + 1 ;
M        =  2 * obj.radY + 1 ;

if isempty( obj.seedMatrix ) 
   
    obj.seedMatrix = zeros( N , M )  ;
    
end

figPos   =  [ .5 .2 .4 .6 ]  ;

tmpMat   =  obj.seedMatrix   ; 

if  tmpMat( obj.radX+1 , obj.radY+1 ) && ...
    sum( sum(tmpMat) ) == 1 

    tmpMat( obj.radX+1 , obj.radY+1 ) =  0 ;
    
end

clickOn  =  false  ;

curVal   =  0      ;

dotSize  =  0      ;

tmpFig   =       figure(          'windowstyle'  ,     'modal'    , ...
    'units'  ,  'normalized'   ,  'position'     ,     figPos     , ...
    'name'   ,  'drawSeed'     ,  'numbertitle'  ,      'off'     )  ;

tmpAx    =       axes(             ...
    'units'  ,  'normalized'   ,  'parent'       ,     tmpFig     , ...
    'xtick'  ,   [ ]           ,  'ytick'        ,    [      ]    )  ;

done     =       uicontrol(        ...
    'callback'  , @drawDone    ,  'string'       ,    'done'      )  ;

restart  =       uicontrol(        ...
    'callback'  , @drawClear   ,  'string'       ,    'clear'     )  ;    

cancel   =       uicontrol(        ...
    'callback'  , @drawCancel  ,  'string'       ,    'cancel'    )  ;

curButtons  =  [ done , cancel , restart ]  ;

set(               curButtons  ,    ...
    'units'     , 'normalized' ,  'parent'       ,     tmpFig     , ...
    'fontUnits' , 'normalized' ,  'style'        ,   'pushButton' )  ;

hold all

resize

set( tmpFig , 'WindowButtonDownFcn'   , @begClick ) ;
set( tmpFig , 'WindowButtonMotionFcn' , @midClick ) ;
set( tmpFig , 'WindowButtonUpFcn'     , @endClick ) ;
set( tmpFig , 'resizefcn'             , @resize   ) ;


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


    function resize(varargin)
        
        set( tmpAx   , 'units'     , 'normalized' )
        
        set( tmpAx   , 'position'  , [ 0 .1 1 .9 ]  )
        
        set( tmpAx   , 'units'     ,   'inches'   )
                 
        set( done    , 'position'  , [ 0/3 0 1/3 .1 ]  )

        set( restart , 'position'  , [ 1/3 0 1/3 .1 ]  )
        
        set( cancel  , 'position'  , [ 2/3 0 1/3 .1 ]  )
         
        set( curButtons ,  'fontsize' , .6 ) ;
        
        tmpVector  =  get( tmpAx ,  'position'  ) ;
        
        dotSize    =  min( tmpVector(3:4) ) ;
        
        dotSize    =  dotSize * 72 * 2 / max( N , M )  ; % 72 dots per inch
        
        remake
        
    end


    function remake
        
        cla( tmpAx )
        
        for     i = 1 : N  ,  plot( [ i i ] , [ 0 M ] , 'k' )  ,  end
        for     j = 1 : M  ,  plot( [ 0 N ] , [ j j ] , 'k' )  ,  end
        
        for     i = 1 : N
            for j = 1 : M
                
                if tmpMat(i,j) == 1
                    
                    addPoint( [ i j ] , 1 )
                    
                end
                
            end
        end
        
    end


    function drawDone(varargin)
        
        obj.seedMatrix  =  tmpMat  ;
        
        plantSeed(obj)
        
        close( tmpFig )
        
    end


    function drawClear(varargin)
       
        tmpMat  =  zeros( size(tmpMat,1) , size(tmpMat,2) )  ; 
        
        remake
        
    end


    function drawCancel(varargin)
        
        close( tmpFig )
        
    end


    function [ curPos , newVal ] = getPosition
        
        curPt  = get( tmpAx , 'currentpoint' ) ;
        
        curPos = floor( curPt(1,1:2) + 1 ) ;
        
        newVal = -1 ;  %  set for early returns
        
        if  curPos(1) < 1 || curPos(1) > N  ,  return  ,  end
        if  curPos(2) < 1 || curPos(2) > M  ,  return  ,  end
        
        newVal = mod( 1 + tmpMat(curPos(1),curPos(2)) , 2 ) ;
        
    end


    function addPoint( curPos , newVal )
        
        tmpMat( curPos(1) , curPos(2) ) = newVal ;
        
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