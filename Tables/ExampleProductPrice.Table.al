table 50030 "Example Product Price"
{
    fields
    {
        field(1; "Product No."; Code[20])
        {
            TableRelation = "Example Product";
        }
        field(2; "Person No."; Code[20])
        {
            TableRelation = "Example Person";
        }
        field(3; "Sales Price"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Product No.", "Person No.")
        {
            Clustered = true;
        }
    }
}

