% Autor:  foqc
% Fecha: 01/01/2019

%        The Water Jug Riddle by foqc
meta(estado(4,_)).
                  % CJG= amount of water in the large jar,   CJP= amount of water in the small jar
                  % MJG= maximum capacity of the large jug,    MJP= maximum capacity of the small jug.

posible(estado(CJG,CJP), estado(CJG1, CJP), MJG, _):- CJG>=0, CJG < MJG, CJG1 is MJG. % llena jarra gande
posible(estado(CJG,CJP), estado(CJG, CJP1), _, MJP):- CJP>=0, CJP < MJP, CJP1 is MJP. % LLENA JARRA peque;a
posible(estado(CJG,CJP),estado(CJG1,CJP), _, _):- CJG > 0, CJG1 is 0.% vaciar jarra grande
posible(estado(CJG,CJP),estado(CJG,CJP1), _, _):- CJP > 0, CJP1 is 0.% vaciar jarra peque;a
posible(estado(CJG,CJP),estado(CJG1,CJP1), _, MJP):- CJG > 0, CJP < MJP, CJG =< (MJP - CJP), CJG1 is 0, CJP1 is CJP + CJG.% pasar de jarra grande a peque;a cuando agua jarra grande es menor CJP
posible(estado(CJG,CJP),estado(CJG1,CJP1), _, MJP):- CJG > 0, CJP < MJP, CJG > (MJP - CJP), CJG1 is CJG - (MJP - CJP), CJP1 is MJP.% pasar de jarra grande a peque;a cuando agua jarra grande es mayor CJP
posible(estado(CJG,CJP),estado(CJG1,CJP1), MJG, _):- CJP > 0, CJG < MJG, CJP =< (MJG - CJG), CJP1 is 0, CJG1 is CJG + CJP .% pasar de jarra peque;a a grande cuando el agua CJP menor   agua CJG
posible(estado(CJG,CJP),estado(CJG1,CJP1), MJG, _):- CJP > 0, CJG < MJG, CJP > (MJG - CJG), CJP1 is CJP - (MJG - CJG), CJG1 is MJG.% pasar de jarra peque;a a grande cuando CJP es mayor a lo que falta para llenar a la jarra grande

          /* COMPARE THE NEW STATE WITH THE PREVIOUS */
miembro(X,[X|_]).
miembro(X,[_|L]):-miembro(X,L).

         /* IMPLEMENTING THE SOLUTION */

solucion([E|L],[E|L],MJG,MJP):-meta(E).
solucion([E|L],LS,MJG,MJP):- posible(E,EP,MJG,MJP),not(miembro(EP,L)),solucion([EP,E|L],LS,MJG,MJP).


% to run => solucion([estado(0, 0)], L, 5, 3).