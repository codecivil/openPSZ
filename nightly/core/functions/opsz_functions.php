<?php
function substr_in_array($needle, array $haystack)
{
	//by Colin DeCarlo from https://akrabat.com/substr_in_array/
    return array_reduce($haystack, function ($inArray, $item) use ($needle) {
        return $inArray || false !== strpos($item, $needle);
    }, false);
}

//obsolete: to be removed
function trafficLightOld(array $PARAM,mysqli $conn)
{
	$tables = $PARAM['table'];
	
	unset($_stmt_array); $_stmt_array = array();
	$_stmt_array['stmt'] = 'SELECT iconname,tablemachine from os_tables';
	/*$_stmt_array['str_types'] = 's';
	$_stmt_array['arr_values'] = array($table);*/
	$_table_result = execute_stmt($_stmt_array,$conn,true)['result'];
	$icon = array();
	for ( $i = 0; $i < sizeof($_table_result); $i++ ) {
		$icon[$_table_result[$i]['tablemachine']] = $_table_result[$i]['iconname'];
	}
	
	if (sizeof($tables) == 0) { return; }
	?>
	<div class="imp_wrapper">
		<div class="imp_close"><i class="fas fa-times-circle" onclick="_close(this,true);"></i></div>
	<?php
	foreach ( $tables as $table )
	{
		switch($table) {
			case 'opsz_aufnahme': 
				unset($_stmt_array); $_stmt_array = array();
				$_stmt_array['stmt'] = 'SELECT id_opsz_aufnahme,DATEDIFF(CURRENT_DATE(),stellungnahmeseit) AS diff from view__opsz_aufnahme__'.$_SESSION['os_role'].' WHERE DATEDIFF(CURRENT_DATE(),stellungnahmeseit) > 42';
				$result = execute_stmt($_stmt_array,$conn);
				if ( ! isset ($result['result']) ) { break; };
				$_result = $result['result'];
				$_array = array_combine($_result['id_opsz_aufnahme'],$_result['diff']);
				arsort($_array,SORT_NUMERIC);
				?>
				<div class="tableicon"><i class="fas fa-<?php html_echo($icon[$table]); ?>"></i></div>
				<div class="opsz_dokumentation_stellungnahme">
					<table>
						<tr>
							<th>Nachname</th>
							<th>Vorname</th>
							<th>auf Liste Stellungnahme seit Tagen</th>
						</tr>
				<?php 
				foreach ( $_array as $key=>$value )
				{
					$_class = '';
					if ( $value > 41 ) { $_class = "yellow"; };
					if ( $value > 89 ) { $_class = "red"; };
					if ( $value > 41)
					{
						unset($_stmt_array); $_stmt_array = array();
						$_stmt_array['stmt'] = 'SELECT name,vorname from view__opsz_aufnahme__'.$_SESSION['os_role'].' WHERE id_opsz_aufnahme = ?';						
						$_stmt_array['str_types'] = 'i';
						$_stmt_array['arr_values'] = array($key);
						$_table_result = execute_stmt($_stmt_array,$conn,true)['result'][0];
						$_rnd = rand(0,32767);
						?>
						<tr class="<?php html_echo($_class); ?>">
							<td><?php html_echo($_table_result['name']); ?></td>
							<td><?php html_echo($_table_result['vorname']); ?></td>
							<td><?php html_echo($value); ?></td>
							<td>
								<form method="post" id="ampelForm_<?php echo($_rnd); ?>" class="inline" action="" onsubmit="callFunction(this,'getDetails','_popup_',false,'details'); return false;"><input form="ampelForm_<?php echo($_rnd); ?>" value="<?php echo($key); ?>" name="id_opsz_aufnahme" hidden="" type="text"><input form="ampelForm__<?php echo($_rnd); ?>" id="ampelSubmit__<?php echo($_rnd); ?>" hidden="" type="submit"></form><label for="ampelSubmit__<?php echo($_rnd); ?>"><i class="fas fa-address-card"></i></label>
							</td>							
						</tr>
						<?php
					}
				}
				?>
					</table>
				</div>
				<?php 
				unset($_stmt_array); $_stmt_array = array();
				$_stmt_array['stmt'] = 'SELECT id_opsz_aufnahme,DATEDIFF(CURRENT_DATE(),gutachtenseit) AS diff from view__opsz_dokumentation__'.$_SESSION['os_role'].' WHERE DATEDIFF(CURRENT_DATE(),gutachtenseit) > 41';
				$result = execute_stmt($_stmt_array,$conn);
				if ( ! isset ($result['result']) ) { break; };
				$_result = $result['result'];
				$_array = array_combine($_result['id_opsz_aufnahme'],$_result['diff']);
				arsort($_array,SORT_NUMERIC);
				?>
				<div class="tableicon"><i class="fas fa-<?php html_echo($icon[$table]); ?>"></i></div>
				<div class="opsz_dokumentation_gutachten">
					<table>
						<tr>
							<th>Nachname</th>
							<th>Vorname</th>
							<th>auf Liste Gutachten seit Tagen</th>
						</tr>
				<?php 
				foreach ( $_array as $key=>$value )
				{
					$_class = '';
					if ( $value > 41 ) { $_class = "yellow"; };
					if ( $value > 89 ) { $_class = "red"; };
					if ( $value > 41)
					{
						unset($_stmt_array); $_stmt_array = array();
						$_stmt_array['stmt'] = 'SELECT name,vorname from view__opsz_aufnahme__'.$_SESSION['os_role'].' WHERE id_opsz_aufnahme = ?';						
						$_stmt_array['str_types'] = 'i';
						$_stmt_array['arr_values'] = array($key);
						$_table_result = execute_stmt($_stmt_array,$conn,true)['result'][0];
						$_rnd = rand(0,32767);
						?>
						<tr class="<?php html_echo($_class); ?>">
							<td><?php html_echo($_table_result['name']); ?></td>
							<td><?php html_echo($_table_result['vorname']); ?></td>
							<td><?php html_echo($value); ?></td>
							<td>
								<form method="post" id="ampelForm_<?php echo($_rnd); ?>" class="inline" action="" onsubmit="callFunction(this,'getDetails','_popup_',false,'details'); return false;"><input form="ampelForm_<?php echo($_rnd); ?>" value="<?php echo($key); ?>" name="id_opsz_aufnahme" hidden="" type="text"><input form="ampelForm__<?php echo($_rnd); ?>" id="ampelSubmit__<?php echo($_rnd); ?>" hidden="" type="submit"></form><label for="ampelSubmit__<?php echo($_rnd); ?>"><i class="fas fa-address-card"></i></label>
							</td>							
						</tr>
						<?php
					}
				}
				?>
					</table>
				</div>
				<?php 
				break;
			case 'opsz_vermittlungslisten': 
				unset($_stmt_array); $_stmt_array = array();
				$_stmt_array['stmt'] = 'SELECT id_opsz_aufnahme,listentyp,DATEDIFF(CURRENT_DATE(),auflisteseit) AS diff from view__opsz_vermittlungslisten__'.$_SESSION['os_role'].' WHERE DATEDIFF(CURRENT_DATE(),auflisteseit) > 41';
				$result = execute_stmt($_stmt_array,$conn);
				if ( ! isset ($result['result']) ) { break; };
				$_result = $result['result'];
				$_array = array_combine($_result['id_opsz_aufnahme'],$_result['diff']);
				arsort($_array,SORT_NUMERIC);
				?>
				<div class="tableicon"><i class="fas fa-<?php html_echo($icon[$table]); ?>"></i></div>
				<div class="opsz_vermittlungslisten">
					<table>
						<tr>
							<th>Nachname</th>
							<th>Vorname</th>
							<th>auf Liste</th>
							<th>seit Tagen</th>
						</tr>
				<?php 
				foreach ( $_array as $key=>$value )
				{
					$_class = '';
					if ( $value > 41 ) { $_class = "yellow"; };
					if ( $value > 89 ) { $_class = "red"; };
					if ( $value > 41)
					{
						unset($_stmt_array); $_stmt_array = array();
						$_stmt_array['stmt'] = 'SELECT name,vorname from view__opsz_aufnahme__'.$_SESSION['os_role'].' WHERE id_opsz_aufnahme = ?';						
						$_stmt_array['str_types'] = 'i';
						$_stmt_array['arr_values'] = array($key);
						$_table_result = execute_stmt($_stmt_array,$conn,true)['result'][0];
						$_rnd = rand(0,32767);
						?>
						<tr class="<?php html_echo($_class); ?>">
							<td><?php html_echo($_table_result['name']); ?></td>
							<td><?php html_echo($_table_result['vorname']); ?></td>
							<td><?php html_echo($_result['listentyp']); ?></td>
							<td><?php html_echo($value); ?></td>
							<td>
								<form method="post" id="ampelForm_<?php echo($_rnd); ?>" class="inline" action="" onsubmit="callFunction(this,'getDetails','_popup_',false,'details'); return false;"><input form="ampelForm_<?php echo($_rnd); ?>" value="<?php echo($key); ?>" name="id_opsz_aufnahme" hidden="" type="text"><input form="ampelForm__<?php echo($_rnd); ?>" id="ampelSubmit__<?php echo($_rnd); ?>" hidden="" type="submit"></form><label for="ampelSubmit__<?php echo($_rnd); ?>"><i class="fas fa-address-card"></i></label>
							</td>							
						</tr>
						<?php
					}
				}
				?>
					</table>
				</div>
				<?php 
				break;
			case 'opsz_kosten': 
				unset($_stmt_array); $_stmt_array = array();
				$_stmt_array['stmt'] = 'SELECT id_opsz_aufnahme,zweck,widerspruch,widerspruchsentscheid,DATEDIFF(CURRENT_DATE(),widerspruchsdatum) AS wdiff,klage,DATEDIFF(CURRENT_DATE(),klagedatum) AS kdiff,klageentscheid from view__opsz_kosten__'.$_SESSION['os_role'].' WHERE DATEDIFF(CURRENT_DATE(),widerspruchsdatum) > 60 OR DATEDIFF(CURRENT_DATE(),klagedatum) > 60';
				$result = execute_stmt($_stmt_array,$conn);
				if ( ! isset ($result['result']) ) { break; };
				$_result = $result['result'];
				$_array = array_combine($_result['id_opsz_aufnahme'],$_result['wdiff']);
				$_bin_array = array_combine($_result['id_opsz_aufnahme'],$_result['widerspruch']);
				$_entscheid_array = array_combine($_result['id_opsz_aufnahme'],$_result['widerspruchsentscheid']);
				arsort($_array,SORT_NUMERIC);
				?>
				<div class="tableicon"><i class="fas fa-<?php html_echo($icon[$table]); ?>"></i></div>
				<div class="opsz_kosten">
					<table>
						<tr>
							<th>Nachname</th>
							<th>Vorname</th>
							<th>Kostenübernahme</th>
							<th>Widerspruch eingelegt seit Tagen</th>
						</tr>
				<?php 
				foreach ( $_array as $key=>$value )
				{
					$_class = '';
					if ( $value > 60 ) { $_class = "yellow"; };
					if ( $value > 89 ) { $_class = "red"; };
					if ( $value > 60 AND $_bin_array[$key] == "eingelegt" AND $_entscheid_array[$key] == '-' )
					{
						unset($_stmt_array); $_stmt_array = array();
						$_stmt_array['stmt'] = 'SELECT name,vorname from view__opsz_aufnahme__'.$_SESSION['os_role'].' WHERE id_opsz_aufnahme = ?';						
						$_stmt_array['str_types'] = 'i';
						$_stmt_array['arr_values'] = array($key);
						$_table_result = execute_stmt($_stmt_array,$conn,true)['result'][0];
						$_rnd = rand(0,32767);
						?>
						<tr class="<?php html_echo($_class); ?>">
							<td><?php html_echo($_result['name']); ?></td>
							<td><?php html_echo($_result['vorname']); ?></td>
							<td><?php html_echo($_result['zweck']); ?></td>
							<td><?php html_echo($value); ?></td>
							<td>
								<form method="post" id="ampelForm_<?php echo($_rnd); ?>" class="inline" action="" onsubmit="callFunction(this,'getDetails','_popup_',false,'details'); return false;"><input form="ampelForm_<?php echo($_rnd); ?>" value="<?php echo($key); ?>" name="id_opsz_aufnahme" hidden="" type="text"><input form="ampelForm__<?php echo($_rnd); ?>" id="ampelSubmit__<?php echo($_rnd); ?>" hidden="" type="submit"></form>
								<label for="ampelSubmit__<?php echo($_rnd); ?>"><i class="fas fa-address-card"></i></label>
							</td>							
						</tr>
						<?php
					}
				}
				?>
					</table>
				</div>
				<?php 
				$_array = array_combine($_result['id_opsz_aufnahme'],$_result['kdiff']);
				$_bin_array = array_combine($_result['id_opsz_aufnahme'],$_result['klage']);
				$_entscheid_array = array_combine($_result['id_opsz_aufnahme'],$_result['klageentscheid']);
				arsort($_array,SORT_NUMERIC);
				?>
				<div class="tableicon"><i class="fas fa-<?php html_echo($icon[$table]); ?>"></i></div>
				<div class="opsz_kosten">
					<table>
						<tr>
							<th>Nachname</th>
							<th>Vorname</th>
							<th>Kostenübernahme</th>
							<th>Klage eingereicht seit Tagen</th>
						</tr>
				<?php 
				foreach ( $_array as $key=>$value )
				{
					$_class = '';
					if ( $value > 60 ) { $_class = "yellow"; };
					if ( $value > 89 ) { $_class = "red"; };
					if ( $value > 60 AND $_bin_array[$key] == "eingereicht" AND $_entscheid_array[$key] == '-' )
					{
						unset($_stmt_array); $_stmt_array = array();
						$_stmt_array['stmt'] = 'SELECT name,vorname from view__opsz_aufnahme__'.$_SESSION['os_role'].' WHERE id_opsz_aufnahme = ?';						
						$_stmt_array['str_types'] = 'i';
						$_stmt_array['arr_values'] = array($key);
						$_table_result = execute_stmt($_stmt_array,$conn,true)['result'][0];
						$_rnd = rand(0,32767);
						?>
						<tr class="<?php html_echo($_class); ?>">
							<td><?php html_echo($_result['name']); ?></td>
							<td><?php html_echo($_result['vorname']); ?></td>
							<td><?php html_echo($_result['zweck']); ?></td>
							<td><?php html_echo($value); ?></td>
							<td>
								<form method="post" id="ampelForm_<?php echo($_rnd); ?>" class="inline" action="" onsubmit="callFunction(this,'getDetails','_popup_',false,'details'); return false;"><input form="ampelForm_<?php echo($_rnd); ?>" value="<?php echo($key); ?>" name="id_opsz_aufnahme" hidden="" type="text"><input form="ampelForm__<?php echo($_rnd); ?>" id="ampelSubmit__<?php echo($_rnd); ?>" hidden="" type="submit"></form>
								<label for="ampelSubmit__<?php echo($_rnd); ?>"><i class="fas fa-address-card"></i></label>
							</td>							
						</tr>
						<?php
					}
				}
				?>
					</table>
				</div>
				<?php 
				break;
			case 'opsz_termine': 
				//nur OS und mind 5, 10, 20 in letzten 6 Monaten
				unset($_stmt_array); $_stmt_array = array();
				$_stmt_array['stmt'] = 'SELECT id_opsz_aufnahme,typ from view__opsz_termine__'.$_SESSION['os_role'].' WHERE beginn < CURRENT_DATE() AND beginn >= DATE_ADD(CURRENT_DATE(), INTERVAL -6 MONTH)';
				$result = execute_stmt($_stmt_array,$conn);
				if ( ! isset ($result['result']) ) { break; };
				$_result = $result['result'];
				//filter the ones with only OS type
				$_ids = array_unique($_result['id_opsz_aufnahme']);
				for ( $i = 0; $i < count($_result['typ']); $i++ ) {
					if ( $_result['typ'][$i] != 'OS' AND array_search($_result['id_opsz_aufnahme'][$i],$_ids) != false ) { unset($_ids[array_search($_result['id_opsz_aufnahme'][$i],$_ids)]); };
				}
				$_ids = array_unique($_ids);
				$_termine_result = array();
				foreach ( $_result['id_opsz_aufnahme'] as $_maybe ) {
					if ( in_array($_maybe,$_ids) ) { $_termine_result[] = $_maybe; };
				}
				$_termine_count = array_count_values($_termine_result);
				arsort($_termine_count,SORT_NUMERIC);
				?>
				<div class="tableicon"><i class="fas fa-<?php html_echo($icon[$table]); ?>"></i></div>
				<div class="opsz_termine">
					<table>
						<tr>
							<th>Nachname</th>
							<th>Vorname</th>
							<th>nur OS, letzte 6 Mon.</th>
						</tr>
				<?php 
				foreach ( $_termine_count as $key=>$value )
				{
					$_class = '';
					if ( $value > 4 ) { $_class = "yellow"; };
					if ( $value > 9 ) { $_class = "orange"; };
					if ( $value > 19 ) { $_class = "red"; };
					if ( $value > 4)
					{
						unset($_stmt_array); $_stmt_array = array();
						$_stmt_array['stmt'] = 'SELECT name,vorname from view__opsz_aufnahme__'.$_SESSION['os_role'].' WHERE id_opsz_aufnahme = ?';						
						$_stmt_array['str_types'] = 'i';
						$_stmt_array['arr_values'] = array($key);
						$_table_result = execute_stmt($_stmt_array,$conn,true)['result'][0];
						$_rnd = rand(0,32767);
						?>
						<tr class="<?php html_echo($_class); ?>">
							<td><?php html_echo($_table_result['name']); ?></td>
							<td><?php html_echo($_table_result['vorname']); ?></td>
							<td><?php html_echo($value); ?></td>
							<td>
								<form method="post" id="ampelForm_<?php echo($_rnd); ?>" class="inline" action="" onsubmit="callFunction(this,'getDetails','_popup_',false,'details'); return false;">
									<input form="ampelForm_<?php echo($_rnd); ?>" value="<?php echo($key); ?>" name="id_opsz_aufnahme" hidden="" type="text">
									<input form="ampelForm_<?php echo($_rnd); ?>" id="ampelSubmit_<?php echo($_rnd); ?>" hidden="" type="submit"></form>
								<label for="ampelSubmit_<?php echo($_rnd); ?>"><i class="fas fa-address-card"></i></label>
							</td>							
						</tr>
						<?php
					}
				}
				?>
					</table>
				</div>
				<?php 
				break;
		}
		?>
		<br /	>
		<br />
	<?php
	}
	?>
	</div>
	<?php
}

