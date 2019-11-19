table 50018 "Example History Two Header"
{
    // version Exercise 4

    DataPerCompany = false;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(5; "Example Person No."; Code[20])
        {
        }
        field(6; Name; Text[50])
        {
        }
        field(11; "Document Date"; Date)
        {
        }
        field(12; "Posting Date"; Date)
        {
        }
        field(97; "No. Series"; Code[10])
        {
            CaptionML = ENU = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

