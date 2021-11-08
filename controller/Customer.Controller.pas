unit Customer.Controller;

interface

uses
  MVCFramework, MVCFramework.Commons, MVCFramework.Serializer.Commons,
  MVCFramework.ActiveRecord, System.Generics.Collections;

type

  [MVCPath('/api')]
  TCustomerController = class(TMVCController)
  public
    //Sample CRUD Actions for a "Customer" entity
    [MVCPath('/customers')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomers;


    constructor Create; override;
    destructor Destroy; override;

  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, Factory.Connection,
  Model.Customer;

procedure TCustomerController.GetCustomers;
var
  LCustomers : TObjectList<TCustomerModel>;
  LLimit,
  LSkip : Integer;
begin
  LLimit := 5;
  LSkip := 0;

  if Context.Request.QueryStringParamExists('limit') then
    LLimit := StrToIntDef(Context.Request.QueryStringParam('limit'), 5);

  if Context.Request.QueryStringParamExists('skip') then
  begin
    LSkip := StrToIntDef(Context.Request.QueryStringParam('skip'), 0);
  end;

  LCustomers := TMVCActiveRecord.SelectRQL<TCustomerModel>(Format('limit(%d,%d)', [LSkip, LLimit]), LLimit);
  Render<TCustomerModel>(LCustomers);
end;

constructor TCustomerController.Create;
begin
  inherited;
  ActiveRecordConnectionsRegistry.AddDefaultConnection(TFDConnectionFactory.Connection);
end;


destructor TCustomerController.Destroy;
begin
  ActiveRecordConnectionsRegistry.RemoveDefaultConnection;
  inherited;
end;

end.
