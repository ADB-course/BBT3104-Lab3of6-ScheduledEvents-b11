
-- CREATE EVN_average_customer_waiting_time_every_1_hour
SET GLOBAL event_scheduler = ON;
CREATE EVENT EVN_average_customer_waiting_time_every_1_hour
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
INSERT INTO customer_service_kpi (customer_service_KPI_average_waiting_time_minutes, customer_service_KPI_timestamp)
    SELECT 
        AVG(TIMESTAMPDIFF(MINUTE, ticket_created_time, ticket_resolved_time)), 
        NOW()
    FROM 
        customer_sevice_ticket
    WHERE 
         ticket_created_time >= NOW() - INTERVAL 1 HOUR
        AND ticket_resolved_time IS NOT NULL;
END
