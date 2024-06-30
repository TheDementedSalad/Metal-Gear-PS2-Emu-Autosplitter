//emu-help tool created by jujstme - https://github.com/Jujstme

state("LiveSplit") {}

startup
{
	//Creates a persistent instance of the PS2 class (for PS2 emulators)
	//If you want to change it to another emulator type, change the "PS2" to say "PS1" if the splitter is for a PS1 Emu game
	Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS2");
	
	//This allows is to look through a bitmask in order to get split information
	vars.bitCheck = new Func<byte, int, bool>((byte val, int b) => (val & (1 << b)) != 0);
	
	// You can look up for known IDs on https://psxdatacenter.com/
	vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
		//Address of Gamecode (This can be multiple addresses in some cases but it seems this is all 1 for the Subsistence disks)
		emu.MakeString("UGamecode", 11, 0x20C0C8);		//SLUS_212.43, SLUS_213.59
		emu.MakeString("PGamecode", 11, 0x20CC8C);		//SLES_820.43,
		emu.MakeString("JGamecode", 11, 0x20BE0C);		//SLPM_662.21
		emu.MakeString("JAGamecode", 11, 0x20BEC8);		//SLPM_667.95
		//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//These are for the PAL (European Eng, Fr) Version of the game
        //Metal Gear
        emu.Make<byte>("PEF_MGGameState", 0x2759B4);
		emu.Make<byte>("PEF_MGLoad", 0x2759BC);
		emu.Make<byte>("PEF_MGFloorVal", 0x2759C0);
		emu.Make<byte>("PEF_MGScreenVal", 0x2759C4);
		emu.Make<byte>("PEF_MGOnElevator", 0x2759C8);
		//Weapon Ammo
		emu.Make<uint>("PEF_MGMineAmmo", 0x2750A4);
		emu.Make<uint>("PEF_MGExplAmmo", 0x2750A8);
		emu.Make<uint>("PEF_MGRCAmmo", 0x2750AC);
		emu.Make<uint>("PEF_MGHandAmmo", 0x2750B0);
		emu.Make<uint>("PEF_MGSubAmmo", 0x2750B4);
		emu.Make<uint>("PEF_MGRockAmmo", 0x2750B8);
		emu.Make<uint>("PEF_MGGLAmmo", 0x2750BC);
		//Playthrough Info
		emu.Make<uint>("PEF_MGIGT", 0x2750C0);
		emu.Make<uint>("PEF_MGRation", 0x2750C4);
		emu.Make<uint>("PEF_MGKills", 0x2750C8);
		emu.Make<uint>("PEF_MGAlert", 0x2750CC);
		emu.Make<uint>("PEF_MGSpecial", 0x2750D0);
		emu.Make<uint>("PEF_MGSave", 0x2750D4);
		emu.Make<uint>("PEF_MGContinue", 0x2750D8);
		emu.Make<uint>("PEF_MGContPerCheckpoint", 0x2752A0);
		emu.Make<uint>("PEF_MGRationsHeld", 0x274FF0);
		emu.Make<uint>("PEF_MGHealth", 0x274F54);
		emu.Make<byte>("PEF_MGDiff", 0x2751A4);
		//Items In Inventory Bits
		emu.Make<byte>("PEF_MGEQ1", 0x275014);
		emu.Make<byte>("PEF_MGEQ2", 0x275018);
		emu.Make<byte>("PEF_MGEQ3", 0x27501C);
		emu.Make<byte>("PEF_MGEQ4", 0x275020);
		emu.Make<byte>("PEF_MGEQ5", 0x275024);
		//Rescued Prisoner Bits
		emu.Make<byte>("PEF_MGPR1", 0x275028);
		emu.Make<byte>("PEF_MGPR2", 0x27502C);
		emu.Make<byte>("PEF_MGPR3", 0x275030);
		//Boss Kills
		emu.Make<byte>("PEF_MGBO1", 0x27505C);
		emu.Make<byte>("PEF_MGBO2", 0x275060);
		
		//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//These are for the NTSCU (American) Version of the game
		//Metal Gear
        emu.Make<byte>("U_MGGameState", 0x272C7C);
		emu.Make<byte>("U_MGLoad", 0x272C84);
		emu.Make<byte>("U_MGFloorVal", 0x272C88);
		emu.Make<byte>("U_MGScreenVal", 0x272C8C);
		emu.Make<byte>("U_MGOnElevator", 0x272CC4);
		//Weapon Ammo
		emu.Make<uint>("U_MGMineAmmo", 0x27236C);
		emu.Make<uint>("U_MGExplAmmo", 0x272370);
		emu.Make<uint>("U_MGRCAmmo", 0x272374);
		emu.Make<uint>("U_MGHandAmmo", 0x272378);
		emu.Make<uint>("U_MGSubAmmo", 0x27237C);
		emu.Make<uint>("U_MGRockAmmo", 0x272380);
		emu.Make<uint>("U_MGGLAmmo", 0x272384);
		//Playthrough Info
		emu.Make<uint>("U_MGIGT", 0x272388);
		emu.Make<uint>("U_MGRation", 0x27238C);
		emu.Make<uint>("U_MGKills", 0x272390);
		emu.Make<uint>("U_MGAlert", 0x272394);
		emu.Make<uint>("U_MGSpecial", 0x272398);
		emu.Make<uint>("U_MGSave", 0x27239C);
		emu.Make<uint>("U_MGContinue", 0x2723A0);
		emu.Make<uint>("U_MGContPerCheckpoint", 0x272568);
		emu.Make<uint>("U_MGRationsHeld", 0x2722B8);
		emu.Make<uint>("U_MGHealth", 0x27221C);
		emu.Make<byte>("U_MGDiff", 0x27246C);
		//Items In Inventory Bits
		emu.Make<byte>("U_MGEQ1", 0x2722DC);
		emu.Make<byte>("U_MGEQ2", 0x2722E0);
		emu.Make<byte>("U_MGEQ3", 0x2722E4);
		emu.Make<byte>("U_MGEQ4", 0x2722E8);
		emu.Make<byte>("U_MGEQ5", 0x2722EC);
		//Rescued Prisoner Bits
		emu.Make<byte>("U_MGPR1", 0x2722F0);
		emu.Make<byte>("U_MGPR2", 0x2722F4);
		emu.Make<byte>("U_MGPR3", 0x2722F8);
		//Boss Kills
		emu.Make<byte>("U_MGBO1", 0x272324);
		emu.Make<byte>("U_MGBO2", 0x272328);

		//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//These are for the JPN (Japanese) Version of the game
		//Metal Gear
		emu.Make<byte>("J_MGGameState", 0x271364);
		emu.Make<byte>("J_MGLoad", 0x27136C);
		emu.Make<byte>("J_MGFloorVal", 0x272370);
		emu.Make<byte>("J_MGScreenVal", 0x272374);
		emu.Make<byte>("J_MGOnElevator", 0x2723AC);
		//Weapon Ammo
		emu.Make<uint>("J_MGMineAmmo", 0x271A54);
		emu.Make<uint>("J_MGExplAmmo", 0x271A58);
		emu.Make<uint>("J_MGRCAmmo", 0x271A5C);
		emu.Make<uint>("J_MGHandAmmo", 0x271A60);
		emu.Make<uint>("J_MGSubAmmo", 0x271A64);
		emu.Make<uint>("J_MGRockAmmo", 0x271A68);
		emu.Make<uint>("J_MGGLAmmo", 0x271A6C);
		//Playthrough Info
		emu.Make<uint>("J_MGIGT", 0x271A70);
		emu.Make<uint>("J_MGRation", 0x271A74);
		emu.Make<uint>("J_MGKills", 0x271A78);
		emu.Make<uint>("J_MGAlert", 0x271A7C);
		emu.Make<uint>("J_MGSpecial", 0x271A80);
		emu.Make<uint>("J_MGSave", 0x271A84);
		emu.Make<uint>("J_MGContinue", 0x271A88);
		emu.Make<uint>("J_MGContPerCheckpoint", 0x271C50);
		emu.Make<uint>("J_MGRationsHeld", 0x2719A0);
		emu.Make<uint>("J_MGHealth", 0x271904);
		emu.Make<byte>("J_MGDiff", 0x271B54); 
		//Items In Inventory Bits
		emu.Make<byte>("J_MGEQ1", 0x2719C4);
		emu.Make<byte>("J_MGEQ2", 0x2719C8);
		emu.Make<byte>("J_MGEQ3", 0x2719CC);
		emu.Make<byte>("J_MGEQ4", 0x2719D0);
		emu.Make<byte>("J_MGEQ5", 0x2719D4);
		//Rescued Prisoner Bits
		emu.Make<byte>("J_MGPR1", 0x2719D8);
		emu.Make<byte>("J_MGPR2", 0x2719DC);
		emu.Make<byte>("J_MGPR3", 0x2719E0);
		//Boss Kills
		emu.Make<byte>("J_MGBO1", 0x271A0C);
		emu.Make<byte>("J_MGBO2", 0x271A10);
		
		//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		//These are for the JPN (Japanese 20th Anniversary) Version of the game
		//Metal Gear
		emu.Make<byte>("JA_MGGameState", 0x2722E4);
		emu.Make<byte>("JA_MGLoad", 0x2722EC);
		emu.Make<byte>("JA_MGFloorVal", 0x2722F0);
		emu.Make<byte>("JA_MGScreenVal", 0x2722F4);
		emu.Make<byte>("JA_MGOnElevator", 0x27232C);
		//Weapon Ammo
		emu.Make<uint>("JA_MGMineAmmo", 0x2719D4);
		emu.Make<uint>("JA_MGExplAmmo", 0x2719D8);
		emu.Make<uint>("JA_MGRCAmmo", 0x2719DC);
		emu.Make<uint>("JA_MGHandAmmo", 0x2719E0);
		emu.Make<uint>("JA_MGSubAmmo", 0x2719E4);
		emu.Make<uint>("JA_MGRockAmmo", 0x2719E8);
		emu.Make<uint>("JA_MGGLAmmo", 0x2719EC);
		//Playthrough Info
		emu.Make<uint>("JA_MGIGT", 0x2719F0);
		emu.Make<uint>("JA_MGRation", 0x2719F4);
		emu.Make<uint>("JA_MGKills", 0x2719F8);
		emu.Make<uint>("JA_MGAlert", 0x2719FC);
		emu.Make<uint>("JA_MGSpecial", 0x271A00);
		emu.Make<uint>("JA_MGSave", 0x271A04);
		emu.Make<uint>("JA_MGContinue", 0x271A08);
		emu.Make<uint>("JA_MGContPerCheckpoint", 0x272BD0);
		emu.Make<uint>("JA_MGRationsHeld", 0x271920);
		emu.Make<uint>("JA_MGHealth", 0x271884);
		emu.Make<byte>("JA_MGDiff", 0x271AD4);
		//Items In Inventory Bits
		emu.Make<byte>("JA_MGEQ1", 0x271944);
		emu.Make<byte>("JA_MGEQ2", 0x271948);
		emu.Make<byte>("JA_MGEQ3", 0x27194C);
		emu.Make<byte>("JA_MGEQ4", 0x271950);
		emu.Make<byte>("JA_MGEQ5", 0x271954);
		//Rescued Prisoner Bits
		emu.Make<byte>("JA_MGPR1", 0x271958);
		emu.Make<byte>("JA_MGPR2", 0x27195C);
		emu.Make<byte>("JA_MGPR3", 0x271960);
		//Boss Kills
		emu.Make<byte>("JA_MGBO1", 0x271964);
		emu.Make<byte>("JA_MGBO2", 0x271968);
		return true;
    });
	//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	//Metal Gear variables we can make settings from
	vars.mgKeyID = new List<string>(){
	"MGEQ3_1", "MGEQ4_6", "MGEQ4_7", "MGEQ5_0", "MGEQ5_1", "MGEQ5_2", "MGEQ5_3", "EMGQ5_4"};
	
	vars.mgKeySet = new List<string>(){
	"Card 1", "Card 2", "Card 3", "Card 4", "Card 5", "Card 6", "Card 7", "Card 8"};
	
	vars.mgGunID = new List<string>(){
	"MGEQ3_6", "MGEQ3_3", "MGEQ3_4", "MGEQ3_5", "MGEQ4_2", "MGEQ3_7", "MGEQ4_1", "MGEQ4_0"};
	
	vars.mgGunSet = new List<string>(){
	"Handgun", "Land Mine", "Plastic Explosives", "RC Missiles", "Suppressor", "Submachine Gun", "Grenade Launcher", "Rocket Launcher"};
	
	vars.mgItemID = new List<string>(){
	"MGEQ1_2", "MGEQ1_3", "MGEQ1_5", "MGEQ1_6", "MGEQ1_7", "MGEQ2_0", "MGEQ2_1", "MGEQ2_2", "MGEQ2_3", "MGEQ2_4", "MGEQ2_5", "MGEQ2_6", "MGEQ2_7", "MGEQ3_0", "MGEQ4_5"};
	
	vars.mgItemSet = new List<string>(){
	"Flashlight", "Oxygen Cylinder", "Compass", "Binoculars", "Bomb Blast Suit", "Cardboard Box", "Infrared Goggles", 
	"Transmitter", "Enemy Uniform", "Antenna", "Mine Detector", "Parachute", "Gas Mask", "Antidote", "Body Armour"};
	
	vars.mgHostID = new List<string>(){
	"MGPR1_0", "MGPR1_1", "MGPR1_2", "MGPR1_3", "MGPR1_4", "MGPR1_5", "MGPR1_6", "MGPR1_7", "MGPR2_0", "MGPR2_1", "MGPR2_2", "MGPR2_3", 
	"MGPR2_4", "MGPR2_5", "MGPR2_6", "MGPR2_7", "MGPR3_0", "MGPR3_1", "MGPR3_2", "MGPR3_3", "MGPR3_4", "MGPR3_5", "MGPR3_6", "MGPR3_7"};
	
	vars.mgHostSet = new List<string>(){
	"Gray Fox (Bldg 1, B1)", "Dr. Madnar (Bldg 2, 2F) (After Saving Ellen)", "Ellen (Bldg 1, B1)", "Prisoner 1 (Bldg 1: 3F)", "Prisoner 2 (Bldg 1, 3F", "Prisoner 4 (Bldg 1, 3F)", 
	"Prisoner 3 (Bldg 1, 3F)", "Prisoner 5 (Bldg 1, 1F)", "Prisoner 6 (Bldg 1, 1F)", "Prisoner 7 (Bldg 1, 2F)", "Prisoner 8 (Bldg 1, 2F)", "Prisoner 9 (Bldg 1, 2F)", "Prisoner 10 (Bldg 1, Roof)",
	"Prisoner 11 (Bldg 1, 1F Courtyard)", "Prisoner 12 (Bldg 2, Roof)", "Prisoner 13 (Bldg 2, B1)", "Prisoner 14 (Bldg 2, B1)", "Prisoner 17 (Bldg 2, 2F)", "Prisoner 16 (Bldg 2 2F)",
	"Prisoner 15 (Bldg 2, 1F)", "Prisoner 18 (Bldg 3, 1F Dirty Duck))", "Prisoner 19 (Bldg 3, 1F Dirty Duck)", "Prisoner 20 (Bldg 3, 1F Dirty Duck)", "Prisoner 21 (Bldg 3, B100)"};
	 
	vars.mgBossID = new List<string>(){
	"MGBO1_2", "MGBO1_3", "MGBO1_4", "MGBO1_5", "MGBO1_6", "MGBO1_7", "MGBO2_0", "MGBO2_1", "MGBO2_2"};
	
	vars.mgBossSet = new List<string>(){
	"Shotmaker", "Machine Gun Kid", "Tank", "Bulldozer", "Hind", "Fire Trooper", "Dirty Duck", "Big Boss", "Metal Gear"};

	//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//Metal Gear Splits
	settings.Add("MGItem", false, "Splits On Equipment & Weapons Entering Inventory");
	settings.CurrentDefaultParent = "MGItem";
	
	//Creates splits for Keycards
	settings.Add("MGKey", false, "Key Cards");
		settings.CurrentDefaultParent = "MGKey";
		for(int i = 0; i < 8; i++){
        	settings.Add("" + vars.mgKeyID[i].ToString(), false, "" + vars.mgKeySet[i].ToString());
    	}
	settings.CurrentDefaultParent = "MGItem";
	
	//Creates splits for Weapons
	settings.Add("MGGun", false, "Weapons");
		settings.CurrentDefaultParent = "MGGun";
		for(int i = 0; i < 8; i++){
        	settings.Add("" + vars.mgGunID[i].ToString(), false, "" + vars.mgGunSet[i].ToString());
    	}
	settings.CurrentDefaultParent = "MGItem";
	
	//Creates splits for General Items
	settings.Add("MGItems", false, "General Items");
		settings.CurrentDefaultParent = "MGItems";
		for(int i = 0; i < 15; i++){
        	settings.Add("" + vars.mgItemID[i].ToString(), false, "" + vars.mgItemSet[i].ToString());
    	}
	settings.CurrentDefaultParent = "MGItem";
	
	settings.Add("MGHost", false, "Splits On Saving Hostages");
		settings.CurrentDefaultParent = "MGHost";
		for(int i = 0; i < 24; i++){
        	settings.Add("" + vars.mgHostID[i].ToString(), false, "" + vars.mgHostSet[i].ToString());
    	}
	
	settings.Add("MGBoss", false, "Splits On Boss Kills");
		settings.CurrentDefaultParent = "MGBoss";
		for(int i = 0; i < 9; i++){
        	settings.Add("" + vars.mgBossID[i].ToString(), false, "" + vars.mgBossSet[i].ToString());
    	}
	
	settings.Add("End", true, "Final Split (Alway Active)");
	settings.CurrentDefaultParent = null;
}

