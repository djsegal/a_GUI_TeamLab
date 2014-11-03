
function createText(obj)

begPos       =   get( obj.curFig , 'position' ) ;

textStrings  =  {  ...
    'mass'   ,  num2str(obj.mass)  ,  ...
    'radius' ,  num2str(obj.aggregateRadius) } ;

textLocs     =  {
    [       0      .90*begPos(4) .5*begPos(4) .04*begPos(4) ] , ...
    [       0      .94*begPos(4) .5*begPos(4) .06*begPos(4) ] , ...
    [ .5*begPos(4) .90*begPos(4) .4*begPos(4) .04*begPos(4) ] , ...
    [ .5*begPos(4) .94*begPos(4) .4*begPos(4) .06*begPos(4) ] }  ;

for i = 1 : 4
    obj.aggText(i) = uicontrol ;
    set( obj.aggText(i) , 'string'   , textStrings{i} ) ;
    set( obj.aggText(i) , 'position' , textLocs{i}    ) ;
end

set( obj.aggText  ,  ...
    'style'       , 'text'       , ...
    'parent'      ,  obj.curFig  , ...
    'FontUnits'   , 'normalized' , ...
    'Fontsize'    ,  1           , ...
    'units'       , 'pixels'     )  ;

end