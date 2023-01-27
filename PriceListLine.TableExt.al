tableextension 50100 "Price List Line" extends "Price List Line"
{
    var
        DeleteMsg: Label 'Do you want to delete selected prices?';

    procedure CreateNewPriceListLine(PriceType: Enum "Price Type"; ItemNo: Code[20])
    var
        PriceListHeader: Record "Price List Header";
        PriceListLine: Record "Price List Line";
        Item: Record Item;
        PriceListManagement: Codeunit "Price List Management";
        CreateNewPrice: Page "Create New Price";
        PriceListCode: Code[20];
    begin
        Item.Get(ItemNo);
        CreateNewPrice.LookupMode(true);
        CreateNewPrice.SetPriceType(PriceType);
        if CreateNewPrice.RunModal() = Action::LookupOK then begin
            Clear(PriceListLine);
            PriceListHeader.Get(CreateNewPrice.GetPriceListCode());
            PriceListLine."Price List Code" := PriceListHeader.Code;
            PriceListLine.CopyFrom(PriceListHeader);
            if PriceType = PriceType::Sale then
                PriceListLine."Source Type" := PriceListLine."Source Type"::Customer
            else
                PriceListLine."Source Type" := PriceListLine."Source Type"::Vendor;
            PriceListLine.Validate("Source No.", CreateNewPrice.GetSourceNo());
            PriceListLine.Validate("Asset Type", PriceListLine."Asset Type"::Item);
            PriceListLine.Validate("Asset No.", ItemNo);
            PriceListLine."Unit of Measure Code" := Item."Base Unit of Measure";
            PriceListLine."Currency Code" := CreateNewPrice.GetCurrencyCode();
            if PriceType = PriceType::Sale then
                PriceListLine."Unit Price" := CreateNewPrice.GetUnitPrice()
            else
                PriceListLine."Direct Unit Cost" := CreateNewPrice.GetDirectUnitCost();
            PriceListLine.Insert(true);
            Rec.Get(PriceListLine."Price List Code", PriceListLine."Line No.");
            Rec.Mark(true);
            Commit();
            PriceListManagement.ActivateDraftLines(PriceListLine);
        end;
    end;

    procedure DeleteSelectedPrices(var PriceListLine: Record "Price List Line")
    begin
        if Confirm(DeleteMsg, true) then
            PriceListLine.DeleteAll(true);
    end;
}
