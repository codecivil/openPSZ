update opsz_aufnahme_permissions set subtablemachine ='stammdaten' where keymachine in ('aufnahmedatum','verantwortlich','name','vorname','herkunft','geschlecht','geburtsdatum','kinderdetail','adresse','telefon','email','dolmetscher','mobilität','mobilitätneu','aktiv','sozialanamnese','anfragevon','terminebei','vermittlung','aufnahmepsz','listestellungnahme','stellungnahmeseit','telefondetail','emaildetail','landkreisregion','dateien','ausweiskopievorhanden','muttersprache','sprachkenntnisse','swes','inaktivseit','age','messenger','behinderung','videogespraeche','genderaspekte');
update opsz_aufnahme_permissions set subtablemachine='klassifikation' where keymachine in ('hinweise','jugendlich','begleitet','vulnerabilitaet','angebot','angebotdetail','fruehdiagnostik','kuj','minderheit','suizidversuche','suizidrisikofaktoren','suizidale_absichten');
update opsz_aufnahme_permissions set subtablemachine='gesundheit' where keymachine in ('symptome','anzeichen','vorerkrankungen','medikamente','gesundheitsversorgung','krankenversicherungdetail','anzeichendetail','kv_geaendert','_gesundheitorig','anzeichenkommentar','krankenhausaufenthalt','stoerungsbilder','symptomatik','krankenhausaufenthaltdetails','diagnoseexternkombi','arztangaben');
update opsz_aufnahme_permissions set subtablemachine='aufenthalt' where keymachine in ('indeutschlandseit','aufenthaltsstatus','aufenthaltsprobleme','lebensunterhalt','lebensunterhaltdetail','aufenthaltorig','beratungsangaben');
--create subtables...
INSERT  INTO `os_tables` (`iconname`,`tablemachine`,`tablereadable`,`allowed_roles`,`delete_roles`,`parentmachine`) VALUES ('person-thtough-window','stammdaten','Stammdatan','[0,8,31,33]','[8,33]','opsz_aufnahme');
INSERT  INTO `os_tables` (`iconname`,`tablemachine`,`tablereadable`,`allowed_roles`,`delete_roles`,`parentmachine`) VALUES ('layer-group','klassifikation','Klassifikation','[0,8,31,33]','[8,33]','opsz_aufnahme');
INSERT  INTO `os_tables` (`iconname`,`tablemachine`,`tablereadable`,`allowed_roles`,`delete_roles`,`parentmachine`) VALUES ('notes-medical','gesundheit','Gesundheit','[0,8,31,33]','[8,33]','opsz_aufnahme');
INSERT  INTO `os_tables` (`iconname`,`tablemachine`,`tablereadable`,`allowed_roles`,`delete_roles`,`parentmachine`) VALUES ('circle-nodes','aufenthalt','Aufenthalt in Deutschland','[0,8,31,33]','[8,33]','opsz_aufnahme');
