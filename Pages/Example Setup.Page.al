page 50000 "Example Setup"
{
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
                field("Example Enabled"; "Example Enabled") { }
                field("Example Person Nos."; "Example Person Nos.") { }
                field("Example Product Nos."; "Example Product Nos.") { }
            }
        }
    }


    trigger OnOpenPage();
    begin
        InitSetupRecord;
    end;

}