page 50020 "Example Product Card"
{
    PageType = Card;
    SourceTable = "Example Product";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Search Description"; "Search Description")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                }
            }
            group(Price)
            {
                field("Sales Price"; "Sales Price")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Links)
            {
                ApplicationArea = All;
                Visible = true;
            }
            systempart(Control7; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }

    actions
    {
    }
}

