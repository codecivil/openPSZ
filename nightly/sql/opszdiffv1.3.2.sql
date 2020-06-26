ALTER TABLE opsz_aufnahme ADD COLUMN `stoerungsbilder` TEXT;
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) SELECT 'stoerungsbilder','intern festgestellte Störungsbilder',55.3,'TEXT','LIST; MULTIPLE','_stoerung' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'stoerungsbilder') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'stoerungsbilder') = 0;
INSERT INTO opsz_aufnahme_references (referencetag,allowed_values) SELECT '_stoerung','["Abhängigkeitssymptomatik","Angststörung","depressive Störung","postraumatische Belastungssymptomatik","körperliche Erkrankung","somatoforme Störung","psychotische / wahnhafte Störung","Zwangsstörung","Sonstige psychische Störung (u.a. Essstörung)","*Keine psychische Störung"]' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'stoerungsbilder') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_references` where referencetag = '_stoerung') = 0;

ALTER TABLE opsz_aufnahme ADD COLUMN `diagnoseextern` TEXT;
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) SELECT 'diagnoseextern','externe psychiatrische Diagnosen',55.4,'TEXT','LIST; MULTIPLE','_diagnoseextern' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'diagnoseextern') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'diagnoseextern') = 0;
INSERT INTO opsz_aufnahme_references (referencetag,allowed_values) SELECT '_diagnoseextern','["*Keine Diagnose","F00 Demenz bei Alzheimer Krankheit","F00.0 Demenz bei Alzheimer Krankheit mit frühem Beginn","F00.1 Demenz bei Alzheimer Krankheit mit spätem Beginn","F00.2 Demenz bei Alzheimer Krankheit atypische oder gemischte Form","F01 vaskuläre Demenz","F01.0 vaskuläre Demenz mit akutem Beginn","F01.1 Multiinfarktdemenz","F01.2 subkortikale vaskuläre Demenz","F01.3 gemischte (kortikale und subkortikale) vaskuläre Demenz","F02 Demenz bei sonstigen andernorts klassifizierten Krankheiten","F02.0 Demenz bei Pick-Krankheit","F02.1 Demenz bei Creutzfeldt-Jakob-Krankheit","F02.2 Demenz bei Huntington-Krankheit","F02.3 Demenz bei Parkinson-Krankheit","F02.4 Demenz bei Krankheit durch das Humane-Immundefizienz-Virus (HIV)","F03 nicht näher bezeichnete Demenz","F04 organisches amnestisches Syndrom","F05 Delir, nicht durch Alkohol oder sonstige psychotrope Substanzen bedingt","F05.0 Delir ohne Demenz","F05.1 Delir bei Demenz","F06 sonstige psychische Störungen aufgrund einer Schädigung oder Funktionsstörung des Gehirns oder einer körperlichen Krankheit","F06.0 organische Halluzinose","F06.1 organische katatone Störung","F06.2 organische wahnhafte (schizophreniforme) Störungen","F06.3 organische affektive Störungen","F06.4 organische Angststörung","F06.5 organische dissoziative Störung","F06.6 organische emotional labile (asthenische) Störung","F06.7 leichte kognitive Störung","F07 Persönlichkeits- und Verhaltensstörungen aufgrund einer Krankheit, Schädigung oder Funktionsstörung des Gehirns","F07.0 organische Persönlichkeitsstörung","F07.1 postenzephalitisches Syndrom","F07.2 organisches Psychosyndrom nach Schädelhirntrauma","F1 Psychische und Verhaltensstörungen durch psychotrope Substanzen","F10 Störungen durch Alkohol","F10.0 Störungen durch Alkohol - akute Intoxikation","F10.1 Störungen durch Alkohol - schädlicher Gebrauch","F10.2 Störungen durch Alkohol – Abhängigkeitssyndrom","F10.3 Störungen durch Alkohol – Entzugssyndrom","F10.4 Störungen durch Alkohol - Entzugssyndrom mit Delir","F10.5 Störungen durch Alkohol - psychotische Störung","F10.6 Störungen durch Alkohol - amnestisches Syndrom","F10.7 Störungen durch Alkohol - Restzustand und verzögert auftretende psychotische Störung","F11 Störungen durch Opioide","F11.0 Störungen durch Opioide - akute Intoxikation","F11.1 Störungen durch Opioide - schädlicher Gebrauch","F11.2 Störungen durch Opioide – Abhängigkeitssyndrom","F11.3 Störungen durch Opioide – Entzugssyndrom","F11.4 Störungen durch Opioide - Entzugssyndrom mit Delir","F11.5 Störungen durch Opioide - psychotische Störung","F11.6 Störungen durch Opioide - amnestisches Syndrom","F11.7 Störungen durch Opioide - Restzustand und verzögert auftretende psychotische Störung","F12 Störungen durch Cannabinoide","F12.0 Störungen durch Cannabinoide - akute Intoxikation","F12.1 Störungen durch Cannabinoide - schädlicher Gebrauch","F12.2 Störungen durch Cannabinoide – Abhängigkeitssyndrom","F12.3 Störungen durch Cannabinoide – Entzugssyndrom","F12.4 Störungen durch Cannabinoide - Entzugssyndrom mit Delir","F12.5 Störungen durch Cannabinoide - psychotische Störung","F12.6 Störungen durch Cannabinoide - amnestisches Syndrom","F12.7 Störungen durch Cannabinoide - Restzustand und verzögert auftretende psychotische Störung","F13 Störungen durch Sedativa oder Hypnotika","F13.0 Störungen durch Sedativa oder Hypnotika - akute Intoxikation","F13.1 Störungen durch Sedativa oder Hypnotika - schädlicher Gebrauch","F13.2 Störungen durch Sedativa oder Hypnotika – Abhängigkeitssyndrom","F13.3 Störungen durch Sedativa oder Hypnotika – Entzugssyndrom","F13.4 Störungen durch Sedativa oder Hypnotika - Entzugssyndrom mit Delir","F13.5 Störungen durch Sedativa oder Hypnotika - psychotische Störung","F13.6 Störungen durch Sedativa oder Hypnotika - amnestisches Syndrom","F13.7 Störungen durch Sedativa oder Hypnotika - Restzustand und verzögert auftretende psychotische Störung","F14 Störungen durch Kokain","F14.0 Störungen durch Kokain - akute Intoxikation","F14.1 Störungen durch Kokain - schädlicher Gebrauch","F14.2 Störungen durch Kokain – Abhängigkeitssyndrom","F14.3 Störungen durch Kokain – Entzugssyndrom","F14.4 Störungen durch Kokain - Entzugssyndrom mit Delir","F14.5 Störungen durch Kokain - psychotische Störung","F14.6 Störungen durch Kokain - amnestisches Syndrom","F14.7 Störungen durch Kokain - Restzustand und verzögert auftretende psychotische Störung","F15 Störungen durch sonstige Stimulantien einschließlich Koffein","F15.0 Störungen durch sonstige Stimulantien einschließlich Koffein - akute Intoxikation","F15.1 Störungen durch sonstige Stimulantien einschließlich Koffein - schädlicher Gebrauch","F15.2 Störungen durch sonstige Stimulantien einschließlich Koffein – Abhängigkeitssyndrom","F15.3 Störungen durch sonstige Stimulantien einschließlich Koffein – Entzugssyndrom","F15.4 Störungen durch sonstige Stimulantien einschließlich Koffein - Entzugssyndrom mit Delir","F15.5 Störungen durch sonstige Stimulantien einschließlich Koffein - psychotische Störung","F15.6 Störungen durch sonstige Stimulantien einschließlich Koffein - amnestisches Syndrom","F15.7 Störungen durch sonstige Stimulantien einschließlich Koffein - Restzustand und verzögert auftretende psychotische Störung","F16 Störungen durch Halluzinogene","F16.0 Störungen durch Halluzinogene - akute Intoxikation","F16.1 Störungen durch Halluzinogene - schädlicher Gebrauch","F16.2 Störungen durch Halluzinogene – Abhängigkeitssyndrom","F16.3 Störungen durch Halluzinogene – Entzugssyndrom","F16.4 Störungen durch Halluzinogene - Entzugssyndrom mit Delir","F16.5 Störungen durch Halluzinogene - psychotische Störung","F16.6 Störungen durch Halluzinogene - amnestisches Syndrom","F16.7 Störungen durch Halluzinogene - Restzustand und verzögert auftretende psychotische Störung","F17 Störungen durch Tabak","F17.0 Störungen durch Tabak - akute Intoxikation","F17.1 Störungen durch Tabak - schädlicher Gebrauch","F17.2 Störungen durch Tabak – Abhängigkeitssyndrom","F17.3 Störungen durch Tabak – Entzugssyndrom","F17.4 Störungen durch Tabak - Entzugssyndrom mit Delir","F17.5 Störungen durch Tabak - psychotische Störung","F17.6 Störungen durch Tabak - amnestisches Syndrom","F17.7 Störungen durch Tabak - Restzustand und verzögert auftretende psychotische Störung","F18 Störungen durch flüchtige Lösungsmittel","F18.0 Störungen durch flüchtige Lösungsmittel - akute Intoxikation","F18.1 Störungen durch flüchtige Lösungsmittel - schädlicher Gebrauch","F18.2 Störungen durch flüchtige Lösungsmittel – Abhängigkeitssyndrom","F18.3 Störungen durch flüchtige Lösungsmittel – Entzugssyndrom","F18.4 Störungen durch flüchtige Lösungsmittel - Entzugssyndrom mit Delir","F18.5 Störungen durch flüchtige Lösungsmittel - psychotische Störung","F18.6 Störungen durch flüchtige Lösungsmittel - amnestisches Syndrom","F18.7 Störungen durch flüchtige Lösungsmittel - Restzustand und verzögert auftretende psychotische Störung","F19 Störungen durch multiplen Substanzgebrauch und Konsum sonstiger psychotroper Substanzen","F19.0 Störungen durch multiplen Substanzgebrauch und Konsum sonstiger psychotroper Substanzen - akute Intoxikation","F19.1 Störungen durch multiplen Substanzgebrauch und Konsum sonstiger psychotroper Substanzen - schädlicher Gebrauch","F19.2 Störungen durch multiplen Substanzgebrauch und Konsum sonstiger psychotroper Substanzen – Abhängigkeitssyndrom","F19.3 Störungen durch multiplen Substanzgebrauch und Konsum sonstiger psychotroper Substanzen – Entzugssyndrom","F19.4 Störungen durch multiplen Substanzgebrauch und Konsum sonstiger psychotroper Substanzen - Entzugssyndrom mit Delir","F19.5 Störungen durch multiplen Substanzgebrauch und Konsum sonstiger psychotroper Substanzen - psychotische Störung","F19.6 Störungen durch multiplen Substanzgebrauch und Konsum sonstiger psychotroper Substanzen - amnestisches Syndrom","F19.7 Störungen durch multiplen Substanzgebrauch und Konsum sonstiger psychotroper Substanzen - Restzustand und verzögert auftretende psychotische Störung","F20 Schizophrenie","F20.0 paranoide Schizophrenie","F20.1 hebephrene Schizophrenie","F20.2 katatone Schizophrenie","F20.3 undifferenzierte Depression","F20.4 postschizophrene Depression","F20.5 schizophrenes Residuum","F20.6 Schizophrenia simplex","F21 schizotype Störung","F22 anhaltende wahnhafte Störungen","F23 vorübergehende akute psychotische Störungen","F23.0 polymorphe psychotische Störung ohne Symptome einer Schizophrenie","F23.1 polymorphe psychotische Störung mit Symptomen einer Schizophrenie","F23.2 schizophreniforme psychotische Störung","F23.3 sonstige vorwiegend wahnhafte psychotische Störung","F24 induzierte wahnhafte Störung","F25 schizoaffektive Störungen","F30 manische Episode","F30.0 Hypomanie","F30.1 Manie ohne psychotische Symptome","F30.2 Manie mit psychotischen Symptomen","F31 bipolare affektive Störung","F31.0 bipolare affektive Störung - hypomanische Episode","F31.1 bipolare affektive Störung - manische Episode, ohne psychotische Symptome","F31.2 bipolare affektive Störung - manische Episode, mit psychotischen Symptomen","F31.3 bipolare affektive Störung - leichte oder mittelgradige depressive Episode","F31.4 bipolare affektive Störung - schwere depressive Episode, ohne psychotische Symptome","F31.5 bipolare affektive Störung - schwere depressive Episode mit psychotischen Symptomen","F31.6 bipolare affektive Störung - gemischte Episodev F31.7 remittiert","F32 depressive Episode","F32.0 leichte depressive Episode","F32.1 mittelgradige depressive Episode","F32.2 schwere depressive Episode ohne psychotische Symptome","F32.3 schwere depressive Episode mit psychotischen Symptomen","F33 rezidivierende depressive Störungen","F33.0 rezidivierende depressive Störungen - leichte Episode","F33.1 rezidivierende depressive Störungen - mittelgradige Episode","F33.2 rezidivierende depressive Störungen - schwere Episode ohne psychotische Symptome","F33.3 rezidivierende depressive Störungen - schwere Episode mit psychotischen Symptomen","F33.4 rezidivierende depressive Störungen – remittiert","F34 anhaltende affektive Störungen","F34.0 Zyklothymie","F34.1 Dysthymie","F38 sonstige affektive Störungen","F38.0 sonstige einzelne affektive Störungen","F38.00 gemischte affektive Episode","F38.1 sonstige rezidivierende affektive Störungen","F38.10 rezidivierende kurze depressive Störung","F38.8 sonstige näher bezeichnete affektive Störungen","F40 phobische Störung","F40.0 Agoraphobie","F40.1 soziale Phobien","F40.2 spezifische (isolierte) Phobien","F41 sonstige Angststörungen","F41.0 Panikstörung (episodisch paroxysmale Angst)","F41.1 generalisierte Angststörung","F41.2 Angst und depressive Störung, gemischt","F41.3 sonstige gemischte Angststörungen","F42 Zwangsstörung","F42.0 vorwiegend Zwangsgedanken oder Grübelzwang","F42.1 vorwiegend Zwangshandlungen (Zwangsrituale)","F42.2 Zwangsgedanken und -handlungen, gemischt","F43 Reaktionen auf schwere Belastungen und Anpassungsstörungen","F43.0 akute Belastungsreaktion","F43.1 posttraumatische Belastungsstörung","F43.2 Anpassungsstörungen","F44 dissoziative Störungen (Konversionsstörungen)","F44.0 dissoziative Amnesie","F44.1 dissoziative Fugue","F44.2 dissoziativer Stupor","F44.3 Trance und Besessenheitszustände","F44.4 dissoziative Bewegungsstörungen","F44.5 dissoziative Krampfanfälle","F44.6 dissoziative Sensibilitäts- und Empfindungsstörungen","F44.7 dissoziative Störungen (Konversionsstörungen), gemischt","F44.8 sonstige dissoziative Störungen (Konversionsstörungen)","F44.80 Ganser Syndrom","F44.81 Multiple Persönlichkeitsstörung","F44.82 vorübergehende dissoziative Störungen (Konversionsstörungen) des Kindes- und Jugendalters","F45 somatoforme Störungen","F45.0 Somatisierungsstörung","F45.1 undifferenzierte Somatisierungsstörung","F45.2 hypochondrische Störung","F45.3 somatoforme autonome Funktionsstörung","F45.4 anhaltende somatoforme Schmerzstörung","F48 sonstige neurotische Störungen","F48.0 Neurasthenie","F48.1 Depersonalisations-, Derealisationssyndrom","F50 Essstörungen","F50.0 Anorexia nervosa","F50.2 Bulimia nervosa","F50.4 Essattacken bei sonstigen psychischen Störungen","F50.5 Erbrechen bei psychischen Störungen","F51 nichtorganische Schlafstörungen","F51.0 Insomnie","F51.1 Hypersomnie","F51.2 Störung des Schlaf-Wach-Rhythmus","F51.3 Schlafwandeln (Somnambulismus)","F51.4 Pavor nocturnus","F51.5 Albträume","F52 sexuelle Funktionsstörungen, nicht bedingt durch eine organische Störung oder Krankheit","F52.0 Mangel oder Verlust von sexuellem Verlangen","F52.1 sexuelle Aversion und mangelnde sexuelle Befriedigung","F52.2 Versagen genitaler Reaktionen","F52.3 Orgasmusstörung","F52.4 Ejaculatio praecox","F52.5 nichtorganischer Vaginismus","F52.6 nichtorganische Dypspareunie","F52.7 gesteigertes sexuelles Verlangen","F53 psychische und Verhaltensstörungen im Wochenbett, nicht andernorts klassifizierbar","F54 psychische Faktoren und Verhaltenseinflüsse bei andernorts klassifizierten Krankheiten","F55 Missbrauch von nicht abhängigkeitserzeugenden Substanzen","F60 Persönlichkeitsstörungen","F60.0 paranoide Persönlichkeitsstörung","F60.1 schizoide Persönlichkeitsstörung","F60.2 dissoziale Persönlichkeitsstörung","F60.3 emotional instabile Persönlichkeitsstörung","F60.30 Persönlichkeitsstörung - impulsiver Typ","F60.31 Persönlichkeitsstörung – Borderline-Typ","F60.4 histrionische Persönlichkeitsstörung","F60.5 anankastische Persönlichkeitsstörung","F60.6 ängstliche (vermeidende) Persönlichkeitsstörung","F60.7 abhängige Persönlichkeitsstörung","F61 kombinierte und sonstige Persönlichkeitsstörungen","F62 andauernde Persönlichkeitsänderungen, nicht Folge einer Schädigung oder Krankheit des Gehirns","F62.0 andauernde Persönlichkeitsänderung nach Extrembelastung","F62.1 andauernde Persönlichkeitsänderung nach psychischer Krankheit","F63 abnorme Gewohnheiten und Störungen der Impulskontrolle","F63.0 pathologisches Spielen","F63.1 pathologische Brandstiftung (Pyromanie)","F63.2 pathologisches Stehlen (Kleptomanie)","F63.3 Trichotillomanie","F64 Störungen der Geschlechtsidentität","F64.0 Transsexualismus","F64.1 Transvestitismus unter Beibehaltung beider Geschlechtsrollen","F64.2 Störung der Geschlechtsidentität des Kindesalters","F65 Störungen der Sexualpräferenz","F65.0 Fetischismus","F65.1 fetischistischer Transvestitismus","F65.2 Exhibitionismus","F65.3 Voyeurismus","F65.4 Pädophilie","F65.5 Sadomasochismus","F65.6 multiple Störungen der Sexualpräferenz","F66 psychische und Verhaltensprobleme in Verbindung mit der sexuellen Entwicklung und Orientierung","F66.0 sexuelle Reifungskrise","F66.1 ichdystone Sexualorientierung","F66.2 sexuelle Beziehungsstörung","F68 sonstige Persönlichkeits- und Verhaltensstörungen","F68.0 Entwicklung körperlicher Symptome aus psychischen Gründen","F68.1 artifizielle Störung (absichtliches Erzeugen oder Vortäuschen von körperlichen der psychischen Symptomen oder Behinderungen)","F70 leichte Intelligenzminderung","F71 mittelgradige Intelligenzminderung","F72 schwere Intelligenzminderung","F73 schwerste Intelligenzminderung","F80 umschriebene Entwicklungsstörungen des Sprechens und der Sprache","F80.0 Artikulationsstörung","F80.1 expressive Sprachstörung","F80.2 rezeptive Sprachstörung","F80.3 erworbene Aphasie mit Epilepsie (Landau-Kleffner-Syndrom)","F81 umschriebene Entwicklungsstörungen schulischer Fertigkeiten","F81.0 Lese- und Rechtschreibstörung","F81.1 isolierte Rechtschreibstörung","F81.2 Rechenstörung","F81.3 kombinierte Störung schulischer Fertigkeiten","F82 umschriebene Entwicklungsstörung der motorischen Funktionen","F83 kombinierte umschriebene Entwicklungsstörungen","F84 tiefgreifende Entwicklungsstörungen","F84.0 frühkindlicher Autismus","F84.1 atypischer Autismus","F84.2 Rett-Syndrom","F84.3 sonstige desintegrative Störung des Kindesalters","F84.4 überaktive Störung mit Intelligenzminderung und Bewegungsstereotypien","F84.5 Asperger-Syndrom","F90 hyperkinetische Störungen","F90.0 einfache Aktivitäts- und Aufmerksamkeitsstörung","F90.1 hyperkinetische Störung des Sozialverhaltens","F91 Störung des Sozialverhaltens","F91.0 Störung des Sozialverhaltens auf den familiären Rahmen beschränkt","F91.1 Störung des Sozialverhaltens bei fehlenden sozialen Bindungen","F91.2 Störung des Sozialverhaltens bei vorhandenen sozialen Bindungen","F91.3 Störung des Sozialverhaltens mit oppositionellem, aufsässigen Verhalten","F92 kombinierte Störung des Sozialverhaltens und der Emotionen","F93 emotionale Störungen des Kindesalters","F93.0 emotionale Störung mit Trennungsangst des Kindesalters","F93.1 phobische Störung des Kindesalters","F93.2 Störung mit sozialer Ängstlichkeit des Kindesalters","F93.3 emotionale Störung mit Geschwisterrivalität","F94 Störungen sozialer Funktionen mit Beginn in der Kindheit und Jugend","F94.0 elektiver Mutismus","F94.1 reaktive Bindungsstörung des Kindesalters","F94.2 Bindungsstörung des Kindesalters mit Enthemmung","F95 Ticstörungen","F95.0 vorübergehende Ticstörung","F95.1 chronische motorische oder vokale Ticstörung","F95.2 kombinierte, vokale und multiple motorische Tics (Tourette-Syndrom)","F98 sonstige Verhaltens- und emotionale Störungen mit Beginn in der Kindheit und Jugend","F98.0 Enuresis","F98.1 Enkopresis","F98.2 Fütterstörung im frühen Kindesalter","F98.3 Pica im Kindesalter","F98.4 stereotype Bewegungsstörung","F98.5 Stottern (Stammeln)","F98.6 Poltern"]' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'diagnoseextern') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_references` where referencetag = '_diagnoseextern') = 0;

