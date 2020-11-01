unit Best_100_Books_Of_All_Timep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, FileCtrl, ComCtrls, ShellAPI;

type
  TForm1 = class(TForm)
    Books_To_Search_For_ListBox: TListBox;
    Resulting_Book_File_Names_ListBox: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    All_Books_ListBox: TListBox;
    BitBtn3: TBitBtn;
    All_Books_Label: TLabel;
    Temp_Memo: TMemo;
    Book_Label: TLabel;
    Current_Book_ProgressBar: TProgressBar;
    Books_ProgressBar: TProgressBar;
    Progress_Label: TLabel;
    BitBtn4: TBitBtn;
    Resulting_Book_File_Names_Label: TLabel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Missing_Books_ListBox: TListBox;
    Missing_Books_Label: TLabel;
    BitBtn7: TBitBtn;
    All_Missing_Books_ListBox: TListBox;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    All_Missing_Books_Label: TLabel;
    All_Found_Books_ListBox: TListBox;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    All_Found_Books_Label: TLabel;
    BitBtn12: TBitBtn;
    Halt_Processing_CheckBox: TCheckBox;
    BitBtn13: TBitBtn;
    All_Books_Processed_Names_ListBox: TListBox;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Resulting_Book_File_Names_ListBoxDblClick(Sender: TObject);
    procedure All_Books_ListBoxDblClick(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

CONST
     CR_LF_Constant              = #13#10;     { CR LF for MessageDlg's, etc.  }
     //Book_List_File_Names                = 'C:\00__Downloads\Books - ebooks\00 - List eBooks.txt';
     Book_List_File_Names                  = '00 - List eBooks.txt';
     Book_List_File_Processed_Names        = '00 - List eBooks_processed_Names.txt';
     Books_To_Search_For_ListBox_File_Name = '00 - List eBooks_search_list.txt';
     //Book_List_File_Names                = '00 - List eBooks - testing.txt';
     //Book_List_File_Names                = '00 - List eBooks - testing - 1 line.txt';
var
  Form1: TForm1;

implementation

{$R *.DFM}

{$I listmemo.inc}       { Functions for processing of Memo's and ListBoxes and Comboboxes.}
{$I textutil.inc}       { Text Handling Utilities : Replace, etc }
{$I win_api.inc}        { Functions and Procedures to support Windows API calls. }


Function TEXTUTIL_Replace_Accented_Chars_In_String (In_String : String) : String;
CONST
     { I got this list of accented chars from:
       PHP - Filter replace accented characters with accent-less equivalent
       http://snipplr.com/view/42863/
     }                                          { 1   2   3    4    5   6   7   8   9   0   1   2   3   4   5   6   7   8   9   0   1   2   3   4   5   6   7   8   9   0   }
     ACCENTED_CHARS : Array [1..30] of String = (',','ç','æ', 'œ', 'á','é','í','ó','ú','à','è','ì','ò','ù','ä','ë','ï','ö','ü','ÿ','â','ê','î','ô','û','å','e','i','ø','u');
     NORMAL_CHARS   : Array [1..30] of String = (',','c','ae','oe','a','e','i','o','u','a','e','i','o','u','a','e','i','o','u','y','a','e','i','o','u','a','e','i','o','u');
Var
   k : Integer;
   Result_String : String;
begin
     If Length (ACCENTED_CHARS) <> Length (NORMAL_CHARS) then
     begin
          { The end-user should NEVER see this error .... }
          MessageDlg ('Error: array length mismatch in method "TEXTUTIL_Replace_Accented_Chars_In_String": ' +
                      CR_LF_Constant + CR_LF_Constant +
                      'ACCENTED_CHARS ('  + IntToStr (Length (ACCENTED_CHARS)) + ') ' +
                      'Vs NORMAL_CHARS (' + IntToStr (Length (NORMAL_CHARS))   + ').',
                      mtError, [mbOk], 0);
          Exit;
     end;

     Result_String := In_String;

     For k := 1 To Length (ACCENTED_CHARS) do
     begin
          Result_String := StringReplace (Result_String,  ACCENTED_CHARS [k], NORMAL_CHARS [k],
                                          [rfIgnoreCase, rfReplaceAll]);
     end;
     Result := Result_String;
end;

Function Does_Text_Contan_All_Words (In_Text, In_Word_List, In_Delimiter : String) : Boolean;
Var
   w                            : Integer;
   Curr_Word                    : String;
   All_Words_Checked,
   Does_Text_Contains_All_Words_Flag : Boolean;
begin
     Does_Text_Contains_All_Words_Flag := True; // Assume YES and try and prove it wrong.

     All_Words_Checked                 := False;
     w := 1;

     While (All_Words_Checked = False) AND (Does_Text_Contains_All_Words_Flag = True) do
     begin
          Curr_Word := TEXTUTIL_Get_Field_From_Comma_Seperated_List (w, In_Delimiter, In_Word_List);

          If (Curr_Word = '') then
          begin
               All_Words_Checked := True;
          end

          Else If (Length (Curr_Word) <= 3) then
          begin
               // Skip word - this cuts out initials, etc: J.R.R. JRR J. R. R.
          end

          Else If (POS ('.', Curr_Word) > 0) then
          begin
               // Skip word - this cuts out initials, etc: J.R.R. JRR J. R. R.
          end

          Else
          begin
               If (POS (Curr_Word, In_Text) = 0) Then
               begin
                    Does_Text_Contains_All_Words_Flag := False;
               end;
          end;

          INC (w);
     end;

     Result := Does_Text_Contains_All_Words_Flag;
end;

Function Process_Book_Name (In_Book_Name : String) : String;
begin
     In_Book_Name := LowerCase (In_Book_Name); // Because POS is case sensitive.

     In_Book_Name := TEXTUTIL_Replace_Accented_Chars_In_String (In_Book_Name);

     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, '[',  ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, ']',  ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, '(',  ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, ')',  ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, '.',      ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, '-',      ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, Chr(150), ' ');  // –  Hex $96.
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, ',',      ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, '&',      ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, ':',      ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, '’',      ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, '''',     ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, '`',      ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, 'by',     ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, 'the',    ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, 'with',     ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, 'and',     ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, 'sir',    ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, 'sir',    ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, 'series',    ' '); // Happy Potter series
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, 'anonymous', ' ');  // remove anonymous as author name.
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, 'adventures of',    ' '); // adventures of sherlock holmes
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, 'captain corelli',    'corelli'); // Corelli's Mandolin is the correct title.
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, 'bernie res',    'bernieres'); // Bernie'res author.

     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, '''',      ' ');
     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, Chr(146), ' ');  // ` Hex $92.

     In_Book_Name := TEXTUTIL_Replace (In_Book_Name, '  ',     ' '); // 2 spaces -> 1

     In_Book_Name := TRIM (In_Book_Name);

     Result := In_Book_Name;
