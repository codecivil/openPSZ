<?php
function trafficLight(array $PARAM,mysqli $conn)
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
							<td><?php html_echo($_result['name']); ?></td>
							<td><?php html_echo($_result['vorname']); ?></td>
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
							<td><?php html_echo($_result['name']); ?></td>
							<td><?php html_echo($_result['vorname']); ?></td>
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
							<td><?php html_echo($_result['name']); ?></td>
							<td><?php html_echo($_result['vorname']); ?></td>
							<td><?php html_echo($_result['listentyp']); ?></td>
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
?>
