-- Performa Cabang & Geografis (Branch & Location Analysis)

SELECT
  branch_name,
  kota,
  provinsi,
  
  -- Agregasi performa finansial
  SUM(nett_sales) AS total_revenue,
  SUM(nett_profit) AS total_profit,
  
  -- Rata-rata Rating (Transaksional vs Rating Cabang asli)
  ROUND(AVG(rating_transaksi), 2) AS avg_transaction_rating,
  ANY_VALUE(rating_cabang) AS branch_rating
  
FROM
  rakamin-kf-analytics-486202.Kimia_Farma.kf_analisis_transaksi
GROUP BY
  branch_name, kota, provinsi
ORDER BY
  total_profit DESC
LIMIT 10;
