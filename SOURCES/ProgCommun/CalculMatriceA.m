function [A]=CalculMatriceA(Point,Vit,ImpVit_M,CouplVitesse,degPol)


A=[];
A.u=[];
A.v=[];
VitM=[Vit.u Vit.v];
if(CouplVitesse==0)
    vect=ones(1,size(Vit.u,2));
else
    vect=ones(1,size(VitM,2));
end

for deg=ImpVit_M:degPol;
  if(CouplVitesse==0)
    A.u=[A.u (Point.^deg) (Point.^deg*vect).*Vit.u];
    A.v=[A.v (Point.^deg) (Point.^deg*vect).*Vit.v];
  else
      A.u=[A.u (Point.^deg) (Point.^deg*vect).*VitM];
      A.v=[A.v (Point.^deg) (Point.^deg*vect).*VitM];
  end
end
