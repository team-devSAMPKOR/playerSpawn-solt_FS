/* https://github.com/team-devSAMPKOR/playersSpawnSolt-*/
#include <a_samp>
//#if defined FILTERSCRIPT

public OnFilterScriptInit(){
	print("PSS-FS Load");
	return 1;
}

public OnFilterScriptExit(){
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]){
    new
		cmd[64], idx;
    new
	    tmp[2][64];

	cmd = strtok(cmdtext, idx);
    
    if(!strcmp("/pss", cmd) || !strcmp("/정렬소환", cmd) ){
        if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,-1,"당신은 어드민이 아닙니다.");

        tmp[0] = strtok(cmdtext, idx);
        if(!strlen(tmp[0]))return SendClientMessage(playerid,-1,"/정렬소환(pss) [type : User 0/Car 1]");

        new type = strval(tmp[0]);
        switch(type){
			case 0:soltSpawn(type);
			case 1:{
				tmp[1] = strtok(cmdtext, idx);
				
				if(!strlen(tmp[1]))return SendClientMessage(playerid,-1, "/pss [type] [car model id]");
				new model = strval(tmp[1]);
				soltSpawn(type, model);
			}
        }
        return 1;
    }
	return 0;
}

stock soltSpawn(type, model = 0){
    for(new i=0; i < GetMaxPlayers(); i++){
      if(IsPlayerConnected(i)){
		switch(type){
			case 0:humanSpawn(i);
			case 1:carSpawn(i, model);
		}
      }
    }
}
stock humanSpawn(playerid){
	new str[20];
	format(str, sizeof(str), "%d", playerid);
    SendClientMessage(playerid,-1,str);
}
stock carSpawn(playerid, model){
	new str[20];
	format(str, sizeof(str), "%d - %d", playerid, model);
    SendClientMessage(playerid,-1,str);
}


strtok(const string[], &index){
    new length = strlen(string);
    while ((index < length) && (string[index] <= ' ')){
        index++;
    }
    new offset = index;
    new result[20];
    while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1))){
        result[index - offset] = string[index];
        index++;
    }
    result[index - offset] = EOS;
    return result;
}
//#endif
