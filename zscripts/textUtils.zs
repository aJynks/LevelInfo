class ajynks_ColorUtil
{
    static String GetColorCode(int colorIndex, int defaultColor)
    {
        switch (colorIndex)
        {
            case 0: return "\c[Brick]";
            case 1: return "\c[Tan]";
            case 2: return "\c[Gray]";
            case 3: return "\c[Green]";
            case 4: return "\c[Brown]";
            case 5: return "\c[Gold]";
            case 6: return "\c[Red]";
            case 7: return "\c[Blue]";
            case 8: return "\c[Orange]";
            case 9: return "\c[White]";
            case 10: return "\c[Yellow]";
            case 11: return GetColorCode(defaultColor, defaultColor); // Default Setting
            case 12: return "\c[Black]";
            case 13: return "\c[Light Blue]";
            case 14: return "\c[Cream]";
            case 15: return "\c[Olive]";
            case 16: return "\c[Dark Green]";
            case 17: return "\c[Dark Red]";
            case 18: return "\c[Dark Brown]";
            case 19: return "\c[Purple]";
            case 20: return "\c[Dark Gray]";
            case 21: return "\c[Cyan]";
            case 22: return "\c[Ice]";
            case 23: return "\c[Fire]";
            case 24: return "\c[Sapphire]";
            case 25: return "\c[Teal]";
            default: return "\c[White]"; // Fallback to White
        }
    }
}

class ajynks_Space
{
    static String set(bool useSpace = true)
    {
        if (useSpace)
        {
            if ("aJynks_Default" == ajynks_levelInfo_font) {

                if (ajynks_levelInfo_show) {
                    return "   ";
                } else {return "    ";}
    
            } else if ("NewSmallFont" == ajynks_levelInfo_font) {
                if (ajynks_levelInfo_show) {
                    return " ";
                } else {return " ";}
    
            } else if ("SmallFont" == ajynks_levelInfo_font) {
                if (ajynks_levelInfo_show) {
                    return "   ";
                } else {return "   ";}
    
            } else if ("ConsoleFont" == ajynks_levelInfo_font) {
                if (ajynks_levelInfo_show) {
                    return " ";
                } else {return " ";}
    
            } else if ("BigFont" == ajynks_levelInfo_font) {
                if (ajynks_levelInfo_show) {
                    return " ";
                } else {return "  ";}
    
            } else {
                if (ajynks_levelInfo_show) {
                    return "   ";
                } else {return "    ";}
            }
        }
        else
        {
            return "";
        }
    }

    static String item()
    {
        if ("layout_vertical" == ajynks_levelInfo_layout) 
        {
            if (ajynks_levelInfo_font == "BigFont" || 
                ajynks_levelInfo_font == "SmallFont" || 
                ajynks_levelInfo_font == "aJynks_Default")
            {
                return " ";
            }
            return ""; // No need for else, just return directly
        }
    
        return ""; // Fixed missing semicolon and ensures a return in all cases
    }
}

class ajynks_levelInfoUtils
{
    // Custom reload function
    String setTime(bool timeLabel = true)
    {
        int tics_Second = 35;
        int seconds_Minute = 60;
        int minutes_Hour = 60;
        int totalTics = level.MapTime;

        // Calculate time units
        int totalSeconds = totalTics / tics_Second;
        int tics = totalTics % tics_Second;

        int seconds = totalSeconds % seconds_Minute;
        int totalMinutes = totalSeconds / seconds_Minute;

        int minutes = totalMinutes % minutes_Hour;
        int hours = totalMinutes / minutes_Hour;

        // convert the ints into strings and add a 0 at the front if needed
        string ticString, secString, minString, hourString;

        int percentage = (tics * 60) / 35 + 0.5;

        if (percentage < 10) {
            ticString = "0"..percentage;
        } else {
            ticString = percentage.."";
        }

        if (seconds < 10){
            secString = "0"..seconds;
        }else{
            secString = seconds.."";
        }

        if (minutes < 10){
            minString = "0"..minutes;
        }else{
            minString = minutes.."";
        }

        if (hours < 10){
            hourString = "0"..hours;
        }else{
            hourString = hours.."";
        }

        if (timeLabel)
        {
            // Only print out Hour value, if time in level is over an hour.
            if (hours > 0){
                return ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_sTime, 9).."TIME : "..ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_time, 3)..hourString..":"..minString..":"..secString..":"..ticString;
            } 
            else {
                return ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_sTime, 9).."TIME : "..ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_time, 3)..minString..":"..secString..":"..ticString;
            } 
        }
        else
        {
            // Only print out Hour value, if time in level is over an hour.
            if (hours > 0){
                return ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_time, 3)..hourString..":"..minString..":"..secString..":"..ticString;
            } 
            else {
                return ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_time, 3)..minString..":"..secString..":"..ticString;
            } 
        }      
    }

    String setKills()
    {
        string killedMonsters = String.Format("%d", level.killed_monsters); 
        string totalMonsters  = String.Format("%d", level.total_monsters);

        // Check if all monsters are killed
        if (level.killed_monsters == level.total_monsters) {
            String kills = String.Format(
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_sKills, 6).."K: "..
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_100, 8)..killedMonsters.."/"..totalMonsters
			);
            return kills;
        }

        if (ajynks_levelInfo_show) {
            //true == ON
            String kills = String.Format(
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_sKills, 6).."K: "..
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_kills, 21)..killedMonsters.."/"..totalMonsters
			);
            return kills;

        } else {
            String kills = String.Format(
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_sKills, 6).."K: "..
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_kills, 21)..killedMonsters
			);
            //false
            return kills;
        }
    }

    String setItems(bool noSpace = true)
    {
        string foundItems     = String.Format("%d", level.Found_Items);
        string totalItems     = String.Format("%d", level.Total_Items);
        ajynks_Space space;

        // Check if all monsters are killed
        if (level.Found_Items == level.Total_Items) {
            String items = String.Format(
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_sItems, 6)..space.set(noSpace).."I: "..
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_100, 8)..foundItems.."/"..totalItems
			);
            return items;
        }


        if (ajynks_levelInfo_show) {
            //true == ON
            String items = String.Format(
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_sItems, 6)..space.set(noSpace).."I"..space.item()..": "..
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_items, 10)..foundItems.."/"..totalItems
			);
            return items;
            
        } else {
            String items = String.Format(
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_sItems, 6)..space.set(noSpace).."I"..space.item()..": "..
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_items, 10)..foundItems
			);
            //false
            return items;
        }
    }

        String setSecrets(bool noSpace = true)
    {
        string foundSecrets   = String.Format("%d", level.Found_Secrets);
        string totalSecrets   = String.Format("%d", level.Total_Secrets);
        ajynks_Space space;

        // Check if all monsters are killed
        if (level.Found_Secrets == level.Total_Secrets) {
            String secrets = String.Format(
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_sSecrets, 6)..space.set(noSpace).."S: "..
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_100, 8)..foundSecrets.."/"..totalSecrets
			);
            return secrets;
        }

        if (ajynks_levelInfo_show) {
            //true == ON
            String secrets = String.Format(
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_sSecrets, 6)..space.set(noSpace).."S: "..
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_secrets, 18)..foundSecrets.."/"..totalSecrets
			);
            return secrets;
            
        } else {
            String secrets = String.Format(
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_sSecrets, 6)..space.set(noSpace).."S: "..
				ajynks_ColorUtil.GetColorCode(ajynks_levelInfo_secrets, 18)..foundSecrets
			);
            //false
            return secrets;
        }
    }
}