unit HJF.ImageViewer;

interface

uses
  System.Classes, System.Generics.Collections, System.UIConsts,
  FMX.Controls, FMX.Objects;

type
  ThjImageViewer = class(TStyledControl)
  private
    FList: TList<TRectangle>;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure MoveNext;
    procedure MovePrev;
    procedure MoveFirst;
    procedure MoveLast;
  end;

implementation

{ ThjImageViewer }

constructor ThjImageViewer.Create(AOwner: TComponent);
var
  Rect: TRectangle;
begin
  inherited;

  FList := TList<TRectangle>.Create;

  Rect := TRectangle.Create(Self);
  Rect.Parent := Self;
  Rect.Fill.Color := claRed;
  Rect.Width := Self.Width;
end;

destructor ThjImageViewer.Destroy;
begin
  FList.Free;

  inherited;
end;

procedure ThjImageViewer.MoveFirst;
begin

end;

procedure ThjImageViewer.MoveLast;
begin

end;

procedure ThjImageViewer.MoveNext;
begin

end;

procedure ThjImageViewer.MovePrev;
begin

end;

end.
