codeunit 50002 "Ex. Jnl.-Check Line"
{
  // version Exercise 3

  TableNo=50013;

  trigger OnRun();
  begin
    GLSetup.GET;
    RunCheck(Rec);
  end;

  var
    Text000 : TextConst ENU='cannot be a closing date',ESM='no puede ser una fecha última',FRC='ne peut être une date de fermeture',ENC='cannot be a closing date';
    Text001 : TextConst ENU='is not within your range of allowed posting dates',ESM='no está dentro del periodo de fechas de registro permitidas',FRC='n''est pas dans l''intervalle de dates de report permis',ENC='is not within your range of allowed posting dates';
    Text002 : TextConst ENU='The combination of dimensions used in %1 %2, %3, %4 is blocked. %5',ESM='La combin. de dimensiones utilizada en %1 %2, %3, %4 está bloq. %5',FRC='La combinaison de dimensions utilisée dans %1 %2, %3, %4 est bloquée. %5',ENC='The combination of dimensions used in %1 %2, %3, %4 is blocked. %5';
    Text003 : TextConst ENU='A dimension used in %1 %2, %3, %4 has caused an error. %5',ESM='La dimensión util. en %1 %2, %3, %4 ha causado error. %5',FRC='Une erreur a été causée par une dimension utilisée dans %1 %2, %3, %4. %5',ENC='A dimension used in %1 %2, %3, %4 has caused an error. %5';
    GLSetup : Record 98;
    UserSetup : Record 91;
    DimMgt : Codeunit 408;
    AllowPostingFrom : Date;
    AllowPostingTo : Date;

  PROCEDURE RunCheck(VAR ExJnlLine : Record 50013);
  var
    TableID : ARRAY [10] OF Integer;
    No : ARRAY [10] OF Code[20];
  begin
    WITH ExJnlLine DO BEGIN
      IF EmptyLine THEN
        EXIT;

      TESTFIELD("Example Person No.");
      TESTFIELD("Posting Date");
      TESTFIELD("Gen. Prod. Posting Group");

      IF "Posting Date" <> NORMALDATE("Posting Date") THEN
        FIELDERROR("Posting Date",Text000);

      IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
        IF USERID <> '' THEN
          IF UserSetup.GET(USERID) THEN BEGIN
            AllowPostingFrom := UserSetup."Allow Posting From";
            AllowPostingTo := UserSetup."Allow Posting To";
          END;
        IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
          GLSetup.GET;
          AllowPostingFrom := GLSetup."Allow Posting From";
          AllowPostingTo := GLSetup."Allow Posting To";
        END;
        IF AllowPostingTo = 0D THEN
          AllowPostingTo := DMY2Date(31, 12, 9999);//31129999D;
      END;
      IF ("Posting Date" < AllowPostingFrom) OR ("Posting Date" > AllowPostingTo) THEN
        FIELDERROR("Posting Date",Text001);

      IF "Document Date" <> 0D THEN
        IF "Document Date" <> NORMALDATE("Document Date") THEN
          FIELDERROR("Document Date",Text000);

      IF NOT DimMgt.CheckDimIDComb("Dimension Set ID") THEN
        ERROR(
          Text002,
          TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
          DimMgt.GetDimCombErr);

      TableID[1] := DATABASE::"Example Person";
      No[1] := "Example Person No.";
      IF NOT DimMgt.CheckDimValuePosting(TableID,No,"Dimension Set ID") THEN
        IF "Line No." <> 0 THEN
          ERROR(
            Text003,
            TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
            DimMgt.GetDimValuePostingErr)
        ELSE
          ERROR(DimMgt.GetDimValuePostingErr);
    END;
  end;
}

