unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListBox,
  FMX.ExtCtrls,
  HJF.ImageSlider, FMX.Objects;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Rectangle1: TRectangle;
    Button3: TButton;
    Rectangle2: TRectangle;
    Button4: TButton;
    Button5: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    FImageSlider: TImageSlider;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
begin
  FImageSlider.Next;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  FImageSlider := TImageSlider.Create(nil);
  FImageSlider.Parent := Layout1;
  FImageSlider.Align := TAlignLayout.Client;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  FImageSlider.Prev;
end;

end.
