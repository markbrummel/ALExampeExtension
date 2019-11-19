page 50014 "Example Ledger Entries"
{
  // version Exercise 3

  CaptionML=ENU='Example Ledger Entries',
            ESM='Movs. recursos',
            FRC='Écritures ressource',
            ENC='Example Ledger Entries';
  DataCaptionFields="Example Person No.";
  Editable=false;
  PageType=List;
  SourceTable="Example Entry";

  layout
  {
    area(content)
    {
      repeater(Control1)
      {
        field("Posting Date";"Posting Date")
        {
        }
        field("Entry Type";"Entry Type")
        {
        }
        field("Document No.";"Document No.")
        {
        }
        field("Example Person No.";"Example Person No.")
        {
        }
        field(Description;Description)
        {
        }
        field("Global Dimension 1 Code";"Global Dimension 1 Code")
        {
          Visible=false;
        }
        field("Global Dimension 2 Code";"Global Dimension 2 Code")
        {
          Visible=false;
        }
        field(Quantity;Quantity)
        {
        }
        field("User ID";"User ID")
        {
          Visible=false;
        }
        field("Source Code";"Source Code")
        {
          Visible=false;
        }
        field("Reason Code";"Reason Code")
        {
          Visible=false;
        }
        field(Autoincement;Autoincement)
        {
        }
        field("Entry No.";"Entry No.")
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
      group("Ent&ry")
      {
        CaptionML=ENU='Ent&ry',
                  ESM='&Movimiento',
                  FRC='É&criture',
                  ENC='Ent&ry';
        Image=Entry;
        action(Dimensions)
        {
          CaptionML=ENU='Dimensions',
                    ESM='Dimensiones',
                    FRC='Dimensions',
                    ENC='Dimensions';
          Image=Dimensions;
          ShortCutKey='Shift+Ctrl+D';

          trigger OnAction();
          begin
            ShowDimensions;
          end;
        }
      }
    }
    area(processing)
    {
      action("&Navigate")
      {
        CaptionML=ENU='&Navigate',
                  ESM='&Navegar',
                  FRC='&Naviguer',
                  ENC='&Navigate';
        Image=Navigate;
        Promoted=true;
        PromotedCategory=Process;

        trigger OnAction();
        begin
          Navigate.SetDoc("Posting Date","Document No.");
          Navigate.RUN;
        end;
      }
    }
  }

  var
    Navigate : Page 344;
}