ALTER TABLE opsz_aufnahme ADD COLUMN `symptomatik` TEXT;
INSERT INTO opsz_aufnahme_permissions (keymachine,keyreadable,realid,typelist,edittype,referencetag) SELECT 'symptomatik','kategorisierte Symptomatik',16.5,'TEXT','LIST; MULTIPLE','_symptomatik' FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'symptomatik') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_permissions` where keymachine = 'symptomatik') = 0;
INSERT INTO opsz_aufnahme_references (referencetag,allowed_values) SELECT '_symptomatik','["Schlafprobleme","Depressivität","Ängstlichkeit","Intrusionen/Flashbacks/Alpträume","psychosomatische Symptomatik","organische Krankheiten","Suizidalität","Trauma","Hyperarousal","Alkohol-/Drogenabhängigkeit","Dissoziationen","Selbst- oder Fremdverletzung","psychotische Symptome","Vermeidung (von triggernden Situationen)","Angst vor Abschiebung","Sonstiges","*zu klären"]'  FROM DUAL WHERE (SELECT count(*) FROM information_schema.COLUMNS WHERE TABLE_NAME = 'opsz_aufnahme' AND COLUMN_NAME = 'symptomatik') > 0 AND (SELECT count(keymachine) FROM `opsz_aufnahme_references` where referencetag = '_symptomatik') = 0;



