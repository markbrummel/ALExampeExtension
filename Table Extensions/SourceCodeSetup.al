tableextension 50142 SourceCodeSetup extends "Source Code Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Example Journal"; Code[10])
        {
            TableRelation = "Source Code";
        }
    }
}