init
{
	//This is used for our splits
	vars.mgcompletedSplits = new bool[80];
}

update
{
	//Checks what version you are on via the regional gamecode, then casts the correct information for that version
	//PAL FE Subsistence Disc 2
	if(current.PGamecode == "SLES_820.43"){
		//Metal Gear
		current.MGGameState = current.PEF_MGGameState;
		current.MGLoad = current.PEF_MGLoad;
		current.MGFloorVal = current.PEF_MGFloorVal;
		current.MGScreenVal = current.PEF_MGScreenVal;
		current.MGOnElevator = current.PEF_MGOnElevator;
			
		current.MGMineAmmo = current.PEF_MGMineAmmo;
		current.MGExplAmmo = current.PEF_MGExplAmmo;
		current.MGRCAmmo = current.PEF_MGRCAmmo;
		current.MGHandAmmo = current.PEF_MGHandAmmo;
		current.MGSubAmmo = current.PEF_MGSubAmmo;
		current.MGRockAmmo = current.PEF_MGRockAmmo;
		current.MGGLAmmo = current.PEF_MGGLAmmo;
			
		current.MGIGT = current.PEF_MGIGT;
		current.MGRation = current.PEF_MGRation;
		current.MGKills = current.PEF_MGKills;
		current.MGAlert = current.PEF_MGAlert;
		current.MGSpecial = current.PEF_MGSpecial;
		current.MGSave = current.PEF_MGSave;
		current.MGContinue = current.PEF_MGContinue;
		current.MGContPerCheckpoint = current.PEF_MGContPerCheckpoint;
		current.MGRationsHeld = current.PEF_MGRationsHeld;
		current.MGHealth = current.PEF_MGHealth;
		current.MGDiff = current.PEF_MGDiff;
			
		current.MGEQ1 = current.PEF_MGEQ1;
		current.MGEQ2 = current.PEF_MGEQ2;
		current.MGEQ3 = current.PEF_MGEQ3;
		current.MGEQ4 = current.PEF_MGEQ4;
		current.MGEQ5 = current.PEF_MGEQ5;
		current.MGPR1 = current.PEF_MGPR1;
		current.MGPR2 = current.PEF_MGPR2;
		current.MGPR3 = current.PEF_MGPR3;
		current.MGBO1 = current.PEF_MGBO1;
		current.MGBO2 = current.PEF_MGBO2;
	}
	//US Subsistence Disc 2
	if(current.UGamecode == "SLUS_212.43"){
		//Metal Gear
		current.MGGameState = current.U_MGGameState;
		current.MGLoad = current.U_MGLoad;
		current.MGFloorVal = current.U_MGFloorVal;
		current.MGScreenVal = current.U_MGScreenVal;
		current.MGOnElevator = current.U_MGOnElevator;
			
		current.MGMineAmmo = current.U_MGMineAmmo;
		current.MGExplAmmo = current.U_MGExplAmmo;
		current.MGRCAmmo = current.U_MGRCAmmo;
		current.MGHandAmmo = current.U_MGHandAmmo;
		current.MGSubAmmo = current.U_MGSubAmmo;
		current.MGRockAmmo = current.U_MGRockAmmo;
		current.MGGLAmmo = current.U_MGGLAmmo;
			
		current.MGIGT = current.U_MGIGT;
		current.MGRation = current.U_MGRation;
		current.MGKills = current.U_MGKills;
		current.MGAlert = current.U_MGAlert;
		current.MGSpecial = current.U_MGSpecial;
		current.MGSave = current.U_MGSave;
		current.MGContinue = current.U_MGContinue;
		current.MGContPerCheckpoint = current.U_MGContPerCheckpoint;
		current.MGRationsHeld = current.U_MGRationsHeld;
		current.MGHealth = current.U_MGHealth;
		current.MGDiff = current.U_MGDiff;
			
		current.MGEQ1 = current.U_MGEQ1;
		current.MGEQ2 = current.U_MGEQ2;
		current.MGEQ3 = current.U_MGEQ3;
		current.MGEQ4 = current.U_MGEQ4;
		current.MGEQ5 = current.U_MGEQ5;
		current.MGPR1 = current.U_MGPR1;
		current.MGPR2 = current.U_MGPR2;
		current.MGPR3 = current.U_MGPR3;
		current.MGBO1 = current.U_MGBO1;
		current.MGBO2 = current.U_MGBO2;
	}
	//JPN Subsistence Disc 2
	if(current.JGamecode == "SLPM_662.21"){
		//Metal Gear
		current.MGGameState = current.J_MGGameState;
		current.MGLoad = current.J_MGLoad;
		current.MGFloorVal = current.J_MGFloorVal;
		current.MGScreenVal = current.J_MGScreenVal;
		current.MGOnElevator = current.J_MGOnElevator;
			
		current.MGMineAmmo = current.J_MGMineAmmo;
		current.MGExplAmmo = current.J_MGExplAmmo;
		current.MGRCAmmo = current.J_MGRCAmmo;
		current.MGHandAmmo = current.J_MGHandAmmo;
		current.MGSubAmmo = current.J_MGSubAmmo;
		current.MGRockAmmo = current.J_MGRockAmmo;
		current.MGGLAmmo = current.J_MGGLAmmo;
			
		current.MGIGT = current.J_MGIGT;
		current.MGRation = current.J_MGRation;
		current.MGKills = current.J_MGKills;
		current.MGAlert = current.J_MGAlert;
		current.MGSpecial = current.J_MGSpecial;
		current.MGSave = current.J_MGSave;
		current.MGContinue = current.J_MGContinue;
		current.MGContPerCheckpoint = current.J_MGContPerCheckpoint;
		current.MGRationsHeld = current.J_MGRationsHeld;
		current.MGHealth = current.J_MGHealth;
		current.MGDiff = current.J_MGDiff;
			
		current.MGEQ1 = current.J_MGEQ1;
		current.MGEQ2 = current.J_MGEQ2;
		current.MGEQ3 = current.J_MGEQ3;
		current.MGEQ4 = current.J_MGEQ4;
		current.MGEQ5 = current.J_MGEQ5;
		current.MGPR1 = current.J_MGPR1;
		current.MGPR2 = current.J_MGPR2;
		current.MGPR3 = current.J_MGPR3;
		current.MGBO1 = current.J_MGBO1;
		current.MGBO2 = current.J_MGBO2;
	}
	//JPN 20th Anniversary Disc 2
	if(current.JAGamecode == "SLPM_667.95"){
		//Metal Gear
		current.MGGameState = current.JA_MGGameState;
		current.MGLoad = current.JA_MGLoad;
		current.MGFloorVal = current.JA_MGFloorVal;
		current.MGScreenVal = current.JA_MGScreenVal;
		current.MGOnElevator = current.JA_MGOnElevator;
			
		current.MGMineAmmo = current.JA_MGMineAmmo;
		current.MGExplAmmo = current.JA_MGExplAmmo;
		current.MGRCAmmo = current.JA_MGRCAmmo;
		current.MGHandAmmo = current.JA_MGHandAmmo;
		current.MGSubAmmo = current.JA_MGSubAmmo;
		current.MGRockAmmo = current.JA_MGRockAmmo;
		current.MGGLAmmo = current.JA_MGGLAmmo;
			
		current.MGIGT = current.JA_MGIGT;
		current.MGRation = current.JA_MGRation;
		current.MGKills = current.JA_MGKills;
		current.MGAlert = current.JA_MGAlert;
		current.MGSpecial = current.JA_MGSpecial;
		current.MGSave = current.JA_MGSave;
		current.MGContinue = current.JA_MGContinue;
		current.MGContPerCheckpoint = current.JA_MGContPerCheckpoint;
		current.MGRationsHeld = current.JA_MGRationsHeld;
		current.MGHealth = current.JA_MGHealth;
		current.MGDiff = current.JA_MGDiff;
			
		current.MGEQ1 = current.JA_MGEQ1;
		current.MGEQ2 = current.JA_MGEQ2;
		current.MGEQ3 = current.JA_MGEQ3;
		current.MGEQ4 = current.JA_MGEQ4;
		current.MGEQ5 = current.JA_MGEQ5;
		current.MGPR1 = current.JA_MGPR1;
		current.MGPR2 = current.JA_MGPR2;
		current.MGPR3 = current.JA_MGPR3;
		current.MGBO1 = current.JA_MGBO1;
		current.MGBO2 = current.JA_MGBO2;
	}
}

