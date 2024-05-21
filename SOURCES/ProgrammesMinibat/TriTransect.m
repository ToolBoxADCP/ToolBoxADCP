      [T_Position,I]=sort(T_Tot);
      TempsPosition.year=tempsTot.year(I);
      TempsPosition.month=tempsTot.month(I);
      TempsPosition.day=tempsTot.day(I);
      TempsPosition.hour=tempsTot.hour(I);
      TempsPosition.minute=tempsTot.minute(I);
      TempsPosition.seconde=tempsTot.seconde(I);
      Position.lat=PositionTot.lat(I);
      Position.lon=PositionTot.lon(I);
      
      ii=find(diff(T_Position)~=0);
      T_Position=T_Position(ii);
      TempsPosition.year=TempsPosition.year(ii);
      TempsPosition.month=TempsPosition.month(ii);
      TempsPosition.day=TempsPosition.day(ii);
      TempsPosition.hour=TempsPosition.hour(ii);
      TempsPosition.minute=TempsPosition.minute(ii);
      TempsPosition.seconde=TempsPosition.seconde(ii);
      Position.lat=Position.lat(ii);
      Position.lon=Position.lon(ii);
      
      AAA=[TempsPosition.year TempsPosition.month TempsPosition.day ...
          TempsPosition.hour TempsPosition.minute TempsPosition.seconde ...
          Position.lat Position.lon];
      save TransectAscii AAA -ascii

      