end;


procedure TForm1.BitBtn3Click(Sender: TObject);
begin
     Halt_Processing_CheckBox.Checked := False;

     All_Books_ListBox.Items.Clear;
     All_Books_Processed_Names_ListBox.Items.Clear;

     If FileExists (Book_List_File_Names) then
     begin
          All_Books_ListBox.Items.LoadFromFile                 (Book_List_File_Names);
     end;

     If FileExists (Book_List_File_Processed_Names) then
     begin
          All_Books_Processed_Names_ListBox.Items.LoadFromFile (Book_List_File_Processed_Names);
     end;

     All_Books_Label.Caption := IntToStr (All_Books_ListBox.Items.Count) + ' lines (' +
                                IntToStr (All_Books_Processed_Names_ListBox.Items.Count) + ' in processed list).';
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
Var
   k             : LongInt;
begin
     Halt_Processing_CheckBox.Checked := False;

     Books_To_Search_For_ListBox.Items.Clear;
     Resulting_Book_File_Names_ListBox.Items.Clear;
     Missing_Books_ListBox.Items.Clear;

     LISTMEMO_Copy_Clipboard_to_ListBox (Books_To_Search_For_ListBox, Temp_Memo);

     For k := 0 To Books_To_Search_For_ListBox.Items.Count - 1 do
     begin
          Books_To_Search_For_ListBox.Items [k] := TRIM (Books_To_Search_For_ListBox.Items [k]);
     end;

     Book_Label.Caption := IntToStr (Books_To_Search_For_ListBox.Items.Count) + ' lines.';
     Missing_Books_Label.Caption := IntToStr (Missing_Books_ListBox.Items.Count) + ' missing books.';
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
Var
   Book_Name_Words  : String;
   Book_Found       : Boolean;
   Matches_Found,
   k, b             : LongInt;
