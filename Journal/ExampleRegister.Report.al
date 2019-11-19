report 50002 "Example Register"
{
  // version Exercise 3

  CaptionML=ENU='Example Register',
            ESM='Registro movs. recurso',
            FRC='Registre des ressources',
            ENC='Resource Register';

  dataset
  {
  }

  requestpage
  {
    SaveValues=true;

    layout
    {
      area(content)
      {
        group(Options)
        {
          CaptionML=ENU='Options',
                    ESM='Opciones',
                    FRC='Options',
                    ENC='Options';
          field(PrintResourceDescriptions;PrintResourceDescriptions)
          {
            CaptionML=ENU='Print Resource Desc.',
                      ESM='Impr. descrip. recursos',
                      FRC='Imprimer desc. ressource',
                      ENC='Print Resource Desc.';
          }
        }
      }
    }

    actions
    {
    }
  }

  labels
  {
  }

  trigger OnPreReport();
  begin
    CompanyInformation.GET;
  end;

  var
    Resource : Record 156;
    CompanyInformation : Record 79;
    SourceCode : Record 230;
    PrintResourceDescriptions : Boolean;
    ResRegFilter : Text[250];
    ResEntryFilter : Text[250];
    ResDescription : Text[50];
    SourceCodeText : Text[50];
    Text000 : TextConst ENU='Register',ESM='Movs.',FRC='Registre',ENC='Register';
    Resource_RegisterCaptionLbl : TextConst ENU='Resource Register',ESM='Registro movs. recurso',FRC='Registre des ressources',ENC='Resource Register';
    CurrReport_PAGENOCaptionLbl : TextConst ENU='Page',ESM='Pág.',FRC='Page',ENC='Page';
    Res__Ledger_Entry_ChargeableCaptionLbl : TextConst ENU='Chargeable',ESM='Facturable',FRC='Facturable',ENC='Chargeable';
    Number_of_Entries_in_Register_No_CaptionLbl : TextConst ENU='Number of Entries in Register No.',ESM='Número de movimientos en N°. reg.',FRC='Nombre d''écritures dans le registre n°',ENC='Number of Entries in Register No.';
}

