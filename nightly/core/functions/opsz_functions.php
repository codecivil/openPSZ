<?php
function substr_in_array($needle, array $haystack)
{
	//by Colin DeCarlo from https://akrabat.com/substr_in_array/
    return array_reduce($haystack, function ($inArray, $item) use ($needle) {
        return $inArray || false !== strpos($item, $needle);
    }, false);
}

function trafficLight(array $PARAM, mysqli $conn)
{
	$tables = $PARAM['table'];
	
	unset($_stmt_array); $_stmt_array = array();
	$_stmt_array['stmt'] = "SELECT functionconfig from os_functions where functionmachine = 'trafficLight'";
	$_config = json_decode(execute_stmt($_stmt_array,$conn,true)['result'][0]['functionconfig'],true);
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
	foreach ( $tables as $table ) {
		$ids = array(); $resultin = array(); $_param = array();
		foreach ( $_config['criteria'] as $criterion ){
			if ($criterion['table'] == $table ) { 
				$resultout_array = _parseCriterion($resultin,$_param,$criterion,$conn);
				$resultout = $resultout_array[0];
				$_param = $resultout_array[1];
				foreach ( $resultout as $id ) {
					$_criteriondetail = ''; if ( isset($_param['id'.$id]) ) { $_criteriondetail = ": ".$_param['id'.$id]; }
					if ( ! array_key_exists($id,$ids) ) { $ids[$id] = array(); $ids[$id]['urgency'] = 0; $ids[$id]['criteria'] = array(); }
					if ( $criterion['urgency'] == "+" ) { $ids[$id]['urgency'] += 1; }
					if ( $criterion['urgency'] == "-" ) { $ids[$id]['urgency'] -= 1; }
					if ( is_int($criterion['urgency']) ) { $ids[$id]['urgency'] = max($ids[$id]['urgency'],$criterion['urgency']); }
					if (! substr_in_array($criterion['name'],$ids[$id]['criteria']) ) { array_push($ids[$id]['criteria'],$criterion['name'].$_criteriondetail); } 
				}
			}
		}
		$identifiers = implode(',',$_config['identifiers'][$table]);
		$identifiers_esc = "'".str_replace(",","','",$identifiers)."'";
		unset($_stmt_array); $_stmt_array = array();
		$_stmt_array['stmt'] = 'SELECT keymachine,keyreadable from '.$table.'_permissions WHERE keymachine IN ('.$identifiers_esc.')';
		$_identifiers_result = execute_stmt($_stmt_array,$conn)['result'];
		$_identifiers_readable = array_combine($_identifiers_result['keymachine'],$_identifiers_result['keyreadable']);						
		unset($_stmt_array); $_stmt_array = array();
		$_stmt_array['stmt'] = 'SELECT id_'.$table.','.$identifiers.' from view__'.$table.'__'.$_SESSION['os_role'].' WHERE id_'.$table.' IN ('.implode(',',array_keys($ids)).')';						
		$_table_result = execute_stmt($_stmt_array,$conn,true)['result'];
		if ( ! $_table_result OR sizeof($_table_result) == 0 ) { continue; }
		?>
		<div class="tableicon"><i class="fas fa-<?php html_echo($icon[$table]); ?>"></i></div>
		<div>
			<table>
				<tr>
					<?php
					foreach ( $_config['identifiers'][$table] as $identifier ) {
					?>
						<th><?php echo($_identifiers_readable[$identifier]); ?></th>
					<?php
					}
					?>
					<th>Kriterien</th>
				</tr>
		<?php
		foreach ( $_table_result as $_item ) {
			$_rnd = rand(0,32767);
			if ( $ids[$_item['id_'.$table]]['urgency'] == 1 ) { $_class = "yellow"; }
			if ( $ids[$_item['id_'.$table]]['urgency'] == 2 ) { $_class = "orange"; }
			if ( $ids[$_item['id_'.$table]]['urgency'] > 2 ) { $_class = "red"; }
			?>
			<tr class="<?php html_echo($_class); ?>">
				<?php
				foreach ( $_config['identifiers'][$table] as $identifier ) {
				?>
					<td><?php html_echo($_item[$identifier]); ?></td>
				<?php } ?>
				<td><?php html_echo(implode(' | ',$ids[$_item['id_'.$table]]['criteria'])); ?></td>
				<td>
					<form method="post" id="ampelForm_<?php echo($_rnd); ?>" class="inline" action="" onsubmit="callFunction(this,'getDetails','_popup_',false,'details'); return false;"><input form="ampelForm_<?php echo($_rnd); ?>" value="<?php echo($_item['id_'.$table]); ?>" name="id_opsz_aufnahme" hidden="" type="text"><input form="ampelForm_<?php echo($_rnd); ?>" id="ampelSubmit__<?php echo($_rnd); ?>" hidden="" type="submit"></form>
					<label for="ampelSubmit__<?php echo($_rnd); ?>"><i class="fas fa-address-card"></i></label>
				</td>							
			</tr>
			<?php
		}
		?>
			</table>
			<br />
		</div>
		<?php 
	}
}

