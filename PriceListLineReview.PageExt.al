pageextension 50100 "Price List Line Review" extends "Price List Line Review"
{
    layout
    {
    }
    actions
    {
        addfirst(Navigation)
        {
            action(NewPriceListLine)
            {
                ApplicationArea = All;
                Caption = 'New';
                Image = Price;
                Visible = NewPurchasePriceListLineVisible;

                trigger OnAction()
                begin
                    Rec.CreateNewPriceListLine(PriceType, ItemNo);
                end;
            }
            action(Delete)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;
                Enabled = LineExists;

                trigger OnAction()
                var
                    PriceListLine: Record "Price List Line";
                begin
                    CurrPage.SetSelectionFilter(PriceListLine);
                    Rec.DeleteSelectedPrices(PriceListLine);
                end;
            }
        }
        addfirst(Category_Process)
        {
            actionref(NewPriceListLine_Promoted; NewPriceListLine)
            {
            }
            actionref(Delete_Promoted; Delete)
            {
            }
        }
    }

    trigger OnOpenPage()
    begin
        ItemNo := PriceListReviewSubscribers.GetItemNo();
        NewPurchasePriceListLineVisible := ItemNo <> '';
        PriceListReviewSubscribers.SetItemNo('');
    end;

    var
        PriceListReviewSubscribers: Codeunit PriceListReviewSubscribers;
        ItemNo: Code[20];
        [InDataSet]
        NewPurchasePriceListLineVisible: Boolean;
}
