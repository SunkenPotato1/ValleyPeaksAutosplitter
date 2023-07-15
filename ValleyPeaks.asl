state("ValleyPeaks")
{
    int yaxis: "UnityPlayer.dll", 0x01AD60D0, 0x0, 0x70, 0x40, 0x30, 0x38, 0x60, 0x154;
    int radios: "mono-2.0-bdwgc.dll", 0x7280F8, 0x90, 0xA20, 0x90, 0x64, 0x16;
    int stamps: "mono-2.0-bdwgc.dll", 0x007280F8, 0x90, 0xA20, 0x90, 0x64, 0x14;
}

init
{
    vars.first1 = true;
    vars.first2 = true;
    vars.gameRestart = true;
    vars.load = false;
    vars.glitched = true;
}

startup
{
    //all tickets glitchless
    settings.Add("allticketsl", true, "All tickets% without skipping tutorial");
        settings.Add("card0l", true, "Tutorial card", "allticketsl");
        settings.Add("card1l", true, "1st card", "allticketsl");
        settings.Add("card2l", true, "2nd card", "allticketsl");
        settings.Add("card3l", true, "3rd card", "allticketsl");
    //all tickets with glitches
    settings.Add("allticketsw", false, "All tickets% with skipping tutorial");
        settings.Add("card1w", false, "1st card", "allticketsw");
        settings.Add("card2w", false, "2nd card", "allticketsw");
        settings.Add("card3w", false, "3rd card", "allticketsw");
    //end% glitchless
    settings.Add("endl", false, "End% without skipping tutorial");
        settings.Add("radio0l", false, "Tutorial Radio", "endl");
        settings.Add("radio1l", false, "1st Radio", "endl");
        settings.Add("radio2l", false, "2nd Radio", "endl");
        settings.Add("radio3l", false, "3rd Radio", "endl");
    //end% with glitches
        settings.Add("endw", false, "End% with skipping tutorial");
        settings.Add("radio1w", false, "1st Radio", "endw");
        settings.Add("radio2w", false, "2nd Radio", "endw");
        settings.Add("radio3w", false, "3rd Radio", "endw");
}

start
{
    if (current.yaxis != 0)
    {
        return true;
    }
}

update
{
    //when you start falling loading stops
    if (old.yaxis > current.yaxis)
    {
        vars.load = false;
    }
    //0 here is == null and when game is loading y pos is null
    if (current.yaxis == 0)
    {
        vars.load = true;
    }
    //if stamps get reset properly set glitched var to false
    if (old.stamps == 3 && current.stamps == 0)
    {
        vars.glitched = false;
    }
    // if memory return null for a bit (idk why) fix the glitched state
    if (old.stamps == 0 && current.stamps == 3)
    {
        vars.glitched = true;
    }
    //debugging
    //print(current.stamps.ToString() + ' ' + vars.glitched);
}

isLoading
{
    if (vars.load == true)
    {
        return true;
    }
    else
    {
        return false;
    }
    //debugging
    //print(vars.load);
}



split
{
    // all tickets glitchless
    if (settings["allticketsl"])
    {
        //only allow splitting on tutorial card
        if (old.stamps == 2 && current.stamps == 3 && vars.first1 && settings["card0l"])
        {
            vars.first1 = false;
            return true;
        }
        //if stamps get reset properly when loading
        if (vars.glitched == false)
        {       
            if (old.stamps == 2 && current.stamps == 3 && settings["card1l"])
            {
                return true;
            }
            if (old.stamps == 5 && current.stamps == 6 && settings["card2l"])
            {
                return true;
            }
            if (old.stamps == 8 && current.stamps == 9  && settings["card3l"])
            {
                return true;
            }
        }
        //if stamps dont get reset properly and stay at 3
        if (vars.glitched == true)
        {       
            if (old.stamps == 5 && current.stamps == 6 && settings["card1l"])
            {
                return true;
            }
            if (old.stamps == 8 && current.stamps == 9 && settings["card2l"])
            {
                return true;
            }
            if (old.stamps == 11 && current.stamps == 12 && settings["card3l"])
            {
                return true;
            }
        }
        
    }

    // all tickets skipping the tutorial
    if (settings["allticketsw"])
    {
        if (old.stamps == 2 && current.stamps == 3 && settings["card1w"])
        {
            return true;
        }
        if (old.stamps == 5 && current.stamps == 6 && settings["card2w"])
        {
            return true;
        }
        if (old.stamps == 8 && current.stamps == 9 && settings["card3w"])
        {
            return true;
        }
    }

    
    //end% glitchless/without skipping tutorial
    if (settings["endl"])
    {
        if (old.radios == 0 && current.radios == 1 && vars.first2 && settings["radio0l"])
        {
            vars.first2 = false;
            return true;
        }
        if (old.radios == 0 && current.radios == 1 && settings["radio1l"])
        {
            return true;
        } 
        if (old.radios == 1 && current.radios == 2 && settings["radio2l"])
        {
            return true;
        }
        if (old.radios == 2 && current.radios == 3 && settings["radio3l"])
        {
            return true;
        }
    }

    // end% with glitches/skipping tutorial
    if (settings["endw"])
    {
        if (old.radios == 0 && current.radios == 1 && settings["radio1w"])
        {
            return true;
        } 
        if (old.radios == 1 && current.radios == 2 && settings["radio2w"])
        {
            return true;
        }
        if (old.radios == 2 && current.radios == 3 && settings["radio3w"])
        {
            return true;
        }
    }
}

reset
{
    //on load reset game time
    //NOTE: wont work if you had a gold time,
    //i think you have to remove warn before reseting in livesplit
    if (vars.gameRestart)
    {
        vars.gameRestart = false;
        return true;
    }
}