tableextension 50142 "Example Source Code Setup" extends "Source Code Setup"
{
    fields
    {
        field(50000; "Example Journal"; Code[10]) { TableRelation = "Source Code"; }
    }
}