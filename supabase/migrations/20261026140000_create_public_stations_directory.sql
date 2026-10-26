create table if not exists public.public_stations (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  operator text,
  address text not null,
  city text not null default 'Pune',
  connector_type text,
  power_kw numeric,
  access_notes text,
  source_name text not null,
  source_url text not null,
  verification_status text not null default 'listed_unverified'
    check (verification_status in ('listed_unverified','operator_confirmed','inactive')),
  last_checked_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  constraint public_stations_power_positive check (power_kw is null or power_kw > 0)
);

alter table public.public_stations enable row level security;
revoke all privileges on table public.public_stations from anon, authenticated;
grant select (id, name, operator, address, city, connector_type, power_kw, access_notes, source_name, source_url, verification_status, last_checked_at)
on table public.public_stations to anon, authenticated;

drop policy if exists "Public can read listed public stations" on public.public_stations;
create policy "Public can read listed public stations"
on public.public_stations for select to anon, authenticated
using (verification_status in ('listed_unverified','operator_confirmed'));

insert into public.public_stations
(name, operator, address, city, connector_type, power_kw, access_notes, source_name, source_url, verification_status)
values
('BPCL Charging Station — Sangamvadi RTO', 'BPCL', 'GVH6+JXC, RTO, Sangamvadi, Pune, Maharashtra 411001', 'Pune', 'Not verified', null, 'Public directory listing. Confirm vehicle compatibility, access, price and live availability with BPCL before travelling.', 'Business listing search', 'https://www.google.com/maps/search/?api=1&query=BPCL+Charging+Station+RTO+Sangamvadi+Pune', 'listed_unverified'),
('GLIDA Charging Station — Hyatt Regency', 'GLIDA', 'Weikfield IT Citi Info Park, Pune–Nagar Road, Sakore Nagar, Viman Nagar, Pune, Maharashtra 411014', 'Pune', 'Not verified', null, 'Reported in a public business listing as located in the hotel basement. Confirm entry/parking rules and connector availability with GLIDA.', 'Business listing search', 'https://www.google.com/maps/search/?api=1&query=GLIDA+Charging+Station+Hyatt+Regency+Viman+Nagar+Pune', 'listed_unverified'),
('MetroCharge EV Charging Station', 'Not verified', 'Sakore Nagar, Viman Nagar, Pune, Maharashtra 411014', 'Pune', 'Not verified', null, 'Station name and area from a public business listing; exact connector and access details require confirmation.', 'Business listing search', 'https://www.google.com/maps/search/?api=1&query=MetroCharge+EV+Charging+Station+Sakore+Nagar+Pune', 'listed_unverified'),
('Zeal Energy Services / ChargeGrid', 'Zeal Energy Services (listing association to verify)', 'Destination Center, Nanded City, Sinhgad Road, Pune, Maharashtra 411068', 'Pune', 'Not verified', null, 'Public business listing describes an EV charging location here. Confirm current operator, connectors and access before travelling.', 'Business listing search', 'https://www.google.com/maps/search/?api=1&query=Zeal+Energy+Services+ChargeGrid+Destination+Center+Nanded+City+Pune', 'listed_unverified'),
('OSR EV Charging Station', 'OSR (operator details to verify)', 'Hinjawadi–Pirangut Road, near Bapuji Bua Mandir, Godambewadi, Pune district, Maharashtra 412115', 'Pune', 'Not verified', null, 'Public listing describes a charging stop on this corridor; exact connector, access and availability are not confirmed.', 'Business listing search', 'https://www.google.com/maps/search/?api=1&query=OSR+EV+Charging+Station+Hinjawadi+Pirangut+Road', 'listed_unverified'),
('ChargeZone x TATA.ev MegaCharger — JW Marriott', 'ChargeZone', 'JW Marriott, Senapati Bapat Road, Model Colony, Shivajinagar, Pune, Maharashtra 411016', 'Pune', 'Not verified', null, 'Public business listing identifies this location. Confirm current charger status, connector, price and site access with ChargeZone.', 'Business listing search', 'https://www.google.com/maps/search/?api=1&query=ChargeZone+TATA.ev+MegaCharger+JW+Marriott+Senapati+Bapat+Road+Pune', 'listed_unverified'),
('ChargeZone Charging Station — Sangamvadi', 'ChargeZone', 'Raja Bahadur Motilal Road, Sangamvadi, Pune, Maharashtra 411001', 'Pune', 'CCS2 (third-party listing; verify)', 60, 'Connector and power are reported by third-party listings, not operator-confirmed here. Verify before travel.', 'Business listing search; third-party specs require confirmation', 'https://www.google.com/maps/search/?api=1&query=ChargeZone+Raja+Bahadur+Motilal+Road+Sangamvadi+Pune', 'listed_unverified'),
('Electric Vehicle Charging Station — Kharadi', 'Operator not verified', '1344/3, Grant Road, near Phoenix School, Kharadi, Pune, Maharashtra 411014', 'Pune', 'Not verified', null, 'Public business listing identifies a charging station in Kharadi. Verify name, operator, connector and access before travelling.', 'Business listing search', 'https://www.google.com/maps/search/?api=1&query=Electric+Vehicle+Charging+Station+1344+Grant+Road+Kharadi+Pune', 'listed_unverified'),
('SpotEV Charging Station', 'SpotEV', 'Lane No. 21, behind Padel Hub, near Dorabjee Mall, Viman Nagar, Pune, Maharashtra 411014', 'Pune', 'Not verified', null, 'Public business listing identifies this location; confirm compatible connectors and app/access requirements with SpotEV.', 'Business listing search', 'https://www.google.com/maps/search/?api=1&query=SpotEV+Charging+Station+Lane+21+Viman+Nagar+Pune', 'listed_unverified'),
('Statiq Charging Station — Westend Center One', 'Statiq', 'Upper basement, Westend Center One, Wireless Colony, Aundh, Pune, Maharashtra 411067', 'Pune', 'CCS2 (third-party listing; verify)', null, 'Public business listing places this station at Westend Center One. Confirm connector, charging speed, parking access and availability with Statiq.', 'Business listing search', 'https://www.google.com/maps/search/?api=1&query=Statiq+Charging+Station+Westend+Center+One+Aundh+Pune', 'listed_unverified'),
('BPCL HelloBPCL — Dapodi Old NH4', 'BPCL', 'Dapodi Old NH4, Pune, Maharashtra', 'Pune', 'Not verified', null, 'Listed in a third-party station directory; full street address, connector, access and operational status require confirmation.', 'evgoo public station directory', 'https://evgoo.io/charging-stations/pune', 'listed_unverified'),
('BPCL HelloBPCL — Hinjawadi Phase III', 'BPCL', 'Hinjawadi Phase III, Pune, Maharashtra', 'Pune', 'Not verified', null, 'Listed in a third-party station directory; exact pin, connector, access and operational status require confirmation.', 'evgoo public station directory', 'https://evgoo.io/charging-stations/pune', 'listed_unverified')
on conflict do nothing;