begin
     Halt_Processing_CheckBox.Checked := False;

     If (Books_To_Search_For_ListBox.Items.Count                      = 0) Then
     begin
          MessageDlg ('Error: there are no books to search for.',
                      mtError, [mbOk], 0);
          Exit;  // Do Nothing.
     end;

     If (All_Books_ListBox.Items.Count                 = 0) OR
        (All_Books_Processed_Names_ListBox.Items.Count = 0) Then
     begin
          MessageDlg ('Error: One or more Master Book Lists are empty:' +
                      CR_LF_Constant + CR_LF_Constant +
                      'All_Books_ListBox (' + IntToStr (All_Books_ListBox.Items.Count) +
                      ') VS All_Books_Processed_Names_ListBox (' + IntToStr (All_Books_Processed_Names_ListBox.Items.Count) + ').',
                      mtError, [mbOk], 0);
          Exit;  // Do Nothing.
     end;

     If (All_Books_ListBox.Items.Count                 <> All_Books_Processed_Names_ListBox.Items.Count) Then
     begin
          MessageDlg ('Error: Master Book List sizes do NOT match:  ' +
                      CR_LF_Constant + CR_LF_Constant +
                      'All_Books_ListBox (' + IntToStr (All_Books_ListBox.Items.Count) +
                      ') VS All_Books_Processed_Names_ListBox (' + IntToStr (All_Books_Processed_Names_ListBox.Items.Count) + ').',
                      mtError, [mbOk], 0);
          Exit;  // Do Nothing.
     end;

     Matches_Found := 0;

     Missing_Books_ListBox.Items.Clear;
     Resulting_Book_File_Names_ListBox.Items.Clear;

     Missing_Books_Label.Caption := IntToStr (Missing_Books_ListBox.Items.Count) + ' missing books.';

     All_Missing_Books_Label.Caption := IntToStr (All_Missing_Books_ListBox.Items.Count) + ' missing books.';

     Resulting_Book_File_Names_Label.Caption := IntToStr (Resulting_Book_File_Names_ListBox.Items.Count) + ' lines, ' +
                                                IntToStr (Matches_Found) + ' matches found.';

     Books_ProgressBar.Position := 0;
     Books_ProgressBar.Max      := Books_To_Search_For_ListBox.Items.Count;

     k := 0;
     While (k <= Books_To_Search_For_ListBox.Items.Count - 1) AND (Halt_Processing_CheckBox.Checked = False) do
     //For k := 0 To Books_To_Search_For_ListBox.Items.Count - 1 do
     begin
          Books_ProgressBar.Position := k;

          Book_Name_Words := Process_Book_Name (Books_To_Search_For_ListBox.Items [k]);

          Progress_Label.Caption  := Book_Name_Words;

          Application.ProcessMessages;

          Current_Book_ProgressBar.Position := 0;
         // Current_Book_ProgressBar.Max      := All_Books_ListBox.Items.Count - 1;
          b := 0;
          Book_Found := False;

          While (b <= All_Books_ListBox.Items.Count - 1)  AND (Book_Found = False) AND
                (Halt_Processing_CheckBox.Checked = False) do
          begin
               Current_Book_ProgressBar.Position := b;

               If (Does_Text_Contan_All_Words (All_Books_Processed_Names_ListBox.Items [b], Book_Name_Words, ' ') = True) {AND
                  ((POS ('.mobi', All_Books_ListBox.Items [b]) > 0) OR
                   (POS ('.epub', All_Books_ListBox.Items [b]) > 0) OR
                   (POS ('.pdf',  All_Books_ListBox.Items [b]) > 0))     }  Then
               begin
                    Resulting_Book_File_Names_ListBox.Items.Add (All_Books_ListBox.Items [b]);

                    Resulting_Book_File_Names_Label.Caption := IntToStr (Resulting_Book_File_Names_ListBox.Items.Count) + ' lines, ' +
                                                               IntToStr (Matches_Found) + ' matches found.';

                    All_Found_Books_ListBox.Items.Add (All_Books_ListBox.Items [b]);

                    All_Found_Books_Label.Caption := IntToStr (All_Found_Books_ListBox.Items.Count) + ' found books.';

                    Book_Found := True;
                    INC (Matches_Found);


               end;

               Application.ProcessMessages;

               INC (b);
          end;

          If (Book_Found = False) Then
          begin
               // Add an empty line as a place holder.
               Resulting_Book_File_Names_ListBox.Items.Add ('');

               Missing_Books_ListBox.Items.Add (Books_To_Search_For_ListBox.Items [k]);
               Missing_Books_Label.Caption := IntToStr (Missing_Books_ListBox.Items.Count) + ' missing books.';

               All_Missing_Books_ListBox.Items.Add (Books_To_Search_For_ListBox.Items [k]);
               All_Missing_Books_Label.Caption := IntToStr (All_Missing_Books_ListBox.Items.Count) + ' missing books.';
          end;

          Current_Book_ProgressBar.Position := Current_Book_ProgressBar.Max;
          Application.ProcessMessages;

          INC (k);
     end;

     Books_ProgressBar.Position := Books_ProgressBar.Max;

     If (Halt_Processing_CheckBox.Checked = True) then
     begin
          Missing_Books_ListBox.Items.Clear;
          Resulting_Book_File_Names_ListBox.Items.Clear;

          Missing_Books_ListBox.Items.Add ('Processing Aborted !');
          Resulting_Book_File_Names_ListBox.Items.Add ('Processing Aborted !');
     end;

     Missing_Books_Label.Caption := IntToStr (Missing_Books_ListBox.Items.Count) + ' missing books.';

     All_Missing_Books_Label.Caption := IntToStr (All_Missing_Books_ListBox.Items.Count) + ' missing books.';

     Resulting_Book_File_Names_Label.Caption := IntToStr (Resulting_Book_File_Names_ListBox.Items.Count) + ' lines, ' +
                                                IntToStr (Matches_Found) + ' matches found.';

