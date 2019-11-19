page 50015 "Ex. Journal Template List"
{
  // version Exercise 3

  CaptionML=ENU='Ex. Journal Template List',
            ESM='Lista libros diario recurso',
            FRC='Liste modèle journal ress.',
            ENC='Ex. Journal Template List';
  Editable=false;
  PageType=List;
  RefreshOnActivate=true;
  SourceTable="Ex. Journal Template";

  layout
  {
    area(content)
    {
      repeater(Control1)
      {
        field(Name;Name)
        {
        }
        field(Description;Description)
        {
        }
        field(Recurring;Recurring)
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
        field("Page ID";"Page ID")
        {
//          LookupPageID=Objects;
          Visible=false;
        }
        field("Test Report ID";"Test Report ID")
        {
//          LookupPageID=Objects;
          Visible=false;
        }
        field("Posting Report ID";"Posting Report ID")
        {
//          LookupPageID=Objects;
          Visible=false;
        }
        field("Force Posting Report";"Force Posting Report")
        {
          Visible=false;
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
  }
}

