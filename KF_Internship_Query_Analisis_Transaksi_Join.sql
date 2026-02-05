CREATE OR REPLACE TABLE Kimia_Farma.kf_analisis_transaksi AS
SELECT
    -- kf_FInal_Transaction
    ft.transaction_id,
    ft.date,
    ft.branch_id,
    ft.customer_name,
    -- kf_kantor_cabang
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    -- kf_product
    ft.product_id,
    p.product_name,
    p.price AS actual_price,
    ft.discount_percentage,
    -- kf_inventory
    i.inventory_id,
    i.opname_stock,

    -- PERSENTASE GROSS LABA
    CASE
        WHEN p.price <= 50000 THEN 0.10
        WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
        WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
        WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,

    -- NETT SALES
    p.price * (1 - ft.discount_percentage / 100) AS nett_sales,

    -- NETT PROFIT
    (
        p.price * (1 - ft.discount_percentage / 100)
        *
        CASE
            WHEN p.price <= 50000 THEN 0.10
            WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
            WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
            WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
            ELSE 0.30
        END
    ) AS nett_profit,

    -- RATING TRANSAKSI
    ft.rating AS rating_transaksi

FROM rakamin-kf-analytics-486202.Kimia_Farma.kf_FInal_Transaction ft
-- JOIN PRODUK
LEFT JOIN rakamin-kf-analytics-486202.Kimia_Farma.kf_product p
    ON ft.product_id = p.product_id
-- JOIN CABANG
LEFT JOIN rakamin-kf-analytics-486202.Kimia_Farma.kf_kantor_cabang kc
    ON ft.branch_id = kc.branch_id
-- JOIN INVENTORY
LEFT JOIN rakamin-kf-analytics-486202.Kimia_Farma.kf_inventory i
    ON ft.product_id = i.product_id
   AND ft.branch_id = i.branch_id;
