codeunit 50100 PriceListReviewSubscribers
{
    SingleInstance = true;

    var
        ItemNo: Code[20];

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Price UX Management", 'OnShowPriceListLinesOnAfterPriceAssetListAdd', '', false, false)]
    local procedure OnShowPriceListLinesOnAfterPriceAssetListAdd(PriceAsset: Record "Price Asset")
    begin
        ItemNo := '';
        if PriceAsset."Asset Type" = PriceAsset."Asset Type"::Item then
            ItemNo := PriceAsset."Asset No.";
    end;

    procedure SetItemNo(NewItemNo: Code[20])
    begin
        ItemNo := NewItemNo;
    end;

    procedure GetItemNo(): Code[20]
    begin
        exit(ItemNo);
    end;
}
