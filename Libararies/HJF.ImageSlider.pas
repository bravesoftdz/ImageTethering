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
    FSlideIndex: Integer;
    FSlideCount: Integer;
    FBufferCount: Integer;
    procedure CreateSlides;
    procedure GotoSlide(const Index: Integer);
    procedure SetBufferCount(const Value: Integer);
  strict private
    procedure RealignSlides;
  protected
    procedure DoRealign; override;
  public
    constructor Create(AOwner: TComponent); override;

    property BufferCount: Integer read FBufferCount write SetBufferCount;
    property SlideIndex: Integer read FSlideIndex;

    procedure NextSlide;
    procedure PrevSlide;
  end;

  TImageSlider = class(TStyledControl)
  private const
    DefaultBufferCount = 2;
  private
    FContents: TSlideContents;
    FList: TList<TRectangle>;
    FCurrentIndex: Integer;
    FBufferCount: Integer;
    FCount: Integer;
    procedure SetBufferCount(const Value: Integer);
  protected
    procedure DoRealign; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Next;
    procedure Prev;
    property Count: Integer read FCount;
  published
    property BufferCount: Integer read FBufferCount write SetBufferCount;
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

  FSlideIndex := 0;
end;

procedure TSlideContents.CreateSlides;
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

  for I := 0 to FSlideCount - 1 do
  begin
    Slide := TSlide.Create(Self);
    Slide.Parent := Self;
    Slide.HitTest := False;
    Slide.Size.Size := FImageSlider.Size.Size;
//    Slide.ClipChildren := True;
    Slide.Position.X := (Slide.Width + 10) * I;
    Slide.Position.Y := 0;

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

procedure TSlideContents.DoRealign;
begin
  inherited;

  if ChildrenCount = 0 then
    CreateSlides;
  RealignSlides;
end;

procedure TSlideContents.GotoSlide(const Index: Integer);
var
  I: Integer;
begin
  TAnimator.AnimateFloat(Self, 'Position.X', (FImageSlider.Width + 10) * -Index);
end;

procedure TSlideContents.NextSlide;
var
  Slide: TSlide;
  TargetIndex: Integer;
begin
  TargetIndex := FSlideIndex mod FSlideCount + 3;
  TargetIndex := TargetIndex mod 5;

  Inc(FSlideIndex);
  GotoSlide(FSlideIndex);

  Slide := Children[TargetIndex] as TSlide;
  Slide.Position.X := (Slide.Width + 10) * (FSlideIndex + 2);
//  Slide.Position.Y := 10;
end;

procedure TSlideContents.PrevSlide;
begin
  Dec(FSlideIndex);
  GotoSlide(FSlideIndex);
end;

procedure TSlideContents.RealignSlides;
begin
//    Slide.Position.X := (Slide.Width + 10) * (I - FImageSlider.FCurrentIndex);
//    Slide.Position.Y := 0;
end;

procedure TSlideContents.SetBufferCount(const Value: Integer);
begin
  if FBufferCount = Value then
    Exit;

  FBufferCount := Value;
  FSlideCount := FBufferCount * 2 + 1;
end;

{ ThjImageViewer }

constructor TImageSlider.Create(AOwner: TComponent);
begin
  inherited;

  FBufferCount := DefaultBufferCount;

  FContents := TSlideContents.Create(Self);
  FContents.Parent := Self;
  FContents.HitTest := False;
  FContents.Locked := True;
  FContents.Stored := False;
  FContents.ClipChildren := False;
  FContents.BufferCount := FBufferCount;

  FCount := 10;
end;

destructor TImageSlider.Destroy;
begin
  FList.Free;

  inherited;
end;

procedure TImageSlider.DoRealign;
begin
  inherited;

  FContents.Realign;
end;

procedure TImageSlider.Next;
begin
  if FCount - 1 > FContents.SlideIndex then
    FContents.NextSlide;
end;

procedure TImageSlider.Prev;
begin
  if FContents.SlideIndex > 0 then
    FContents.PrevSlide;
end;

procedure TImageSlider.SetBufferCount(const Value: Integer);
begin
  if FBufferCount = Value then
    Exit;

  FBufferCount := Value;
  FContents.BufferCount := Value;
  FContents.Realign;
end;

end.
