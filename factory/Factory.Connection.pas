unit Factory.Connection;

interface

uses
  FireDac.Comp.Client,
  FireDac.Phys.MySQL,
//  MVCFramework.SQLGenerators.Sqlite;
  MVCFramework.SQLGenerators.MSSQL;

type
  TFDConnectionFactory = class
  public
    class function Connection : TFDConnection;
  end;

implementation

{ TFDConnectionFactory }

class function TFDConnectionFactory.Connection: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.Params.Clear;
  Result.DriverName := 'SQLite';
  Result.Params.AddPair('Database', 'D:\Projeto\DMVC\samples\data\activerecorddb.db');
  Result.LoginPrompt := False;
  Result.Connected := True;

  Result := TFDConnection.Create(nil);
  Result.Params.Clear;
  Result.DriverName := 'MSSQL';
  Result.Params.AddPair('Database', 'activerecorddb');
  Result.Params.AddPair('User_Name', 'dmvc');
  Result.Params.AddPair('Password', '111');
  Result.Params.AddPair('Server', 'server');
  Result.LoginPrompt := False;
  Result.Connected := True;
end;


end.
