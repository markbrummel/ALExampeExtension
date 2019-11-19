table 50025 "Scale"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[50]) { }
        field(3; "Codeunit ID"; Integer) { }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }


}