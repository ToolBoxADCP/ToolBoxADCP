
      tempsData.year=[tempsData.year;temps.year];
      tempsData.month=[tempsData.month;temps.month];
      tempsData.day=[tempsData.day;temps.day];
      tempsData.hour=[tempsData.hour;temps.hour];
      tempsData.minute=[tempsData.minute;temps.minute];
      tempsData.seconde=[tempsData.seconde;temps.seconde];
      PositionData.lat=[PositionData.lat;Lat];
      PositionData.lon=[PositionData.lon;Lon];
      
      DataTot.Salinite=[DataTot.Salinite;Salinite];
      DataTot.Temperature=[DataTot.Temperature;Temperature];
      DataTot.Fluorimetrie=[DataTot.Fluorimetrie;Fluorimetrie];
      DataTot.Turbidite=[DataTot.Turbidite;Turbidite];
      DataTot.Pression=[DataTot.Pression;Pression];
         
      T_Data=datum_str(tempsData)-T0;
