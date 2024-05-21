      [T_Data,I]=sort(T_Data);
      tempsData.year=tempsData.year(I);
      tempsData.month=tempsData.month(I);
      tempsData.day=tempsData.day(I);
      tempsData.hour=tempsData.hour(I);
      tempsData.minute=tempsData.minute(I);
      tempsData.seconde=tempsData.seconde(I);
      PositionData.lat=PositionData.lat(I);
      PositionData.lon=PositionData.lon(I);
      
      DataTot.Pression=DataTot.Pression(I);
      DataTot.Salinite=DataTot.Salinite(I);
      DataTot.Temperature=DataTot.Temperature(I);
      DataTot.Fluorimetrie=DataTot.Fluorimetrie(I);
      DataTot.Turbidite=DataTot.Turbidite(I);
      AAA=[tempsData.year tempsData.month tempsData.day ...
          tempsData.hour tempsData.minute tempsData.seconde ...
          PositionData.lat PositionData.lon DataTot.Pression...
          DataTot.Salinite DataTot.Temperature...
          DataTot.Fluorimetrie DataTot.Turbidite];
      save DataProfilAscii AAA -ascii
      save DataProfil tempsData PositionData DataTot T_Data
          

