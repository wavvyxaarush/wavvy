-- Prevent authenticated users from reading private charger columns directly.
-- Public/driver discovery and host dashboards can query only non-sensitive listing fields.
-- Exact address remains stored for now but is not selectable through the Data API.

REVOKE SELECT ON TABLE public.chargers FROM authenticated;

GRANT SELECT (id, title, city, connector_type, power_kw, price_per_hour, description, status)
ON TABLE public.chargers TO authenticated;