function printDB(array $PARAM, mysqli $conn) 
{
	$rnd = rand(0,32768);
	updateTime();
	?>
	<h2>Dienstbesprechung als ODS erzeugen</h2>
	<form class="db_options" method="POST" action="" onsubmit="callFunction(this,'createDB','DBforprint<?php echo($rnd); ?>'); return false;">
		<div class="edit_wrapper">
			<label class="date" for="db_<?php echo($key.$rnd); ?>">Datum der DB</label>
			<input name="datumdb" id="datumdb_<?php echo($rnd); ?>" type="date" required value="<?php echo(date('Y-m-d')); ?>" />
			<input name="rnd" type="number" value="<?php echo($rnd);?>" hidden>
			<input id="DB_submit_<?php echo($rnd); ?>" type="submit" hidden>
			<div class="clear"></div>
		</div>
		<div class="edit_wrapper">
			<label for="DB_submit_<?php echo($rnd); ?>"><i class="fas fa-arrow-right"></i></label>
			<div class="clear"></div>
		</div>
	</form>
	<div id="DBforprint<?php echo($rnd); ?>"></div>
	<?php
}

function exportRefuKey($PARAM, mysqli $conn)
{
// $PARAM is the mass edit array
	if ( isset($PARAM['trash']) ) { 
		$_array = json_decode($PARAM['trash'],true);
	} else {
		$_array = $PARAM;
	}
	if ( ! isset($_array['massEdit']) ) { return; }
	//write header
	?>
	<h3>refuKey-Export</h3>
	<p>Fenster bitte nach dem Herunterladen schließen</p>
	<?php
	//get the ids of opsz_aufnahme
	$_exported_ids = array ();
	foreach( $_array['massEdit'] as $_idcollection ) {
		$_idarray = json_decode($_idcollection,true);
		if ( is_array($_idarray) AND isset($_idarray['id_opsz_aufnahme']) AND ! in_array($_idarray['id_opsz_aufnahme'],$_exported_ids) ) {
			array_push($_exported_ids,$_idarray['id_opsz_aufnahme']);
		}
	}
	$_exported_ids_string = '('.implode(',',$_exported_ids).')';
	unset($_stmt_array); $_stmt_array = array();
	//get the data from the database
	$_stmt_array['stmt'] = "select tablemachine from os_tables where tablereadable LIKE '%refuKey%'";
	$refukeytable = execute_stmt($_stmt_array,$conn)['result']['tablemachine'][0];
	unset($_stmt_array); $_stmt_array = array();
	$_stmt_array['stmt'] = 'select view__'.$refukeytable.'__'.$_SESSION['os_role'].'.code as code, fallnummerklinik as evalcode, erstkontaktrefukey, geschlecht, DATEDIFF(aufnahmedatum,geburtsdatum) AS age, begleitet, aufenthaltorig, indeutschlandseit, _gesundheitorig, familiehier, herkunft, minderheit, muttersprache, landkreisregion as landkreis, ueberleitung, ueberleitungnach, krankenhausaufenthalt, krankenhausaufenthaltdetails, anfragevon, symptome, diagnoseexternkombi, angebot, anmerkungen, dropout FROM view__opsz_aufnahme__'.$_SESSION['os_role'].' LEFT JOIN view__'.$refukeytable.'__'.$_SESSION['os_role'].' USING (id_opsz_aufnahme) WHERE id_opsz_aufnahme in '.$_exported_ids_string.' ORDER BY evalcode,code';
	$_export_rawdata = execute_stmt($_stmt_array,$conn,true)['result']; //first index: number, second index: key
	function _rewrite(string $xml, string $column, array $row) {
		$replaceby = str_replace('*','',$row[strtolower($column)]);
		//to be continued
		switch($column) {
			case 'CODE':
				break;
			case 'EVALCODE':
				if ( $row['evalcode'] == '' ) { $replaceby = $row['code']; }
				break;
			case 'ERSTKONTAKTREFUKEY':
				break;
			case 'DERIV_GESCHLECHT_VULNERABILITAET':
				switch($row['geschlecht']) {
					case 'männlich':
						$replaceby = 'm';
						break;
					case 'weiblich':
						$replaceby = 'w';
						break;
					case 'divers':
						$replaceby = 'd';
						break;
				}
				if ( $row['age'] > 18*365+5 ) { $replaceby .= 'E'; } else { $replaceby .= 'M'; }
				if ( $row['begleitet'] == "unbegleitet" ) { $replaceby .= 'u'; }
				break;
			case 'AUFENTHALTORIG':
				break;
			case 'INDEUTSCHLANDSEIT':
				break;
			case 'DERIV__GESUNDHEITORIG':
				switch($row['_gesundheitorig']) {
					case '*zu klären':
						$replaceby = "Z";
						break;
					case 'Sozialamt':
						$replaceby = "SO";
						break;
					case 'Krankenkasse':
						$replaceby = "KK";
						break;
					case 'Krankenkasse über Sozialamt':
						$replaceby = "SM";
						break;
					case 'keine':
						$replaceby = "KL";
						break;
				}
				break;
			case 'FAMILIEHIER':
				break;
			case 'DERIV_HERKUNFT_MINDERHEIT':
				$replaceby = $row['herkunft'].', '.$row['minderheit'];
				break;
			case 'MUTTERSPRACHE':
				break;
			case 'LANDKREIS':
				break;
			case 'UEBERLEITUNG':
				if ( $row['ueberleitung'] == "*nein" OR $row['ueberleitung'] == "" ) { $replaceby = "nein"; }
				break;
			case 'UEBERLEITUNGNACH':
				if ( $row['ueberleitungnach'] == "*nein" OR $row['ueberleitungnach'] == "" ) { $replaceby = "nein"; }
				break;
			case 'DERIV_KRANKENHAUSAUFENTHALTDETAILS':
				if ( $row['krankenhausaufenthalt'] != "ja" ) { $replaceby = "nein"; break; }
				$_aufenthalte = json_decode($row['krankenhausaufenthaltdetails']);
				$komma = '';
				for ( $i = 0; $i < sizeof($_aufenthalte[0]); $i++ ) {
					$replaceby .= $komma.$_aufenthalte[0][$i].': '._cleanup($_aufenthalte[1][$i]).' - '._cleanup($_aufenthalte[2][$i]); $komma = ', ';
				}
				break;
			case 'ANFRAGEVON':
				break;
			//html_entitiy_decode included in the next two sections for backward compatibility: old entries may contain &ouml; etc which are invalid in XML
			case 'SYMPTOME':
				$replaceby = strip_tags(_cleanup(html_entity_decode($row['symptome'],ENT_HTML5)));
				break;
			case 'ANMERKUNGEN':
				$replaceby = strip_tags(_cleanup(html_entity_decode($row['anmerkungen'],ENT_HTML5)));
				break;
			case 'DERIV_DIAGNOSEEXTERNKOMBI':
				$_diagnose = json_decode(str_replace('*','',$row['diagnoseexternkombi']));
				$komma = '';
				for ( $i = 0; $i < sizeof($_diagnose[0]); $i++ ) {
					$_add = '';
					if ( $_diagnose[1][$i] == "Verdachtsdiagnose" ) { $_add = 'V'; }
					if ( $_diagnose[1][$i] == "Gesicherte Diagnose" ) { $_add = 'S'; }
					$replaceby .= $komma.substr($_diagnose[0][$i],0,strpos($_diagnose[0][$i],' ')).' '.$_add;
					$komma = ', ';
				}
				break;
			case 'DERIV_ANGEBOT':
				$angebote = json_decode($row['angebot'],true);
				$komma = '';
				foreach ($angebote as $angebot) {
					$replaceby = substr($angebot,0,11);
					switch(substr($row['angebot'],0,11)) {
						case 'Einzelgespr':
							$replaceby .= $komma.'Einzel';
							$komma = ', ';
							break;
						case 'Gruppenange':
							$replaceby .= $komma.'Gruppe';
							$komma = ', ';
							break;
						case 'ambulant be':
							$replaceby .= $komma.'Sonstiges';
							$komma = ', ';
							break;
						case 'Projekt ASU':
							$replaceby = $komma.'Sonstiges';
							$komma = ', ';
							break;
					}
			}
				break;
			case 'ANMERKIUNGEN':
				break;
			case 'DROPOUT':
				break;
		}
		$replaceby = htmlentities(_cleanup($replaceby),ENT_XML1); //only this step ensures that the ODS date are XML1-compliant!
		$_return = str_replace('%'.$column.'%',$replaceby,$xml);
		return $_return;
	}
	$workdir = '../../core/xml/exportRefuKey/';
	//remove line breaks from files, this makes it unreadable in the end...
	$file_header = fopen($workdir.'exportRefuKey_content_header.xml','r');
	$xml_header = fread($file_header,filesize($workdir.'exportRefuKey_content_header.xml'));
	fclose($file_header);
	$file_row = fopen($workdir.'exportRefuKey_content_row.xml','r');
	$xml_row = fread($file_row,filesize($workdir.'exportRefuKey_content_row.xml'));
	fclose($file_row);
	$file_footer = fopen($workdir.'exportRefuKey_content_footer.xml','r');
	$xml_footer = fread($file_footer,filesize($workdir.'exportRefuKey_content_footer.xml'));
	fclose($file_footer);
	preg_match_all("/%([A-Z_]*)%/",$xml_row,$placeholders);
	$columns = $placeholders[1]; //takes the first bracket of the match
	$_export_xml = $xml_header;
	foreach ( $_export_rawdata as $index => $row ) {
		$thisxml = str_replace('%ROWNUMBER%',$index,$xml_row);
		foreach ( $columns as $column ) {
			$thisxml = _rewrite($thisxml,$column,$row);
		}
		$_export_xml .= $thisxml;
	}
	$_export_xml .= $xml_footer;
	$zip = new ZipArchive;
	$fileToModify = 'content.xml';
	$now = date('Y-m-d_His');
	try { copy($workdir.'exportRefuKey-Vorlage.ods','/tmp/exportRefuKey-'.$now.'.ods'); } catch (Throwable $e) { echo "Captured Throwable: " . $e->getMessage() . PHP_EOL; }

	if ($zip->open('/tmp/exportRefuKey-'.$now.'.ods') === TRUE) {
		//Delete the old...
		$zip->deleteName($fileToModify);
		//Write the new...
		$zip->addFromString($fileToModify, $_export_xml);
		//And write back to the filesystem.
		$zip->close();
		$export_file = fopen('/tmp/exportRefuKey-'.$now.'.ods','r');
		$export_ods = base64_encode(fread($export_file,filesize('/tmp/exportRefuKey-'.$now.'.ods')));
		fclose($export_file);
		unlink('/tmp/exportRefuKey-'.$now.'.ods');
		$filename = 'exportRefuKey-'.$now.'.ods';
		?>
 		<div class="download">
			<label>&nbsp;</label>
			<i class="fas fa-file-download"></i>&nbsp;&nbsp;<a href="data:application/vnd.oasis.opendocument.spreadsheet;charset=utf-8;base64,<?php echo($export_ods); ?>" target="_blank" download="<?php echo($filename); ?>"><?php echo($filename); ?> (ODS)</a>
		</div>
		<?php
	} else {
		echo 'Beim Erzeugen der ODS ist ein Fehler aufgetreten';
	}
}

