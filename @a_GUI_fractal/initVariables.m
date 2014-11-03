
function initVariables(obj)


% -------------------
%  Derived Variables
% -------------------

obj.seedColor               =  [ obj.seedColor , obj.dotsShape ]  ;
obj.dotsColor               =  [ obj.dotsColor , obj.dotsShape ]  ;

obj.diffusionRadius         =   obj.diffFactor * obj.startRadius  ;
obj.killRadius              =   obj.killFactor * obj.startRadius  ;

obj.diffusionRadiusSquared  =  obj.diffusionRadius ^ 2 ;   % Radii squared
obj.killRadiusSquared       =       obj.killRadius ^ 2 ;   % for efficiency

%                                  Diffusion Acceleration Radius
obj.diffAccelRadius         =  obj.diffusionRadius - obj.startRadius ;

% -------------
%  Grid Matrix
% -------------

obj.x0    =  obj.gridSize + 1  ;          % Define origin using offset coordinates
obj.y0    =  obj.gridSize + 1  ;

end