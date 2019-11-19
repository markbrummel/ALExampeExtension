page 50012 "Example Journal Templates"
{
  // version Exercise 3

  CaptionML=ENU='Example Journal Templates',
            ESM='Libros diario recurso',
            FRC='Modèles de journaux de ressources',
            ENC='Example Journal Templates';
  PageType=List;
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
        }
        field("No. Series";"No. Series")
        {
        }
        field("Posting No. Series";"Posting No. Series")
        {
        }
        field("Source Code";"Source Code")
        {
        }
        field("Reason Code";"Reason Code")
        {
        }
        field("Page ID";"Page ID")
        {
//          LookupPageID=Objects;
          Visible=false;
        }
        field("Page Caption";"Page Caption")
        {
          DrillDown=false;
          Visible=false;
        }
        field("Test Report ID";"Test Report ID")
        {
//          LookupPageID=Objects;
          Visible=false;
        }
        field("Test Report Caption";"Test Report Caption")
        {
          DrillDown=false;
          Visible=false;
        }
        field("Posting Report ID";"Posting Report ID")
        {
//          LookupPageID=Objects;
          Visible=false;
        }
        field("Posting Report Caption";"Posting Report Caption")
        {
          DrillDown=false;
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
    area(navigation)
    {
      group("Te&mplate")
      {
        CaptionML=ENU='Te&mplate',
                  ESM='&Libro',
                  FRC='&Modèle',
                  ENC='Te&mplate';
        Image=Template;
        action(Batches)
        {
          CaptionML=ENU='Batches',
                    ESM='Secciones',
                    FRC='Lots',
                    ENC='Batches';
          Image=Description;
          RunObject=Page 50016;
          RunPageLink="Journal Template Name"=FIELD(Name);
        }
      }
    }
  }
}

