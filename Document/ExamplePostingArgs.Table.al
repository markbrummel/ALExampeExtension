table 50002 "Example Posting Arguments"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Replace Posting Date"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Replace Document Date"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Replace Posting Date")
        {
            Clustered = true;
        }
    }

    PROCEDURE ThrowErrorIfNoPostingDateAndReplaceIsSelected();
    BEGIN
        IF "Replace Posting Date" AND ("Posting Date" = 0D) THEN
            ERROR('Please enter the posting date.');
    END;

}

