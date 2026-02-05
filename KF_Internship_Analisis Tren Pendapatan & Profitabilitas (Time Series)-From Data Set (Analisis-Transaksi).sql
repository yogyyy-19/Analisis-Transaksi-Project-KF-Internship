-- Analisis Tren Pendapatan & Profitabilitas (Time Series)

SELECT
  -- Mengambil Bulan dan Tahun dari tanggal transaksi
  FORMAT_DATE('%Y-%m', date) AS month_year,
  
  -- Menghitung Total Penjualan dan Profit
  SUM(nett_sales) AS total_revenue,
  SUM(nett_profit) AS total_profit,
  
  -- Menghitung Profit Margin (%)
  ROUND((SUM(nett_profit) / SUM(nett_sales)) * 100, 2) AS profit_margin_percentage,
  
  -- Menghitung Jumlah Transaksi
  COUNT(transaction_id) AS total_transactions
FROM
  rakamin-kf-analytics-486202.Kimia_Farma.kf_analisis_transaksi
GROUP BY
  month_year
ORDER BY
  month_year ASC;
