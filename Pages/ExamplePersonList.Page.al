page 50011 "Example Person List"
{
    Caption = 'Example Master Data List';
    CardPageID = "Example Person Card";
    Editable = false;
    PageType = List;
    SourceTable = "Example Person";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Address)
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }

}