end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
     Halt_Processing_CheckBox.Checked := False;

     LISTMEMO_Copy_ListBox_to_Clipboard (Resulting_Book_File_Names_ListBox, Temp_Memo);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
     Halt_Processing_CheckBox.Checked := False;

     All_Books_ListBox.Items.SaveToFile                 (Book_List_File_Names);
     All_Books_Processed_Names_ListBox.Items.SaveToFile (Book_List_File_Processed_Names);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Temp_Memo.WordWrap := False;

     LISTMEMO__Add_Horizontal_Scroll_Bar (Books_To_Search_For_ListBox);
     LISTMEMO__Add_Horizontal_Scroll_Bar (Resulting_Book_File_Names_ListBox);
     LISTMEMO__Add_Horizontal_Scroll_Bar (All_Books_ListBox);
     LISTMEMO__Add_Horizontal_Scroll_Bar (All_Missing_Books_ListBox);

end;

procedure TForm1.BitBtn6Click(Sender: TObject);
Var
   b         : Integer;
   Book_Name : String;
begin
     Halt_Processing_CheckBox.Checked := False;

     If (All_Books_ListBox.Items.Count = 0) then
     begin
          Exit;  // Do Nothing.
     end;

     All_Books_Processed_Names_ListBox.Items.Clear;

     All_Books_ListBox.Items.BeginUpdate;

     Current_Book_ProgressBar.Position := 0;
     Current_Book_ProgressBar.Max      := All_Books_ListBox.Items.Count - 1;
     b := 0;

     While (b <= All_Books_ListBox.Items.Count - 1) AND (Halt_Processing_CheckBox.Checked = False) do
     begin
          Current_Book_ProgressBar.Position := b;

          Book_Name := LowerCase (All_Books_ListBox.Items [b]);

          Progress_Label.Caption  := IntToStr (b) + ' ...';

          If ((POS ('.mobi', Book_Name) > 0) OR
              (POS ('.epub', Book_Name) > 0) OR
              (POS ('.pdf',  Book_Name) > 0))       Then
          begin
               INC (b);

               Book_Name := Process_Book_Name (Book_Name); { Includes calling TEXTUTIL_Replace_Accented_Chars_In_String }

               All_Books_Processed_Names_ListBox.Items.Add (Book_Name);
          end
          Else
          begin
               All_Books_ListBox.Items.Delete (b);
          end;

          Application.ProcessMessages;
     end;

     Current_Book_ProgressBar.Position := Current_Book_ProgressBar.Max;

     All_Books_ListBox.Items.EndUpdate;

     All_Books_Label.Caption := IntToStr (All_Books_ListBox.Items.Count) + ' lines (' +
                                IntToStr (All_Books_Processed_Names_ListBox.Items.Count) + ' in processed list).';
