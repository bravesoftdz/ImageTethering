unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.ListBox;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    CornerButton1: TCornerButton;
    OpenDialog1: TOpenDialog;
    ListBox1: TListBox;
    Button1: TButton;
    procedure CornerButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  ResourceStrings, System.IOUtils, System.StrUtils;

procedure TForm1.Button1Click(Sender: TObject);
var
  Path, Ext: string;
  SearchRec: TSearchRec;
  Masks: array of string;
begin
  Masks := ['.jpg', '.png'];

  Path := Edit1.Text;
  if FindFirst(TPath.Combine(Path, '*.*'), faAnyFile, SearchRec) = 0 then // DO NOT LOCALIZE
  try
    repeat
      Ext := ExtractFileExt(SearchRec.Name);
      if not MatchStr(Ext, Masks) then
        Continue;

      ListBox1.Items.Add(Format('%s, %d, %d', [
          SearchRec.Name,
          SearchRec.Size,
          SearchRec.Attr
        ]));
    until (FindNext(SearchRec) <> 0);
  finally
    FindClose(SearchRec);
  end;
end;

procedure TForm1.CornerButton1Click(Sender: TObject);
var
  Path: string;
begin
  if SelectDirectory(MSG_SELECT_ROOTDIR, '', Path) then
  begin
    Edit1.Text := Path;
  end;

end;

end.
