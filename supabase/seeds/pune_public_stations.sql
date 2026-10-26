-- Curated starter records for Pune public charging station discovery.
-- These are third-party/public-directory listings, not operator-confirmed live availability.
-- Re-check every station's details before relying on it or advertising it as verified.
insert into public.public_stations
(name, operator, address, city, connector_type, power_kw, access_notes, source_url, source_name, verification_status, last_checked_at)
values
('BPCL Charging Station','BPCL','GVH6+JXC, RTO, Sangamvadi, Pune, Maharashtra 411001','Pune',null,null,'Public listing; confirm connector, pricing, access and live status with operator.','https://e-amrit.niti.gov.in/charging-station-locators','e-AMRIT locator and public business listing','listed_unverified','2026-10-26'),
('GLIDA Charging Station — Weikfield IT Citi Info Park','GLIDA','Weikfield IT Citi Info Park, Pune–Nagar Road, Sakore Nagar, Viman Nagar, Pune, Maharashtra 411014','Pune',null,null,'Listed at Hyatt Regency basement parking; confirm site access and connector in GLIDA app/operator channel.','https://e-amrit.niti.gov.in/charging-station-locators','e-AMRIT locator and public business listing','listed_unverified','2026-10-26'),
('MetroCharge EV Charging Station','MetroCharge','Sakore Nagar, Viman Nagar, Pune, Maharashtra 411014','Pune',null,null,'Exact entrance and connector details require confirmation before travel.','https://e-amrit.niti.gov.in/charging-station-locators','e-AMRIT locator and public business listing','listed_unverified','2026-10-26'),
('Zeal Energy Services / ChargeGrid','ChargeGrid','Destination Center, Nanded City, Sinhgad Road, Pune, Maharashtra 411068','Pune',null,null,'Public listing describes an EV charging point; confirm operator name, connector and access before travel.','https://e-amrit.niti.gov.in/charging-station-locators','e-AMRIT locator and public business listing','listed_unverified','2026-10-26'),
('OSR EV Charging Station','OSR','Hinjawadi–Pirangut Road, near Bapuji Bua Mandir, Godambewadi, Pune district, Maharashtra 412115','Pune',null,null,'Public listing reports EV charging; verify exact location, connector, pricing and access with operator.','https://e-amrit.niti.gov.in/charging-station-locators','e-AMRIT locator and public business listing','listed_unverified','2026-10-26'),
('ChargeZone — JW Marriott area','ChargeZone','JW Marriott, Senapati Bapat Road, Model Colony, Shivajinagar, Pune, Maharashtra 411016','Pune',null,null,'Confirm whether charger is accessible to non-hotel visitors and check connector/price with ChargeZone.','https://e-amrit.niti.gov.in/charging-station-locators','e-AMRIT locator and public business listing','listed_unverified','2026-10-26'),
('ChargeZone — Raja Bahadur Motilal Road','ChargeZone','Raja Bahadur Motilal Road, Sangamvadi, Pune, Maharashtra 411001','Pune','CCS2',60,'Third-party listing reports CCS2 up to 60 kW; verify with operator before relying on these details.','https://evgoo.io/charging-stations/pune','evgoo Pune public charging directory','listed_unverified','2026-10-26'),
('Arya EV PCS — Kharadi','Arya EV PCS','1344/3, Grant Road, near Phoenix School, Kharadi, Pune, Maharashtra 411014','Pune','CCS2',null,'Public business listing; confirm power, pricing, app requirements and availability with operator.','https://e-amrit.niti.gov.in/charging-station-locators','e-AMRIT locator and public business listing','listed_unverified','2026-10-26'),
('SpotEV Charging Station','SpotEV','Lane No. 21, behind Padel Hub, near Dorabjee Mall, Pune, Maharashtra 411014','Pune',null,null,'Public listing describes app-led charging; verify connectors and station status in operator app.','https://e-amrit.niti.gov.in/charging-station-locators','e-AMRIT locator and public business listing','listed_unverified','2026-10-26'),
('Statiq — Westend Center One','Statiq','Upper basement, Westend Center One, Wireless Colony, Aundh, Pune, Maharashtra 411067','Pune','CCS2',null,'Third-party listing indicates CCS2; confirm site access and current availability in Statiq app.','https://evgoo.io/charging-stations/pune','evgoo Pune public charging directory','listed_unverified','2026-10-26'),
('Bijlify Charging Station','Bijlify','4, Jangali Maharaj Road, Shivajinagar, Pune, Maharashtra 411005','Pune',null,null,'Public listing; confirm connector, price, parking access and live status before travel.','https://e-amrit.niti.gov.in/charging-station-locators','e-AMRIT locator and public business listing','listed_unverified','2026-10-26'),
('Nikol EV Charging Station','Nikol','Pune Ahilyanagar Highway, near Sai Shraddha CNG station, Pune, Maharashtra','Pune','CCS2',80,'Third-party directory reports up to 80 kW DC; verify current operator, address, connector and availability.','https://evgoo.io/charging-stations/pune','evgoo Pune public charging directory','listed_unverified','2026-10-26')
on conflict (name, address) do update set
 operator = excluded.operator,
 connector_type = excluded.connector_type,
 power_kw = excluded.power_kw,
 access_notes = excluded.access_notes,
 source_url = excluded.source_url,
 source_name = excluded.source_name,
 verification_status = 'listed_unverified',
 last_checked_at = excluded.last_checked_at,
 updated_at = now();
