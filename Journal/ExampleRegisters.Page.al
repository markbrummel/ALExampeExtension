page 50017 "Example Registers"
{
  // version Exercise 3

  CaptionML=ENU='Example Registers',
            ESM='Registro movs. recursos',
            FRC='Registres des ressources',
            ENC='Example Registers';
  Editable=false;
  PageType=List;
  SourceTable="Example Register";

  layout
  {
    area(content)
    {
      repeater(Control1)
      {
        field("No.";"No.")
        {
        }
        field("Creation Date";"Creation Date")
        {
        }
        field("User ID";"User ID")
        {
        }
        field("Source Code";"Source Code")
        {
        }
        field("Journal Batch Name";"Journal Batch Name")
        {
        }
        field("From Entry No.";"From Entry No.")
        {
        }
        field("To Entry No.";"To Entry No.")
        {
        }
      }
    }
    area(factboxes)
    {
      systempart(Control1900383207;Links)
      {
        Visible=false;
      }
      systempart(Control1905767507;Notes)
      {
        Visible=false;
      }
    }
  }

  actions
  {
    area(navigation)
    {
      group("&Register")
      {
        CaptionML=ENU='&Register',
                  ESM='&Movs.',
                  FRC='&Registre',
                  ENC='&Register';
        Image=Register;
        action("Example Ledger")
        {
          CaptionML=ENU='Example Ledger';
          Image=ResourceLedger;
          Promoted=true;
          PromotedCategory=Process;
          PromotedIsBig=true;
          RunObject=Codeunit 50009;
        }
      }
    }
  }
}

