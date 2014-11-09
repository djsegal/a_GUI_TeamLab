
function buildLayout(obj)


obj.curFig   =   figure(         'menubar'      ,      'none'       , ...
    'units'  ,  'normalized'  ,  'position'     ,  [ .4 .1 .5 .6 ]  , ...
    'name'   ,  'Fractal'     ,  'numbertitle'  ,      'off'        )  ;

set( obj.curFig , 'units' , 'pixels' )

begPos       =   get( obj.curFig , 'position' ) ;

tmpLen       =   begPos(3) - .9 * begPos(4) ;

axesPos      =   [       0            0      .9*begPos(4) .9*begPos(4) ] ;
panPos       =   [ .9*begPos(4)       0         tmpLen       begPos(4) ] ;
obj.boxPos   =   [       0            0      .9*begPos(4)    begPos(4) ] ;   
     
obj.curAxes      =   axes( 'units' , 'pixels' , 'position' , axesPos )  ;

obj.curPanel     =  uipanel(   ...
    'parent'     ,  obj.curFig ,   'units'    , 'pixels' , ...
    'position'   ,  panPos     ) ;

axis([ obj.x0-1 obj.x0+1 obj.y0-1 obj.y0+1 ])  % Do initial Scaling
hold on                                        % Plot all points on same fig

set( obj.curAxes , 'xtick' , Inf , 'ytick' , Inf )    % Remove tick marks  


end