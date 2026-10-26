create table if not exists public.public_stations (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  operator text,
  address text not null,
  city text not null default 'Pune',
  connector_type text,
  power_kw numeric,
  access_notes text,
  source_url text not null,
  source_name text not null default 'Public directory',
  verification_status text not null default 'listed_unverified'
    check (verification_status in ('listed_unverified','operator_confirmed','temporarily_unavailable','removed')),
  last_checked_at date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.public_stations enable row level security;
revoke all on table public.public_stations from anon, authenticated;
grant select (id, name, operator, address, city, connector_type, power_kw, access_notes, source_url, source_name, verification_status, last_checked_at)
on table public.public_stations to anon, authenticated;

drop policy if exists "Public can read listed public stations" on public.public_stations;
create policy "Public can read listed public stations"
on public.public_stations for select to anon, authenticated
using (verification_status in ('listed_unverified','operator_confirmed'));

create unique index if not exists public_stations_name_address_unique
on public.public_stations (name, address);
