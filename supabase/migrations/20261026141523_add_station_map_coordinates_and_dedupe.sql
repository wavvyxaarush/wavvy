alter table public.public_stations
  add column if not exists latitude double precision,
  add column if not exists longitude double precision,
  add column if not exists coordinate_precision text not null default 'approximate_area';

alter table public.public_stations
  drop constraint if exists public_stations_latitude_range,
  drop constraint if exists public_stations_longitude_range,
  drop constraint if exists public_stations_coordinate_precision_check;

alter table public.public_stations
  add constraint public_stations_latitude_range check (latitude is null or latitude between -90 and 90),
  add constraint public_stations_longitude_range check (longitude is null or longitude between -180 and 180),
  add constraint public_stations_coordinate_precision_check check (coordinate_precision in ('exact_operator_pin','approximate_area','unknown'));

revoke all privileges on table public.public_stations from anon, authenticated;
grant select (id, name, operator, address, city, connector_type, power_kw, access_notes, source_url, source_name, verification_status, last_checked_at, latitude, longitude, coordinate_precision)
on table public.public_stations to anon, authenticated;

update public.public_stations set verification_status = 'removed'
where name in (
  'BPCL Charging Station — Sangamvadi RTO',
  'ChargeZone Charging Station — Sangamvadi',
  'ChargeZone x TATA.ev MegaCharger — JW Marriott',
  'Electric Vehicle Charging Station — Kharadi',
  'GLIDA Charging Station — Hyatt Regency',
  'Statiq Charging Station — Westend Center One'
);

with ranked_spotev as (
  select id, row_number() over (partition by name order by created_at asc, id asc) as rn
  from public.public_stations where name = 'SpotEV Charging Station'
)
update public.public_stations s set verification_status = 'removed'
from ranked_spotev r where s.id = r.id and r.rn > 1;

-- These are approximate neighbourhood-centre pins, not exact charger coordinates.
update public.public_stations set latitude = 18.5510, longitude = 73.9430, coordinate_precision = 'approximate_area'
where name = 'Arya EV PCS — Kharadi' and verification_status <> 'removed';
update public.public_stations set latitude = 18.5208, longitude = 73.8410, coordinate_precision = 'approximate_area'
where name = 'Bijlify Charging Station' and verification_status <> 'removed';
update public.public_stations set latitude = 18.5365, longitude = 73.8790, coordinate_precision = 'approximate_area'
where name = 'BPCL Charging Station' and verification_status <> 'removed';
update public.public_stations set latitude = 18.5780, longitude = 73.8320, coordinate_precision = 'approximate_area'
where name = 'BPCL HelloBPCL — Dapodi Old NH4' and verification_status <> 'removed';
update public.public_stations set latitude = 18.5910, longitude = 73.7380, coordinate_precision = 'approximate_area'
where name = 'BPCL HelloBPCL — Hinjawadi Phase III' and verification_status <> 'removed';
update public.public_stations set latitude = 18.5373, longitude = 73.8295, coordinate_precision = 'approximate_area'
where name = 'ChargeZone — JW Marriott area' and verification_status <> 'removed';
update public.public_stations set latitude = 18.5365, longitude = 73.8790, coordinate_precision = 'approximate_area'
where name = 'ChargeZone — Raja Bahadur Motilal Road' and verification_status <> 'removed';
update public.public_stations set latitude = 18.5580, longitude = 73.9050, coordinate_precision = 'approximate_area'
where name = 'GLIDA Charging Station — Weikfield IT Citi Info Park' and verification_status <> 'removed';
update public.public_stations set latitude = 18.5600, longitude = 73.9050, coordinate_precision = 'approximate_area'
where name = 'MetroCharge EV Charging Station' and verification_status <> 'removed';
update public.public_stations set latitude = 18.4930, longitude = 73.8150, coordinate_precision = 'approximate_area'
where name = 'Nikol EV Charging Station' and verification_status <> 'removed';
update public.public_stations set latitude = 18.5650, longitude = 73.6900, coordinate_precision = 'approximate_area'
where name = 'OSR EV Charging Station' and verification_status <> 'removed';
update public.public_stations set latitude = 18.5610, longitude = 73.9130, coordinate_precision = 'approximate_area'
where name = 'SpotEV Charging Station' and verification_status <> 'removed';
update public.public_stations set latitude = 18.5645, longitude = 73.8075, coordinate_precision = 'approximate_area'
where name = 'Statiq — Westend Center One' and verification_status <> 'removed';
update public.public_stations set latitude = 18.4570, longitude = 73.7840, coordinate_precision = 'approximate_area'
where name = 'Zeal Energy Services / ChargeGrid' and verification_status <> 'removed';