function createDB(array $PARAM, mysqli $conn)
{
	//remove old DBs
	foreach (glob("../DB-*.ods") as $filename) {
		unlink($filename);
	}
    //
	$rnd = $PARAM['rnd'];
	unset($_stmt_array); $_stmt_array = array(); unset($_table_result);
	$_stmt_array['stmt'] = 'SELECT  id_opsz_aufnahme, einschaetzung, vorschlag, akten from view__opsz_db__'.$_SESSION['os_role'].' WHERE id_opsz_aufnahme IS NOT NULL AND dbdatum LIKE CONCAT(\'%\',?,\'%\')';
	$_stmt_array['str_types'] = 's';
	$_stmt_array['arr_values'] = array($PARAM['datumdb']);
	$_table_result = execute_stmt($_stmt_array,$conn,true)['result'];
	if ( ! isset($_table_result) OR sizeof($_table_result) == 0 ) { echo("<label>&nbsp;</label>Zu dem gewählten Datum gibt es keine Einträge."); return; }
	unset($_index); unset($_db_item);
	unset($_stmt_array); $_stmt_array = array(); unset($_displayforeign);
	$_stmt_array['stmt'] = 'SELECT displayforeign from os_tables WHERE tablemachine = ?';
	$_stmt_array['str_types'] = 's';
	$_stmt_array['arr_values'] = array('opsz_db');
	$_displayforeign = execute_stmt($_stmt_array,$conn)['result']['displayforeign'][0];
	//get foreign key values
	$foreign_array = json_decode($_displayforeign, true);
	$foreignkeys_array = array();
	if ( is_array($foreign_array) ) {
		foreach ( $foreign_array  as $foreign )
		{
			$ftable = explode('__',$foreign,2)[0];
			$fkey = explode('__',$foreign,2)[1];
			$foreignkeys_array[$ftable][] = $fkey;
		}
	}
	$_table_result_foreign = array();
	foreach ( $_table_result as $_index=>$_db_item )
	{
		$_table_result_foreign[] = array();
		foreach ( $foreignkeys_array['opsz_aufnahme'] as $fkey ) {
			unset($_stmt_array); $_stmt_array = array();
			$_stmt_array['stmt'] = 'SELECT `'.$fkey.'` from `view__' . 'opsz_aufnahme' . '__' . $_SESSION['os_role'].'` WHERE id_opsz_aufnahme = ?';
			$_stmt_array['str_types'] = 'i';
			$_stmt_array['arr_values'] = array($_db_item['id_opsz_aufnahme']);
			$_table_result_foreign[$_index][$fkey] = _cleanup(execute_stmt($_stmt_array,$conn)['result'][$fkey][0]);
		}
	}
	//sort by 'verantwortlich'
	$_clients = array();
	for ( $i = 0; $i < sizeof($_table_result); $i++ )
	{
		$_clients[$_table_result_foreign[$i]['verantwortlich']][] = $i;
	}
	ksort($_clients);
	//now create the table from these data...
	$workdir = '../../core/xml/';
	$pageheight = 0; $pagelimit = 158; //available height of landscape A4 in mm
	$_seite1_xml = fopen($workdir.'DB-Seite1.xml','r');
	$tmp_seite1_xml = fread($_seite1_xml,filesize($workdir.'DB-Seite1.xml'));
	$tmp_seite1_xml = str_replace('DB vom:','DB vom: '.DateTime::createFromFormat('Y-m-d',$PARAM['datumdb'])->format('d.m.Y'),$tmp_seite1_xml);
	$_content_xml_content = $tmp_seite1_xml;
	fclose($_seite1_xml);
	$_verantwortlich_xml = fopen($workdir.'DB-Verantwortlich.xml','r');
	$_verantwortlich_xml_content = fread($_verantwortlich_xml,filesize($workdir.'DB-Verantwortlich.xml'));
	fclose($_verantwortlich_xml);
	$_pagebreak_xml = fopen($workdir.'DB-pagebreak.xml','r');
	$_pagebreak_xml_content = fread($_pagebreak_xml,filesize($workdir.'DB-pagebreak.xml'));
	fclose($_pagebreak_xml);
	$_eintrag_xml = fopen($workdir.'DB-Eintrag.xml','r');
	$_eintrag_xml_content = fread($_eintrag_xml,filesize($workdir.'DB-Eintrag.xml'));
	fclose($_eintrag_xml);
	$_letzteSeite_xml = fopen($workdir.'DB-letzteSeite.xml','r');
	$_letzteSeite_xml_content = fread($_letzteSeite_xml,filesize($workdir.'DB-letzteSeite.xml'));
	fclose($_letzteSeite_xml);
	foreach ( $_clients as $verantwortlich=>$_ids )
	{
		$tmp_verantwortlich_xml = str_replace('%VERANTWORTLICH%', _cleanup($verantwortlich), $_verantwortlich_xml_content);
		$pageheight += 6; if ( $pageheight > 158 ) { $_content_xml_content .= $_pagebreak_xml_content; $pageheight = 12; }
		$_content_xml_content .= $tmp_verantwortlich_xml;
		foreach ( $_ids as $id )
		{
			$tmp_eintrag_xml = str_replace('%NAME%', $_table_result_foreign[$id]['name'].', '.$_table_result_foreign[$id]['vorname'], $_eintrag_xml_content);
			$tmp_eintrag_xml = str_replace('%HERKUNFT%', $_table_result_foreign[$id]['herkunft'], $tmp_eintrag_xml);
			//to be repaired: DateTimeInterface instead of string... DateTime::createFromFormat('Y-m-d H:i:s', $datetime)->format('d.m.Y H:i') o.ä.
			$_geb_datum = DateTime::createFromFormat('d.m.Y', $_table_result_foreign[$id]['geburtsdatum']);
			$_now = DateTime::createFromFormat('Y-m-d', date('Y-m-d'));
			$tmp_eintrag_xml = str_replace('%ALTER%', date_diff($_geb_datum,$_now)->format('%y'), $tmp_eintrag_xml);
			$tmp_eintrag_xml = str_replace('%WOHNORT%', $_table_result_foreign[$id]['landkreisregion'], $tmp_eintrag_xml);
			$tmp_eintrag_xml = str_replace('%DIAGNOSEDRITTER%', $_table_result_foreign[$id]['diagnose'], $tmp_eintrag_xml);
			$tmp_eintrag_xml = str_replace('%EINSCHÄTZUNG%', _cleanup($_table_result[$id]['einschaetzung']), $tmp_eintrag_xml);
			$tmp_eintrag_xml = str_replace('%VORSCHLAG%', _cleanup($_table_result[$id]['vorschlag']), $tmp_eintrag_xml);
			$tmp_eintrag_xml = str_replace('%AKTEN%', _cleanup($_table_result[$id]['akten']), $tmp_eintrag_xml);
			$pageheight += 20; if ( $pageheight > 158 ) { $_content_xml_content .= $_pagebreak_xml_content; $pageheight = 26; }
			$_content_xml_content .= $tmp_eintrag_xml;
		}
	}
	$_content_xml_content .= $_letzteSeite_xml_content;
	$zip = new ZipArchive;
	$fileToModify = 'content.xml';
	copy($workdir.'DB-Vorlage.ods','../DB-'.$PARAM['datumdb'].'.ods');
	if ($zip->open('../DB-'.$PARAM['datumdb'].'.ods') === TRUE) {
		//Delete the old...
		$zip->deleteName($fileToModify);
		//Write the new...
		$zip->addFromString($fileToModify, $_content_xml_content);
		//And write back to the filesystem.
		$zip->close();
		?>
		<div class="download">
			<label>&nbsp;</label>
			<i class="fas fa-file-download"></i>&nbsp;&nbsp;<a href="DB-<?php  echo($PARAM['datumdb']); ?>.ods" target="_blank">Dienstbesprechung vom <?php echo(DateTime::createFromFormat('Y-m-d',$PARAM['datumdb'])->format('d.m.Y')); ?> (ODS)</a>
		</div>
		<?php
	} else {
		echo 'Beim Erzeugen der ODS ist ein Fehler aufgetreten';
	}
}

