table 50014 "Ex. Journal Batch"
{
  // version Exercise 3

  CaptionML=ENU='Ex. Journal Batch';
  DataCaptionFields=Name,Description;
  LookupPageID=272;

  fields
  {
    field(1;"Journal Template Name";Code[10])
    {
      CaptionML=ENU='Journal Template Name';
      TableRelation="Ex. Journal Template";
    }
    field(2;Name;Code[10])
    {
      CaptionML=ENU='Name';
      NotBlank=true;
    }
    field(3;Description;Text[50])
    {
      CaptionML=ENU='Description';
    }
    field(4;"Reason Code";Code[10])
    {
      CaptionML=ENU='Reason Code';
      TableRelation="Reason Code";

      trigger OnValidate();
      begin
        IF "Reason Code" <> xRec."Reason Code" THEN BEGIN
          ExJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
          ExJnlLine.SETRANGE("Journal Batch Name",Name);
          ExJnlLine.MODIFYALL("Reason Code","Reason Code");
          MODIFY;
        END;
      end;
    }
    field(5;"No. Series";Code[10])
    {
      CaptionML=ENU='No. Series';
      TableRelation="No. Series";

      trigger OnValidate();
      begin
        IF "No. Series" <> '' THEN BEGIN
          ExJnlTemplate.GET("Journal Template Name");
          IF ExJnlTemplate.Recurring THEN
            ERROR(
              Text000,
              FIELDCAPTION("Posting No. Series"));
          IF "No. Series" = "Posting No. Series" THEN
            VALIDATE("Posting No. Series",'');
        END;
      end;
    }
    field(6;"Posting No. Series";Code[10])
    {
      CaptionML=ENU='Posting No. Series';
      TableRelation="No. Series";

      trigger OnValidate();
      begin
        IF ("Posting No. Series" = "No. Series") AND ("Posting No. Series" <> '') THEN
          FIELDERROR("Posting No. Series",STRSUBSTNO(Text001,"Posting No. Series"));
        ExJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
        ExJnlLine.SETRANGE("Journal Batch Name",Name);
        ExJnlLine.MODIFYALL("Posting No. Series","Posting No. Series");
        MODIFY;
      end;
    }
    field(22;Recurring;Boolean)
    {
      CalcFormula=Lookup("Ex. Journal Template".Recurring WHERE (Name=FIELD("Journal Template Name")));
      CaptionML=ENU='Recurring';
      Editable=false;
      FieldClass=FlowField;
    }
  }

  keys
  {
    key(Key1;"Journal Template Name",Name)
    {
      Clustered=true;
    }
  }

  fieldgroups
  {
  }

  trigger OnDelete();
  begin
    ExJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
    ExJnlLine.SETRANGE("Journal Batch Name",Name);
    ExJnlLine.DELETEALL(TRUE);
  end;

  trigger OnInsert();
  begin
    LOCKTABLE;
    ExJnlTemplate.GET("Journal Template Name");
  end;

  trigger OnRename();
  begin
    ExJnlLine.SETRANGE("Journal Template Name",xRec."Journal Template Name");
    ExJnlLine.SETRANGE("Journal Batch Name",xRec.Name);
    WHILE ExJnlLine.FINDFIRST DO
      ExJnlLine.RENAME("Journal Template Name",Name,ExJnlLine."Line No.");
  end;

  var
    Text000 : TextConst ENU='Only the %1 field can be filled in on recurring journals.';
    Text001 : TextConst ENU='must not be %1';
    ExJnlTemplate : Record 50012;
    ExJnlLine : Record 50013;

  PROCEDURE SetupNewBatch();
  begin
    ExJnlTemplate.GET("Journal Template Name");
    "No. Series" := ExJnlTemplate."No. Series";
    "Posting No. Series" := ExJnlTemplate."Posting No. Series";
    "Reason Code" := ExJnlTemplate."Reason Code";
  end;
}

