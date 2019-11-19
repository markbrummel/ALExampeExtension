page 50016 "Example Jnl. Batches"
{
  // version Exercise 3

  CaptionML=ENU='Example Jnl. Batches',
            ESM='Secciones diario recursos',
            FRC='Lots journal ressource',
            ENC='Example Jnl. Batches';
  DataCaptionExpression=DataCaption;
  PageType=List;
  SourceTable="Ex. Journal Batch";

  layout
  {
    area(content)
    {
      repeater(Control1)
      {
        field(Name;Name)
        {
        }
        field(Description;Description)
        {
        }
        field("No. Series";"No. Series")
        {
        }
        field("Posting No. Series";"Posting No. Series")
        {
        }
        field("Reason Code";"Reason Code")
        {
        }
      }
    }
    area(factboxes)
    {
      systempart(Control1900383207;Links)
      {
        Visible=false;
      }
      systempart(Control1905767507;Notes)
      {
        Visible=false;
      }
    }
  }

  actions
  {
    area(processing)
    {
      action("Edit Journal")
      {
        CaptionML=ENU='Edit Journal',
                  ESM='Editar diario',
                  FRC='Modifier le journal',
                  ENC='Edit Journal';
        Image=OpenJournal;
        Promoted=true;
        PromotedCategory=Process;
        PromotedIsBig=true;
        ShortCutKey='Return';

        trigger OnAction();
        begin
          ExJnlMgt.TemplateSelectionFromBatch(Rec);
        end;
      }
      group("P&osting")
      {
        CaptionML=ENU='P&osting',
                  ESM='&Registro',
                  FRC='Rep&ort',
                  ENC='P&osting';
        Image=Post;
        action("Test Report")
        {
          CaptionML=ENU='Test Report',
                    ESM='Informe prueba',
                    FRC='Tester le report',
                    ENC='Test Report';
          Ellipsis=true;
          Image=TestReport;

          trigger OnAction();
          begin
            //ReportPrint.PrintResJnlBatch(Rec);
          end;
        }
        action("P&ost")
        {
          CaptionML=ENU='P&ost',
                    ESM='&Registrar',
                    FRC='Rep&orter',
                    ENC='P&ost';
          Image=PostOrder;
          Promoted=true;
          PromotedCategory=Process;
          PromotedIsBig=true;
          RunObject=Codeunit 50007;
          ShortCutKey='F9';
        }
        action("Post and &Print")
        {
          CaptionML=ENU='Post and &Print',
                    ESM='Registrar e &imprimir',
                    FRC='Reporter et im&primer',
                    ENC='Post and &Print';
          Image=PostPrint;
          Promoted=true;
          PromotedCategory=Process;
          PromotedIsBig=true;
          RunObject=Codeunit 50008;
          ShortCutKey='Shift+F9';
        }
      }
    }
  }

  trigger OnInit();
  begin
    SETRANGE("Journal Template Name");
  end;

  trigger OnNewRecord(BelowxRec : Boolean);
  begin
    SetupNewBatch;
  end;

  trigger OnOpenPage();
  begin
    ExJnlMgt.OpenJnlBatch(Rec);
  end;

  var
    ReportPrint : Codeunit 228;
    ExJnlMgt : Codeunit 50010;

  LOCAL PROCEDURE DataCaption() : Text[250];
  var
    ResJnlTemplate : Record 50012;
  begin
    IF NOT CurrPage.LOOKUPMODE THEN
      IF GETFILTER("Journal Template Name") <> '' THEN
        IF GETRANGEMIN("Journal Template Name") = GETRANGEMAX("Journal Template Name") THEN
          IF ResJnlTemplate.GET(GETRANGEMIN("Journal Template Name")) THEN
            EXIT(ResJnlTemplate.Name + ' ' + ResJnlTemplate.Description);
  end;
}

