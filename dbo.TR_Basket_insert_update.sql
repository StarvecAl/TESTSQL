-- dbo.TR_Basket_insert_update
CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- ��������� ���� DiscountValue ��� ������� ID_SKU
    UPDATE B
    SET DiscountValue = CASE
                           WHEN C.CountRecords > 1 THEN Value * 0.05 -- 5% ������
                           ELSE 0 -- ��� ������
                       END
    FROM dbo.Basket B
    JOIN (
        SELECT ID_SKU, COUNT(*) AS CountRecords
        FROM dbo.Basket
        GROUP BY ID_SKU
    ) C ON B.ID_SKU = C.ID_SKU;
END;