end;

procedure TForm1.Resulting_Book_File_Names_ListBoxDblClick(
  Sender: TObject);
Var
   Selected_File : String;
begin
     Selected_File := LISTMEMO__Return_Selected_Item_By_Name (Resulting_Book_File_Names_ListBox);

     WIN_API_INC___Load_File_Into_Its_Associated_Application_EXE ('"' + Selected_File + '"', True);
end;

procedure TForm1.All_Books_ListBoxDblClick(Sender: TObject);
Var
   Selected_File : String;
begin
     Selected_File := LISTMEMO__Return_Selected_Item_By_Name (All_Books_ListBox);

     WIN_API_INC___Load_File_Into_Its_Associated_Application_EXE ('"' + Selected_File + '"', True);
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
     Halt_Processing_CheckBox.Checked := False;

     LISTMEMO_Copy_ListBox_to_Clipboard (Missing_Books_ListBox, Temp_Memo);
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
     Halt_Processing_CheckBox.Checked := False;

     All_Missing_Books_ListBox.Items.Clear;

     All_Missing_Books_Label.Caption := IntToStr (All_Missing_Books_ListBox.Items.Count) + ' missing books.';
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
begin
     Halt_Processing_CheckBox.Checked := False;

     LISTMEMO_Copy_ListBox_to_Clipboard (All_Missing_Books_ListBox, Temp_Memo);
end;

procedure TForm1.BitBtn10Click(Sender: TObject);
begin
     Halt_Processing_CheckBox.Checked := False;

     All_Found_Books_ListBox.Items.Clear;

     All_Found_Books_Label.Caption := IntToStr (All_Found_Books_ListBox.Items.Count) + ' found books.';
end;

procedure TForm1.BitBtn11Click(Sender: TObject);
begin
     Halt_Processing_CheckBox.Checked := False;

     LISTMEMO_Copy_ListBox_to_Clipboard (All_Found_Books_ListBox, Temp_Memo);
end;

procedure TForm1.BitBtn12Click(Sender: TObject);
begin
     Halt_Processing_CheckBox.Checked := True;
end;

procedure TForm1.BitBtn13Click(Sender: TObject);
begin
     Halt_Processing_CheckBox.Checked := True;

     Close;
end;

procedure TForm1.BitBtn15Click(Sender: TObject);
Var
   k : Integer;
begin
     Halt_Processing_CheckBox.Checked := False;

     Books_To_Search_For_ListBox.Items.Clear;
     Resulting_Book_File_Names_ListBox.Items.Clear;
     Missing_Books_ListBox.Items.Clear;

     If FileExists (Books_To_Search_For_ListBox_File_Name) then
     begin
          Books_To_Search_For_ListBox.Items.LoadFromFile                 (Books_To_Search_For_ListBox_File_Name);
     end;

     For k := 0 To Books_To_Search_For_ListBox.Items.Count - 1 do
     begin
          Books_To_Search_For_ListBox.Items [k] := TRIM (Books_To_Search_For_ListBox.Items [k]);
     end;

     Book_Label.Caption := IntToStr (Books_To_Search_For_ListBox.Items.Count) + ' lines.';
     Missing_Books_Label.Caption := IntToStr (Missing_Books_ListBox.Items.Count) + ' missing books.';
end;

procedure TForm1.BitBtn14Click(Sender: TObject);
begin
     Halt_Processing_CheckBox.Checked := False;

     Books_To_Search_For_ListBox.Items.SaveToFile                 (Books_To_Search_For_ListBox_File_Name);
end;

end.