onStart
{
	//resets the splits bools when a new run starts
	vars.mgcompletedSplits = new bool[80];
}

start
{
	return current.MGGameState != 10 && old.MGGameState == 10 && current.MGIGT > old.MGIGT;
}

split
{
	//Iterates through our splits and checks the bitmask for each one
	for(int i = 0; i < 8; i++){
		if(settings["MGEQ1_" + i] && vars.bitCheck(current.MGEQ1, i) && !vars.mgcompletedSplits[0 + i]){
			return vars.mgcompletedSplits[0 + i]  = true;
		}
	}
		
	for(int i = 0; i < 8; i++){
		if(settings["MGEQ2_" + i] && vars.bitCheck(current.MGEQ2, i) && !vars.mgcompletedSplits[8 + i]){
			return vars.mgcompletedSplits[8 + i]  = true;
		}
	}
		
	for(int i = 0; i < 8; i++){
		if(settings["MGEQ3_" + i] && vars.bitCheck(current.MGEQ3, i) && !vars.mgcompletedSplits[16 + i]){
			return vars.mgcompletedSplits[16 + i]  = true;
		}
	}
		
	for(int i = 0; i < 8; i++){
		if(settings["MGEQ4_" + i] && vars.bitCheck(current.MGEQ4, i) && !vars.mgcompletedSplits[24 + i]){
			return vars.mgcompletedSplits[24 + i]  = true;
		}
	}
		
	for(int i = 0; i < 8; i++){
		if(settings["MGEQ5_" + i] && vars.bitCheck(current.MGEQ5, i) && !vars.mgcompletedSplits[32 + i]){
			return vars.mgcompletedSplits[32 + i]  = true;
		}
	}
		
	for(int i = 0; i < 8; i++){
		if(settings["MGPR1_" + i] && vars.bitCheck(current.MGPR1, i) && !vars.mgcompletedSplits[40 + i]){
			return vars.mgcompletedSplits[40 + i]  = true;
		}
	}
		
	for(int i = 0; i < 8; i++){
		if(settings["MGPR2_" + i] && vars.bitCheck(current.MGPR2, i) && !vars.mgcompletedSplits[48 + i]){
			return vars.mgcompletedSplits[48 + i]  = true;
		}
	}
		
	for(int i = 0; i < 8; i++){
		if(settings["MGPR3_" + i] && vars.bitCheck(current.MGPR3, i) && !vars.mgcompletedSplits[56 + i]){
			return vars.mgcompletedSplits[56 + i]  = true;
		}
	}
		
	for(int i = 0; i < 8; i++){
		if(settings["MGBO1_" + i] && vars.bitCheck(current.MGBO1, i) && !vars.mgcompletedSplits[64 + i]){
			return vars.mgcompletedSplits[64 + i]  = true;
		}
	}
		
	for(int i = 0; i < 8; i++){
		if(settings["MGBO2_" + i] && vars.bitCheck(current.MGBO2, i) && !vars.mgcompletedSplits[72 + i]){
			return vars.mgcompletedSplits[72 + i]  = true;
		}
	}
		
	//Final Split On Results Screen
	if(current.MGGameState == 21 && current.MGLoad == 0 && old.MGLoad == 1 && !vars.mgcompletedSplits[80])		{return vars.mgcompletedSplits[80]  = true;}
}

gameTime
{
	//Game Time is 15fps so divide by 15
	if(current.PGamecode == "SLES_820.43"){
		return TimeSpan.FromSeconds(current.MGIGT / 16.667);
	}
	else return TimeSpan.FromSeconds(current.MGIGT / 15.0);
}

isLoading
{
	return true;
}

reset
{
		return current.MGGameState != 10 && old.MGGameState == 10;
}