//subfunctions of createDolmiInvoice
// dependencies: php7.3-zip? Not for HTML version
function localFormat($number) { return number_format((float)$number,2,",","."); }
//function inTegers($number) { return number_format((float)$number,0,",","."); }
function inCents($number) { return round((float)$number,2); }
function inTegers($number) { return round((float)$number); }

//scope: DETAILS
function createDolmiInvoice(array $PARAM, mysqli $conn)
{
	//determine intended invoice
	$PARAM2 = json_decode(json_encode($PARAM),true);
	foreach ( $PARAM as $key=>$value) {
		if ( isset($PARAM2['id_opsz_dolmetscherrechnung']) AND $PARAM2['id_opsz_dolmetscherrechnung'] != '' ) { break; };
		if ( substr($key,0,3) != 'id_' ) { continue; }
		$_giventable = substr($key,3);
		unset($_stmt_array); $_stmt_array = array();
		$_stmt_array['stmt'] = 'SELECT id_opsz_dolmetscherrechnung from view__'.$_giventable.'__'.$_SESSION['os_role'].' WHERE id_'.$_giventable.' = ?';
		$_stmt_array['str_types'] = 'i';
		$_stmt_array['arr_values'] = array($value);
		$PARAM2 = execute_stmt($_stmt_array,$conn,true)['result'][0];
		$PARAM2[$key] = $value; //do not forget where we came from
	}	
	$PARAM = json_decode(json_encode($PARAM2),true);
	if ( ! isset($PARAM['id_opsz_dolmetscherrechnung']) OR $PARAM['id_opsz_dolmetscherrechnung'] == '' ) {
		echo("<label><i class=\"fas fa-exclamation-triangle\"></i></label>Der Eintrag ist keiner Rechnung zugeordnet."); return; 
	}
	//get invoice data
	unset($_stmt_array); $_stmt_array = array(); unset($_table_result);
	$_stmt_array['stmt'] = 'SELECT name AS dlmrgname,vorname AS dlmrgvorname,geburtsdatum AS dlmrggeb,vermittlungsauftrag AS dlmrgtype, view__opsz_dolmetscherrechnung__'.$_SESSION['os_role'].'.* from view__opsz_dolmetscherrechnung__'.$_SESSION['os_role'].' LEFT JOIN view__opsz_vermittlungslisten__'.$_SESSION['os_role'].' USING (id_opsz_vermittlungslisten) LEFT JOIN view__opsz_aufnahme__'.$_SESSION['os_role'].' ON view__opsz_vermittlungslisten__'.$_SESSION['os_role'].'.id_opsz_aufnahme = view__opsz_aufnahme__'.$_SESSION['os_role'].'.id_opsz_aufnahme WHERE view__opsz_dolmetscherrechnung__'.$_SESSION['os_role'].'.id_opsz_dolmetscherrechnung = ?';
	$_stmt_array['str_types'] = 'i';
	$_stmt_array['arr_values'] = array($PARAM['id_opsz_dolmetscherrechnung']);
	$PARAMETER = execute_stmt($_stmt_array,$conn,true)['result'][0];
	//$PARAMETER is invoice parameters
	//header
	//get attributed client
	unset($_stmt_array); $_stmt_array = array(); unset($_table_result);
	$_stmt_array['stmt'] = 'SELECT * from view__opsz_aufnahme__'.$_SESSION['os_role'].' WHERE id_opsz_aufnahme = ?';
	$_stmt_array['str_types'] = 'i';
	$_stmt_array['arr_values'] = array($PARAMETER['id_opsz_aufnahme']);
	$_customer_result = execute_stmt($_stmt_array,$conn,true)['result'][0];
	if ( ! isset($_customer_result) OR sizeof($_customer_result) == 0 ) { echo("<label><i class=\"fas fa-exclamation-triangle\"></i></label>Die Rechnung ist keiner KlientIn zugeordnet."); return; }
	//set attributions if necessary
	//do not change already set attributions even if they match the criteria
	if ( isset($PARAMETER['dlmrgfilter']) ) {
		$_filter = json_decode($PARAMETER['dlmrgfilter'],true);
		//$_filter must have three components
		if ( is_array($_filter) AND sizeof($_filter) == 3 AND sizeof($_filter[0]) > 0 ) {
			$_length = sizeof($_filter[0]);
			for ( $_filterindex = 0; $_filterindex < $_length; $_filterindex++ ) {
				$PARAMETER['dlmrgbei'] = $_filter[0][$_filterindex];
				$PARAMETER['dlmrgbeginn'] = $_filter[1][$_filterindex];
				$PARAMETER['dlmrgend'] = $_filter[2][$_filterindex];
				unset($_stmt_array); $_stmt_array = array(); unset($_table_result);
				$_stmt_array['stmt'] = 'SELECT view__opsz_dolmetschereinsatz__'.$_SESSION['os_role'].'.id_opsz_dolmetschereinsatz from view__opsz_dolmetschereinsatz__'.$_SESSION['os_role'].' LEFT JOIN view__opsz_termine__'.$_SESSION['os_role'].' USING (id_opsz_termine) WHERE view__opsz_dolmetschereinsatz__'.$_SESSION['os_role'].'.id_opsz_dolmetscherrechnung IS NULL AND view__opsz_termine__'.$_SESSION['os_role'].'.id_opsz_vermittlungslisten = ?'; //collect all matching a certain vermittlungsliste!
				$_stmt_array['str_types'] = 'i';
				$_stmt_array['arr_values'] = array($PARAMETER['id_opsz_vermittlungslisten']);
				if ( isset($PARAMETER['dlmrgbei']) AND $PARAMETER['dlmrgbei'] != '' ) {
					$_stmt_array['stmt'] .= ' AND view__opsz_termine__'.$_SESSION['os_role'].'.bei = ?';
					$_stmt_array['str_types'] .= 's';
					$_stmt_array['arr_values'][] = $PARAMETER['dlmrgbei'];
				}
				if ( isset($PARAMETER['dlmrgbeginn']) AND $PARAMETER['dlmrgbeginn'] != '' ) {
					$_stmt_array['stmt'] .= ' AND view__opsz_termine__'.$_SESSION['os_role'].'.beginn >= ?';
					$_stmt_array['str_types'] .= 's';
					$_stmt_array['arr_values'][] = $PARAMETER['dlmrgbeginn'];
				}
				//are these tests (above and below) ok (date cp to datetime and format may be wrong...)?
				if ( isset($PARAMETER['dlmrgend']) AND $PARAMETER['dlmrgend'] != '' ) {
					$_stmt_array['stmt'] .= ' AND view__opsz_termine__'.$_SESSION['os_role'].'.ende <= ?';
					$_stmt_array['str_types'] .= 's';
					$_stmt_array['arr_values'][] = $PARAMETER['dlmrgend'];
				}
				$_stmt_array['stmt'] = 'UPDATE view__opsz_dolmetschereinsatz__'.$_SESSION['os_role'].' SET id_opsz_dolmetscherrechnung = '.$PARAMETER['id_opsz_dolmetscherrechnung'].' WHERE id_opsz_dolmetschereinsatz in ('.$_stmt_array['stmt'].')';
				_execute_stmt($_stmt_array,$conn);
			}
			unset($PARAMETER['dlmrgbei']); unset($PARAMETER['dlmrgbeginn']); unset($PARAMETER['dlmrgend']);
		}
	}
	//get attributed processes
	unset($_stmt_array); $_stmt_array = array(); unset($_table_result);
	$_stmt_array['stmt'] = 'SELECT view__opsz_dolmetschereinsatz__'.$_SESSION['os_role'].'.id_opsz_dolmetschereinsatz AS id_opsz_dolmetschereinsatz, UNIX_TIMESTAMP(beginn) AS processunixbegin, UNIX_TIMESTAMP(ende) AS processunixend, bei as processbei, dolmibrutto as processbrutto, dolminetto as processnetto, dolmiordernrextern as processnr from view__opsz_dolmetschereinsatz__'.$_SESSION['os_role'].' LEFT JOIN view__opsz_termine__'.$_SESSION['os_role'].' USING (id_opsz_termine) WHERE view__opsz_dolmetschereinsatz__'.$_SESSION['os_role'].'.id_opsz_dolmetscherrechnung = ? ORDER BY beginn';
	$_stmt_array['str_types'] = 'i';
	$_stmt_array['arr_values'] = array($PARAMETER['id_opsz_dolmetscherrechnung']);
	$_processes_result = execute_stmt($_stmt_array,$conn,true)['result'];
	if ( ! isset($_processes_result) OR sizeof($_processes_result) == 0 ) { echo("<label><i class=\"fas fa-exclamation-triangle\"></i></label>Zu der gewählten Rechnung gibt es keine Einsätze."); return; }
	//now get config
	$_config = getFunctionConfig('createDolmiInvoice',$conn);
	//
	$_totalgross = array();
	$_totalnet = array();
	$_earliest = 9999999999;
	$_latest = 0;
	$_oldtype = '';
	$_processtable='';
	$_totalgrossamount = 0;
	$_totalnetamount = 0;
	$_currentheight = 100.0;
	$_nopages = 1;
	$_em = array(); $_slashem = array(); $_marked = array();
	$_bei = array();
	foreach ( $_processes_result as $index=>$_process ) {
		if ( ! isset($_process['processbei']) OR ! isset($_process['processunixbegin']) OR ! isset($_process['processunixend']) OR $_process['processbei'] == '' OR $_process['processunixbegin'] == '' OR $_process['processunixend'] == '' ) {
			echo("<label><i class=\"fas fa-exclamation-triangle\"></i></label>Bei mindestens einem Termin eines Dolmetschereinsatzes fehlen Angaben."); return; 
		}
		$_bei[] = $_process['processbei'];
		$_bei = array_unique($_bei);
		$_earliest = min($_earliest,$_process['processunixbegin']);
		$_latest = max($_latest,$_process['processunixend']);
		//collect and sort info
		$_em[$index] = ''; $_slashem[$index] = '';
		if ( $_process['id_opsz_dolmetschereinsatz'] == $PARAM['id_opsz_dolmetschereinsatz'] ) { $_em[$index] = '<span class="marked">'; $_slashem[$index] = '</span>'; };
		$_totalgrossamount += inCents($_process['processbrutto']);
		$_totalnetamount += inCents($_process['processnetto']);
		//count one line per process
		$_nolines = 1;
		$_currentheight += $_nolines*4.6;
		//check if we need new page
		if ( $_currentheight > 260) { 
			$_nopages += 1;
			$_processtable .= "
					</table>
				</div>
				<div class=\"invoice_page\">
					<div class=\"invoicepagenumber\">".$_nopages."</div>	
					<table>
						<thead>
							<tr><th>Auftragsnummer</th><th>Einsatzdatum und -uhrzeit</th><th>Enstandene Kosten in €</th></tr>
						</thead>
			";
			$_currentheight = 5+$_nolines*4.6;
		}
		//add to table
		$_marked[$index] = '';
		if ( $_process['id_opsz_dolmetschereinsatz'] == $PARAM['id_opsz_dolmetschereinsatz'] ) { $_marked[$index] = 'marked'; };
		$_processtable .= '<tr class="'.$_marked[$index].'"><td>'.$_process['processnr'].'</td><td>'.(new DateTime())::createFromFormat('U',$_process['processunixbegin'])->format('d.m.Y H:i').'</td><td>'.localFormat(inCents($_process['processbrutto'])).'</td></tr>';
	}
	if ( $_currentheight > 230) { 
		$_nopages += 1;
		$_processtable .= "
				</table>
			</div>
			<div class=\"invoice_page\">
				<div class=\"invoicepagenumber\">".$_nopages."</div>	
				<table>
					<thead>
						<tr><th>Auftragsnummer</th><th>Einsatzdatum und -uhrzeit</th><th>Enstandene Kosten in €</th></tr>
					</thead>
		";
		$_currentheight = 5+$_nolines*4.6;
	}
	$_processtable .= '<tr><th>&nbsp;</th><th>Summe</th><th>'.localFormat(inCents($_totalgrossamount)).'</th></tr>';
	//test if inovice has already been finished and changed
	$_copy = '';
	if ( $PARAMETER['dlmrggenerated'] == "ja" ) {
		if ( $PARAMETER['dlmrgbrutto'] != (string)inCents($_totalgrossamount) OR $PARAMETER['dlmrgmwst'] != (string)(inCents($_totalgrossamount)-inCents($_totalnetamount)) ) {
			echo("<label><i class=\"fas fa-exclamation-triangle\"></i></label>Die Rechnung wurde nach Erstellung geändert. Wenn die Änderungen legitim sind, ändere den Status der Rechnung auf unerstellt und erstelle sie erneut."); return; 
		} else {
			$_copy = " - Kopie";
		}
	} else {
		//get number of invoices of this bearbeiterinnr and this year
		unset($_stmt_array); $_stmt_array = array(); 
		$_stmt_array['stmt'] = "SELECT COUNT(id_opsz_dolmetscherrechnung) AS rgnr FROM view__opsz_dolmetscherrechnung__".$_SESSION['os_role']." WHERE dlmrgstaffnr = ? AND YEAR(dlmrgdatum) = ? AND id_opsz_dolmetscherrechnung <= ?";
		$_stmt_array['str_types'] = 'isi';
		$_stmt_array['arr_values'] = array($PARAMETER['dlmrgstaffnr']);
		$_stmt_array['arr_values'][] = (new DateTime($PARAMETER['dlmrgdatum']))->format('Y');
		$_stmt_array['arr_values'][] = $PARAMETER['id_opsz_dolmetscherrechnung'];
		$_rgnr = execute_stmt($_stmt_array,$conn)['result']['rgnr'][0];
		$PARAMETER['dlmrgnr'] = (new DateTime($PARAMETER['dlmrgdatum']))->format('Y').'/'.$PARAMETER['dlmrgstaffnr'].'/'.$_rgnr;
		unset($_stmt_array); $_stmt_array = array(); unset($_table_result);
		$_stmt_array['stmt'] = "UPDATE view__opsz_dolmetscherrechnung__".$_SESSION['os_role']." SET dlmrggenerated='ja', dlmrgnr=?, dlmrgbrutto=?, dlmrgnetto=?, dlmrgmwst=? WHERE id_opsz_dolmetscherrechnung = ?";
		$_stmt_array['str_types'] = 'ssssi';
		$_stmt_array['arr_values'] = array();
		$_stmt_array['arr_values'][] = (string)$PARAMETER['dlmrgnr'];
		$_stmt_array['arr_values'][] = (string)inCents($_totalgrossamount);
		$_stmt_array['arr_values'][] = (string)inCents($_totalnetamount);
		$_stmt_array['arr_values'][] = (string)(inCents($_totalgrossamount)-inCents($_totalnetamount));
		$_stmt_array['arr_values'][] = $PARAMETER['id_opsz_dolmetscherrechnung'];
		_execute_stmt($_stmt_array,$conn);
	}
	//get (first) active id
	unset($_stmt_array); $_stmt_array = array(); unset($_table_result);
	$_myid = $_config['id'];	
	?>
	<link rel="stylesheet" type="text/css" href="/css/opsz_invoice.css">
	<?php includeFunctions('DETAILS',$conn); ?>	
	<form class="db_options function" method="POST" action="" onsubmit="callFunction(this,'dbAction','message'); return false;">
		<input type="text" hidden value="<?php html_echo($PARAMETER['id_opsz_dolmetscherrechnung']); ?>" name="id_opsz_dolmetscherrechnung" class="inputid" />
		<input type="text" hidden value="::PORTRAIT" name="_scope_"/>
	</form>
	<div class="invoice_wrapper">
		<div class="invoiceheader">
			<div class="invoicecc"></div>
			<div class="invoiceaddress">
				<div class="myidentity"><?php html_echo($_config['id']); ?></div>
				<div class="invoicerecipient"><?php echo(preg_replace('/\r*\n/','<br />',$PARAMETER['dlmrgaddr'])); ?></div>
			</div>
			<div class="invoicedata">
				<table>
				<tr><td>Rechnungsnummer</td><td><?php echo($PARAMETER['dlmrgnr']); ?></td></tr>
				<tr><td>Datum</td><td><?php echo((new DateTime($PARAMETER['dlmrgdatum']))->format('d.m.Y')); ?></td></tr>
				<tr><td>Seite</td><td>1/<?php echo($_nopages); ?></td></tr>
				</table>
			</div>
		</div> <!-- end of invoiceheader -->
		<h2>Rechnung<?php echo($_copy.' '.$PARAMETER['dlmrgnr']); ?></h2>
		<h2>Dolmetscherkosten für <?php html_echo(str_replace('vermittlung','',$PARAMETER['dlmrgtype'])); ?>-Termine bei <?php html_echo(implode(', ',$_bei)); ?></h2>
		<h4><?php html_echo($PARAMETER['dlmrgname'].', '.$PARAMETER['dlmrgvorname'].', geb. '.(new DateTime($PARAMETER['dlmrggeb']))->format('d.m.Y')); ?></h4>
		<h4><?php html_echo($PARAMETER['dlmrgclientextern']); ?></h4>
		<p><?php echo(preg_replace('/\r*\n/','<br />',$_config['pretext'])); ?></p>
		<table>
			<thead>
				<tr><th>Auftragsnummer</th><th>Einsatzdatum und -uhrzeit</th><th>Enstandene Kosten in €</th></tr>
			</thead>
			<?php echo($_processtable); ?>
		</table>
		<div><?php html_echo($PARAMETER['dlmrgtext']); ?></div>
		<div>Bitte überweisen Sie den Rechnungsbetrag von <strong><?php echo(localFormat(inCents($_totalgrossamount))); ?> €</strong> auf unser Konto
			<p>
			IBAN <?php html_echo($_config['bank']['iban']); ?><br />
			BIC <?php html_echo($_config['bank']['bic']); ?><br />
			<?php html_echo($_config['bank']['name']); ?><br />
			</p>
			 Als Verwendungszweck geben Sie bitte <strong><?php html_echo($PARAMETER['dlmrgnr']); ?></strong> an.
		</div>
	</div> <!-- end of invoice_wrapper -->
<?php }

?>