function _parseCriterion(array $resultin, array $_param, array $criterion, mysqli $conn) {
	//included 'not': use notimplies whenever possible, since otherwise we have to define an _all array, what costs a lot if time!
	$_logical = array("and","or","not","notimplies","implies");
	$_logical = array_values(array_intersect($_logical,array_keys($criterion)));
	if ( isset($_logical[0]) ) { 
		//rewrite for some keywords before parsing subcriteria:
		switch ($_logical[0]) {
			case 'implies':
				//binary relation
				//rewrite implies(a,b) to ( !a or b )
				$criterion['or'] = array();
				$criterion['or'][0]=array("not"=>$criterion['implies'][0]);
				$criterion['or'][1]=$criterion['implies'][1];
				unset($criterion['implies']);
				$_logcial[0] = 'or';
				break;
		}
		$subcriteria = $criterion[$_logical[0]] ;
		if ( ! $subcriteria[0] ) { $subcriteria = array($subcriteria); } // this is for "not": applies only to one criterion, so is no array of criteria by design
		foreach ($subcriteria as $index => $subcriterion ) {
			$subcriterion['table'] = $criterion['table'];
			$subresultout_array = _parseCriterion($resultin,$_param,$subcriterion,$conn);
			$subresultout = $subresultout_array[0];
			$_subparam = $subresultout_array[1];
			$_param = array_merge($_param,$_subparam);
			switch($_logical[0]) {
				case 'and':
					if ( $index == 0 ) { $resultin = $subresultout; }
					else { $resultin = array_values(array_intersect($resultin,$subresultout)); }
					break;
				case 'or': 
					$resultin = array_unique(array_merge($resultin,$subresultout));
					break;
				case 'not':
					if (! isset($_all) ) {
						unset($_stmt_array); $_stmt_array = array();
						$_stmt_array['stmt'] = "SELECT id_".$criterion['table']." AS id FROM view__".$criterion['table']."__".$_SESSION['os_role'];
						$_all = execute_stmt($_stmt_array,$conn)['result']['id'];
					}
					$resultin = array_diff($_all,$subresultout);
					break;
				case 'notimplies':
					// binary relation
					// this is special: notimplies(a,b) is equivalent to (a AND !b), so we dont need $_all but can array_diff to result of a; this is much faster!
					if ( $index == 0 ) { $resultin = $subresultout; }
					if ( $index == 1 ) { $resultin = array_diff($resultin,$subresultout); }
					break;
			}
		}
		return array($resultin,$_param);
	} else {
	//proper parsing
	//the following only works for simple queries: fix it for multiple select, from, where and 'distinct'... keywords
		$_where_array = preg_split('/ WHERE /i',$criterion['sql'],2);
		$_where = $_where_array[1];
		$_from_array = preg_split('/ FROM /i',$_where_array[0],2);
		$_from = $_from_array[1];
		$_select_array = preg_split('/SELECT /i',$_from_array[0],2);
		$_select = $_select_array[1];
		unset($_stmt_array); $_stmt_array = array();
		$_resultout = array (); $_param = array ();
		$_stmt_array['stmt'] = "SELECT id_".$criterion['table'].",".$_select." AS PARAM FROM view__".$_from."__".$_SESSION['os_role']." WHERE ".$_where." GROUP BY id_".$criterion['table']." ORDER BY PARAM DESC";
		foreach ( execute_stmt($_stmt_array,$conn,true)['result'] as $_maybe ) {
			$value = $_maybe['PARAM'];
			if ( $key == 'id_'.$criterion['table'] ) { continue; }
			$_push = false;
			switch($criterion['relation']) {
				case '>':
					if ( $value > $criterion['benchmark'] ) { $_push = true; }
					break;
				case '>=':
					if ( $value >= $criterion['benchmark'] ) { $_push = true; }
					break;
				case '<':
					if ( $value < $criterion['benchmark'] ) { $_push = true; }
					break;
				case '<=':
					if ( $value <= $criterion['benchmark'] ) { $_push = true; }
					break;
				case '=':
					if ( $value == $criterion['benchmark'] ) { $_push = true; }
					break;
				case '!=':
					if ( $value != $criterion['benchmark'] ) { $_push = true; }
					break;
				case 'contains':
					if ( strpos($value,$criterion['benchmark']) ) { $_push = true; }
					break;
				case 'beginswith':
					if ( strpos($value,$criterion['benchmark']) == 0 ) { $_push = true; }
					break;
				case 'endswith':
					if ( strpos($value,$criterion['benchmark']) == strlen($value) - strlen($criterion['benchmark']) ) { $_push = true; }
					break;
				case 'notcontains':
					if ( ! strpos($value,$criterion['benchmark']) ) { $_push = true; }
					break;
				case 'notbeginswith':
					if ( strpos($value,$criterion['benchmark']) !== 0 ) { $_push = true; }
					break;
				case 'notendswith':
					if ( strpos($value,$criterion['benchmark']) !== strlen($value) - strlen($criterion['benchmark']) ) { $_push = true; }
					break;
			}
			if ( $_push ) { 
				array_push($_resultout,$_maybe['id_'.$criterion['table']]);
				if ( isset($criterion['display']) ) {
					//need non-numeric keys for array_merge to do what we want
					$_param['id'.$_maybe['id_'.$criterion['table']]] = $value.' '.$criterion['display'];
				}
			}
		}
		return array($_resultout,$_param);
	}
}

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
			case 'SYMPTOME':
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
		$replaceby = _cleanup($replaceby);
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
?>
