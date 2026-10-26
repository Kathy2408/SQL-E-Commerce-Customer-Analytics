  WITH customer_tlv AS(
	  SELECT
	        customerkey,
			fullname,
			SUM(total_net_revenue) AS total_ltv
	FROM cohort_analysis
	GROUP BY
	      customerkey,
		  fullname
	ORDER BY customerkey ASC	  
	), customer_segment AS (
	SELECT 
	    PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY total_ltv ) AS ltv_25th_percentile, 
		PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY total_ltv ) AS ltv_75th_percentile 
	FROM customer_tlv
	), segment_values AS(

	SELECT 
	      c.*,
		  CASE
		     WHEN c.total_ltv <= cs.ltv_25th_percentile THEN '3-Low-value'
			 WHEN c.total_ltv >= cs.ltv_75th_percentile THEN '1-High-value'
			 ELSE '2-Mid-value'
		  END AS customer_segment
	FROM 
	     customer_tlv c,
	     customer_segment cs
)

SELECT 
      customer_segment,
	  SUM(total_ltv) AS total_ltv,
	  COUNT(customerkey) AS customer_count,
	  SUM(total_ltv) / COUNT(customerkey) AS avg_ltv
FROM segment_values
GROUP BY 
      customer_segment