page 50021 "Example Product List"
{
    Caption = 'Example Product List';
    CardPageID = "Example Product Card";
    Editable = false;
    PageType = List;
    SourceTable = "Example Product";
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
                field(Description; Description)
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

