unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListBox,
  FMX.ExtCtrls,
  HJF.ImageViewer, FMX.Objects;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FImageViewer: ThjImageViewer;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button2Click(Sender: TObject);
begin
  FImageViewer := ThjImageViewer.Create(nil);
  FImageViewer.Parent := Layout1;
  FImageViewer.Align := TAlignLayout.Client;
end;

end.
