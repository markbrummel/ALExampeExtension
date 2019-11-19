codeunit 50006 "Ex. Jnl.-Post+Print"
{
  // version Exercise 3

  TableNo=50013;

  trigger OnRun();
  begin
    ExJnlLine.COPY(Rec);
    Code;
    COPY(ExJnlLine);
  end;

  var
    Text000 : TextConst ENU='cannot be filtered when posting recurring journals',ESM='no puede contener un filtro cuando se registra un diario periódico',FRC='ne peut pas être filtré lors du report des journaux récurrents',ENC='cannot be filtered when posting recurring journals';
    Text001 : TextConst ENU='Do you want to post the journal lines and print the posting report?',ESM='¿Confirma que desea registrar las líns. de diario e imprimir el informe de reg.?',FRC='Voulez-vous reporter les lignes du journal et imprimer le rapport d''affichage?',ENC='Do you want to post the journal lines and print the posting report?';
    Text002 : TextConst ENU='There is nothing to post.',ESM='No hay nada que registrar.',FRC='Il n''y a rien à reporter.',ENC='There is nothing to post.';
    Text003 : TextConst ENU='The journal lines were successfully posted.',ESM='Se han registrado correctamente las líneas del diario.',FRC='Les lignes de journal ont été reportées avec succès.',ENC='The journal lines were successfully posted.';
    Text004 : TextConst ENU='The journal lines were successfully posted. ',ESM='Se han registrado correctamente las líneas del diario. ',FRC='Les lignes de journal ont été reportées avec succès. ',ENC='The journal lines were successfully posted. ';
    Text005 : TextConst ENU='You are now in the %1 journal.',ESM='Se encuentra en el diario %1.',FRC='Vous êtes maintenant dans le journal %1.',ENC='You are now in the %1 journal.';
    ExJnlTemplate : Record 50012;
    ExJnlLine : Record 50013;
    ExReg : Record 50015;
    ExJnlPostBatch : Codeunit 50004;
    TempJnlBatchName : Code[10];

  LOCAL PROCEDURE "Code"();
  begin
    WITH ExJnlLine DO BEGIN
      ExJnlTemplate.GET("Journal Template Name");
      ExJnlTemplate.TESTFIELD("Posting Report ID");
      IF ExJnlTemplate.Recurring AND (GETFILTER("Posting Date") <> '') THEN
        FIELDERROR("Posting Date",Text000);

      IF NOT CONFIRM(Text001) THEN
        EXIT;

      TempJnlBatchName := "Journal Batch Name";

      ExJnlPostBatch.RUN(ExJnlLine);

      IF ExReg.GET("Line No.") THEN BEGIN
        ExReg.SETRECFILTER;
        REPORT.RUN(ExJnlTemplate."Posting Report ID",FALSE,FALSE,ExReg);
      END;

      IF "Line No." = 0 THEN
        MESSAGE(Text002)
      ELSE
        IF TempJnlBatchName = "Journal Batch Name" THEN
          MESSAGE(Text003)
        ELSE
          MESSAGE(
            Text004 +
            Text005,
            "Journal Batch Name");

      IF NOT FIND('=><') OR (TempJnlBatchName <> "Journal Batch Name") THEN BEGIN
        RESET;
        FILTERGROUP(2);
        SETRANGE("Journal Template Name","Journal Template Name");
        SETRANGE("Journal Batch Name","Journal Batch Name");
        FILTERGROUP(0);
        "Line No." := 1;
      END;
    END;
  end;
}

