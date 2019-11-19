table 50015 "Example Register"
{
    // version Exercise 3

    CaptionML = ENU = 'Example Register';
    DrillDownPageID = 50017;
    LookupPageID = 50017;

    fields
    {
        field(1; "No."; Integer)
        {
            CaptionML = ENU = 'No.';
        }
        field(2; "From Entry No."; Integer)
        {
            CaptionML = ENU = 'From Entry No.';
            TableRelation = "Example Entry";
        }
        field(3; "To Entry No."; Integer)
        {
            CaptionML = ENU = 'To Entry No.';
            TableRelation = "Example Entry";
        }
        field(4; "Creation Date"; Date)
        {
            CaptionML = ENU = 'Creation Date';
        }
        field(5; "Source Code"; Code[10])
        {
            CaptionML = ENU = 'Source Code';
            TableRelation = "Source Code";
        }
        field(6; "User ID"; Code[50])
        {
            CaptionML = ENU = 'User ID';

            trigger OnLookup();
            var
                UserMgt: Codeunit 418;
            begin
                //                UserMgt.LookupUserID("User ID"); System App ??
            end;
        }
        field(7; "Journal Batch Name"; Code[10])
        {
            CaptionML = ENU = 'Journal Batch Name';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Creation Date")
        {
        }
        key(Key3; "Source Code", "Journal Batch Name", "Creation Date")
        {
        }
    }

    fieldgroups
    {
    }
}

