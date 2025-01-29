-- aktiv:2025ff
UPDATE `opsz_aufnahme_references` SET `referencetag`= '_jahr',`depends_on_key`= 'aktiv',`depends_on_value`= 'nein',`allowed_values`= '["2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028"]' WHERE `referencetag`= '_jahr' AND `depends_on_key`= 'aktiv';
-- openStatAdmin-log finished 28.02.2023 09:46:39
