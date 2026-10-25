-- Public charger discovery: least-privilege anonymous access.
-- Exact address and host_id remain private; RLS limits public rows to active chargers.

REVOKE ALL PRIVILEGES ON TABLE public.chargers FROM anon;
REVOKE ALL PRIVILEGES ON TABLE public.profiles FROM anon;
REVOKE ALL PRIVILEGES ON TABLE public.bookings FROM anon;

GRANT SELECT (id, title, city, connector_type, power_kw, price_per_hour, description)
ON TABLE public.chargers TO anon;

CREATE POLICY "Public can read active charger listings"
ON public.chargers
FOR SELECT
TO anon
USING (status = 'active');
