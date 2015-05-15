unit HJF.ImageSlider;

interface

uses
  System.Classes, System.Generics.Collections,
  FMX.Types, FMX.Layouts, FMX.Controls, FMX.Objects;

type
  TImageSlider = class;

  TSlide = class(TLayout)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destory;
  end;

  TSlideContents = class(TControl)
  private
    [weak] FImageSlider: TImageSlider;
  strict private
    procedure RealignSlides;
  protected
    procedure DoRealign; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TImageSlider = class(TStyledControl)
  private const
    DefaultSlideCount = 10;
  private
    FContents: TSlideContents;
    FList: TList<TRectangle>;
    FCurrentIndex: Integer;
    FSlideCount: Integer;
    procedure SetSlideCount(const Value: Integer);
  protected
    procedure DoRealign; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure MoveNext;
    procedure MovePrev;
    procedure MoveFirst;
    procedure MoveLast;
  published
    property SlideCount: Integer read FSlideCount write SetSlideCount;
  end;

implementation

uses
  System.Types, System.SysUtils, System.UIConsts,
  FMX.Ani;
{ TSlide }

constructor TSlide.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TSlide.Destory;
begin

end;

{ TSlideContents }

constructor TSlideContents.Create(AOwner: TComponent);
begin
  inherited;

  if AOwner is TImageSlider then
    FImageSlider := TImageSlider(AOwner);
  ClipChildren := True;
end;

procedure TSlideContents.DoRealign;
begin
  inherited;

  RealignSlides;
end;

procedure TSlideContents.RealignSlides;
var
  I: Integer;
  Slide: TSlide;
{$IFDEF DEBUG}
  R: TRectangle;
  T: TText;
{$ENDIF}
begin
  for I := ChildrenCount - 1 downto 0 do
    Children[I].Free;

  for I := 0 to FImageSlider.SlideCount - 1 do
  begin
    Slide := TSlide.Create(Self);
    Slide.Parent := Self;
    Slide.HitTest := False;
    Slide.Size.Size := FImageSlider.Size.Size;
    Slide.Position.X := (Slide.Width + 10) * (I - FImageSlider.FCurrentIndex);
    Slide.Position.Y := 0;
//    Slide.ClipChildren := True;

{$IFDEF DEBUG}
    R := TRectangle.Create(Slide);
    R.Parent := Slide;
    R.Align := TAlignLayout.Client;

    T := TText.Create(Slide);
    T.Parent := Slide;
    T.Align := TAlignLayout.Client;
    T.Text := I.ToString;
    T.VertTextAlign := TTextAlign.Center;
    T.HorzTextAlign := TTextAlign.Center;
    T.Font.Size := 30;
{$ENDIF}
  end;
end;

{ ThjImageViewer }

constructor TImageSlider.Create(AOwner: TComponent);
var
  I: Integer;
  Slide: TRectangle;
begin
  inherited;

  FContents := TSlideContents.Create(Self);
  FContents.Parent := Self;
  FContents.HitTest := False;
  FContents.Locked := True;
  FContents.Stored := False;
  FContents.ClipChildren := False;

  FSlideCount := DefaultSlideCount;
//  ClipChildren := True;
{
  FList := TList<TRectangle>.Create;
  FCurrentIndex := 0;

  for I := 0 to 2 do
  begin
    Slide := TRectangle.Create(Self);
    Slide.Parent := Self;
    if I mod 2 = 0 then
      Slide.Fill.Color := claRed
    else
      Slide.Fill.Color := claBlue;
    // DEBUG
    Slide.ClipChildren := True;

    FList.Add(Slide);
  end;
}
end;

destructor TImageSlider.Destroy;
begin
  FList.Free;

  inherited;
end;

procedure TImageSlider.DoRealign;
var
  I: Integer;
  Slide: TRectangle;
begin
  inherited;

  FContents.Realign;
{
  for I := 0 to FList.Count - 1 do
  begin
    Slide := FList[I];
    Slide.Width  := Self.Width;
    Slide.Height := Self.Height;

    Slide.Position.X := (I - FCurrentIndex) * (Self.Width + 10);
    Slide.Position.Y := 0;
  end;
}
end;

procedure TImageSlider.MoveFirst;
begin
  FCurrentIndex := 0;
  TAnimator.AnimateFloat(FContents, 'Position.X', (Width + 10) * (-FCurrentIndex));
end;

procedure TImageSlider.MoveLast;
begin
  FCurrentIndex := SlideCount - 1;
  TAnimator.AnimateFloat(FContents, 'Position.X', (Width + 10) * (-FCurrentIndex));
end;

procedure TImageSlider.MoveNext;
begin
  if SlideCount - 1 > FCurrentIndex then
  begin
    Inc(FCurrentIndex);
    TAnimator.AnimateFloat(FContents, 'Position.X', (Width + 10) * (-FCurrentIndex));
  end;
end;

procedure TImageSlider.MovePrev;
begin
  if FCurrentIndex > 0 then
  begin
    Dec(FCurrentIndex);
    TAnimator.AnimateFloat(FContents, 'Position.X', (Width + 10) * (-FCurrentIndex));
  end;
end;

procedure TImageSlider.SetSlideCount(const Value: Integer);
begin
  if FSlideCount = Value then
    Exit;

  FSlideCount := Value;

  FContents.Realign;
end;

end.
