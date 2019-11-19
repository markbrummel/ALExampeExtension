page 50000 "Example Setup"
{
    Caption = 'Example Setup';
    PageType = Card;
    SourceTable = "Example Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General';
                field("Example Enabled"; "Example Enabled") { ApplicationArea = All; }
                field("Example Person Nos."; "Example Person Nos.") { ApplicationArea = All; }
                field("Example Product Nos."; "Example Product Nos.") { ApplicationArea = All; }
            }
        }
    }


    trigger OnOpenPage();
    begin
        InitSetupRecord;
    end;

}