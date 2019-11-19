page 50013 "Example Journal"
{
    // version Exercise 3

    AutoSplitKey = true;
    CaptionML = ENU = 'Example Journal',
            ESM = 'Diario recursos',
            FRC = 'Journal des ressources',
            ENC = 'Example Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Ex. Journal Line";

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                CaptionML = ENU = 'Batch Name',
                  ESM = 'Nombre sección',
                  FRC = 'Nom de lot',
                  ENC = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    CurrPage.SAVERECORD;
                    ExJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate();
                begin
                    ExJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Control1)
            {
                field("Posting Date"; "Posting Date")
                {
                }
                field("Document Date"; "Document Date")
                {
                    Visible = false;
                }
                field("Entry Type"; "Entry Type")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("External Document No."; "External Document No.")
                {
                    Visible = false;
                }
                field("Example Person No."; "Example Person No.")
                {

                    trigger OnValidate();
                    begin
                        ExJnlManagement.GetEx("Example Person No.", ExName);
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Example Product No."; "Example Product No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    Visible = false;
                }
                field(Quantity; Quantity)
                {
                }
                field("Reason Code"; "Reason Code")
                {
                    Visible = false;
                }
            }
            group(Control41)
            {
                fixed(Control1903222401)
                {
                    group("Resource Name")
                    {
                        CaptionML = ENU = 'Resource Name',
                      ESM = 'Nombre recurso',
                      FRC = 'Nom de ressource',
                      ENC = 'Resource Name';
                        field(ExName; ExName)
                        {
                            Editable = false;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                  ESM = '&Línea',
                  FRC = '&Ligne',
                  ENC = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    CaptionML = ENU = 'Dimensions',
                    ESM = 'Dimensiones',
                    FRC = 'Dimensions',
                    ENC = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction();
                    begin
                        ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
            }
            group("&Resource")
            {
                CaptionML = ENU = '&Resource',
                  ESM = 'Re&curso',
                  FRC = '&Ressource',
                  ENC = '&Resource';
                Image = Resource;
                action(Card)
                {
                    CaptionML = ENU = 'Card',
                    ESM = 'Ficha',
                    FRC = 'Fiche',
                    ENC = 'Card';
                    Image = EditLines;
                    RunObject = Page 76;
                    RunPageLink = "No." = FIELD("Example Person No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Ledger E&ntries")
                {
                    CaptionML = ENU = 'Ledger E&ntries',
                    ESM = '&Movimientos',
                    FRC = 'É&critures comptables',
                    ENC = 'Ledger E&ntries';
                    Image = ResourceLedger;
                    Promoted = false;
                    //The properties 'PromotedCategory' and 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory=Process;
                    RunObject = Page 50014;
                    RunPageLink = "Example Person No." = FIELD("Example Person No.");
                    RunPageView = SORTING("Example Person No.");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
        area(processing)
        {
            group("P&osting")
            {
                CaptionML = ENU = 'P&osting',
                  ESM = '&Registro',
                  FRC = 'Rep&ort',
                  ENC = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    CaptionML = ENU = 'Test Report',
                    ESM = 'Informe prueba',
                    FRC = 'Tester le report',
                    ENC = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction();
                    begin
                        //ReportPrint.PrintResJnlLine(Rec);
                    end;
                }
                action(Post)
                {
                    CaptionML = ENU = 'P&ost',
                    ESM = '&Registrar',
                    FRC = 'Rep&orter',
                    ENC = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction();
                    begin
                        //CODEUNIT.RUN(CODEUNIT::"Ex. Jnl.-Post",Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Post and &Print")
                {
                    CaptionML = ENU = 'Post and &Print',
                    ESM = 'Registrar e &imprimir',
                    FRC = 'Reporter et im&primer',
                    ENC = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction();
                    begin
                        //CODEUNIT.RUN(CODEUNIT::"Ex. Jnl.-Post+Print",Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        ExJnlManagement.GetEx("Example Person No.", ExName);
    end;

    trigger OnAfterGetRecord();
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage();
    var
        JnlSelected: Boolean;
    begin
        OpenedFromBatch := ("Journal Batch Name" <> '') AND ("Journal Template Name" = '');
        IF OpenedFromBatch THEN BEGIN
            CurrentJnlBatchName := "Journal Batch Name";
            ExJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
            EXIT;
        END;
        ExJnlManagement.TemplateSelection(PAGE::"Example Journal", FALSE, Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        ExJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        ExJnlManagement: Codeunit 50010;
        ReportPrint: Codeunit 228;
        CurrentJnlBatchName: Code[10];
        ExName: Text[50];
        ShortcutDimCode: ARRAY[8] OF Code[20];
        OpenedFromBatch: Boolean;

    LOCAL PROCEDURE CurrentJnlBatchNameOnAfterVali();
    begin
        CurrPage.SAVERECORD;
        ExJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;
}

