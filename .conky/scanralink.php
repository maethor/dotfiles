<?

$Scanned = shell_exec("iwlist ra0 scan");

$ligne = preg_split("/[\n]+/", $Scanned);




foreach( $ligne as $row => $value ) 
	{
    	// Enlever les espaces en trop
          $value = preg_replace('/\s\s+/', ' ', $value);
    	// Enlever les espaces devant et derriere
     	  $value = trim($value);

	$TMPlist5 ="";

	if(eregi("Cell",$value)) { 
		$Adresse = split("Address:",$value); 
		$TMPlist3 = $Adresse[1];
		}
	if(eregi("ESSID",$value)) { $TMPlist1 = $value; }
	if(eregi("Mode:",$value)) { if(!eregi("Managed",$value)) { $Scanlist .= "#### ATTENTION #### \n $value \n #### ATTENTION ####"; } }
	if(eregi("Channel",$value)) { $Scanlist .= $value.' - '.$TMPlist1."\n"; $Scanlist .= "Adresse : ".$TMPlist3."\n"; }
	if(eregi("Quality:",$value)) { 
		$Quality = split(" ",$value); 
		$TMPlist3 = $Quality[0];
		}
	if(eregi("Encryption key",$value)) { $TMPlist5 = $value."\n"; }	
	if(eregi("Bit Rates",$value)) { $Scanlist .= $value." - ".$TMPlist3."\n"; }		
	if(eregi("IE:",$value)) { $value = str_replace("IE: ","",$value); $TMPlist2 = $value; }
	$Scanlist .= $TMPlist5 ;
	if(eregi("Group",$value)) { $value = str_replace("Group Cipher : ","",$value); $Scanlist .= $TMPlist2.' - '.$value."\n\n"; }

	}
print "   - ".date("d/M/Y - H:m:s")."\n\n";
print $Scanlist;

?>

