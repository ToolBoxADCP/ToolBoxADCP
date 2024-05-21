if size(temps.year,1)~=0
      tempsTot.year=[tempsTot.year;temps.year(1);temps.year;temps.year(end)];
      tempsTot.month=[tempsTot.month;temps.month(1);temps.month;temps.month(end)];
      tempsTot.day=[tempsTot.day;temps.day(1);temps.day;temps.day(end)];
      tempsTot.hour=[tempsTot.hour;temps.hour(1);temps.hour;temps.hour(end)];
      tempsTot.minute=[tempsTot.minute;temps.minute(1)-1;temps.minute;temps.minute(end)+1];
      tempsTot.seconde=[tempsTot.seconde;temps.seconde(1);temps.seconde;temps.seconde(end)];
      PositionTot.lat=[PositionTot.lat;NaN;Position.lat;NaN];
      PositionTot.lon=[PositionTot.lon;NaN;Position.lon;NaN];
          
          T_Tot=datum_str(tempsTot);
end
