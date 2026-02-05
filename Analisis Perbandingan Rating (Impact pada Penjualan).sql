-- Analisis Perbandingan Rating (Impact pada Penjualan)

SELECT
  rating_cabang,
  COUNT(DISTINCT branch_name) AS total_branches,
  AVG(nett_sales) AS avg_revenue_per_transaction,
  SUM(nett_sales) AS total_revenue_contribution
FROM
  rakamin-kf-analytics-486202.Kimia_Farma.kf_analisis_transaksi
GROUP BY
  rating_cabang
ORDER BY
  rating_cabang DESC;
