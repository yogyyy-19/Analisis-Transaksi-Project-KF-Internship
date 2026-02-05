-- Analisis Produk: Pareto & Profitabilitas 

WITH product_performance AS (
  SELECT
    product_name,
    product_id, -- Jika ada kolom kategori
    SUM(nett_sales) AS total_sales,
    SUM(nett_profit) AS total_profit,
    COUNT(transaction_id) AS total_sold_qty
  FROM
    rakamin-kf-analytics-486202.Kimia_Farma.kf_analisis_transaksi
  GROUP BY
    product_name, product_id
)
SELECT
  *,
  -- Ranking produk berdasarkan profit
  DENSE_RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
FROM
  product_performance
ORDER BY
  profit_rank ASC
LIMIT 10;
