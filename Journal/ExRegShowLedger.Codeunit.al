codeunit 50009 "Ex. Reg.-Show Ledger"
{
  // version Exercise 3

  TableNo=50015;

  trigger OnRun();
  begin
    ExLedgEntry.SETRANGE("Entry No.","From Entry No.","To Entry No.");
    PAGE.RUN(PAGE::"Example Ledger Entries",ExLedgEntry);
  end;

  var
    ExLedgEntry : Record 50011;
}

