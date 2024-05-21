function [t,P]=LectureDonneesPression(DonneesPression,T0);
  load (DonneesPression)
  t=(datum_str(Temps)-T0)*24*3600;
  P=P.depth;
end
