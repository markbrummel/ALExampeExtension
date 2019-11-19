page 50010 "Example Person Card"
{
    Caption = 'Example Person Card';
    PageType = Card;
    SourceTable = "Example Person";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {

                    trigger OnAssistEdit();
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Name; Name)
                {
                }
                field(Address; Address)
                {
                }
                field(City; City)
                {
                }
                field(Contact; Contact)
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("Post Code"; "Post Code")
                {
                }
                field(County; County)
                {
                }
                field("Search Name"; "Search Name")
                {
                }
            }
            group(Communication)
            {
                CaptionML = ENU = 'Communication';
                field("Phone No."; "Phone No.")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control15; Links)
            {
                Visible = true;
            }
            systempart(Control14; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        SetNoFieldVisible;
    end;

    var
        NoFieldVisible: Boolean;

    LOCAL PROCEDURE SetNoFieldVisible();
    var
        ExampleDocumentNoVisibility: Codeunit ExampleDocumentNoVisibility;
    begin
        NoFieldVisible := ExampleDocumentNoVisibility.ExamplePersonNoIsVisible;
    end;
}

