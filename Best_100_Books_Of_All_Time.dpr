program Best_100_Books_Of_All_Time;

uses
  Forms,
  Best_100_Books_Of_All_Timep in 'Best_100_Books_Of_All_Timep.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
