page 50025 "Scales"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Scale;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field("Codeunit ID"; "Codeunit ID")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

}