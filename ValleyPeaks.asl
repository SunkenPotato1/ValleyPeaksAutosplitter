state("ValleyPeaks")
{
    int yaxis: "UnityPlayer.dll", 0x01A11D80, 0x30, 0x78, 0x78, 0x0, 0x88, 0xC4;
    int radios: "mono-2.0-bdwgc.dll", 0x7280F8, 0x90, 0xA20, 0x90, 0x64, 0x18;
    int stamps: "mono-2.0-bdwgc.dll", 0x728078, 0x440, 0x3C0, 0x7E0, 0x0, 0x0, 0xD4C;
}

init
{
    vars.first1 = true;
    vars.first2 = true;
    vars.gameRestart = true;
    vars.load = false;
}

startup
{
    settings.Add("splitStamps", true, "All tickets and Radios%");
    settings.Add("splitRadio", false, "End%");
}

start
{
    if (old.yaxis != current.yaxis)
    {
        return true;
    }
}

update
{
    if (old.yaxis != current.yaxis)
    {
        vars.load = false;
    }
    if (current.yaxis == 0)
    {
        
        vars.load = true;
    }
}

isLoading
{
    if (vars.load == true)
    {
        print("Is loading " + current.yaxis.ToString());
        return true;
    }
    else
    {
        return false;
    }
}



split
{
    if (settings["splitStamps"])
    {
       
        if (old.stamps == 2 && current.stamps == 3 && vars.first1)
        {
            vars.first1 = false;
            print("split1" + old.stamps.ToString() + current.stamps.ToString());
            return true;
        }
        if (old.stamps == 2 && current.stamps == 3)
        {
            print("split2" + old.stamps.ToString() + current.stamps.ToString());
           return true;
        }
        if (old.stamps == 5 && current.stamps == 6)
        {
            print("split3" + old.stamps.ToString() + current.stamps.ToString());
           return true;
        }
        if (current.stamps == 9 && current.radios == 3)
        {
            print("split4" + old.stamps.ToString() + current.stamps.ToString());
           return true;
        }
    }

    if (settings["splitRadio"])
    {
        if (old.radios == 0 && current.radios == 1 && vars.first2)
        {
            vars.first2 = false;
           return true;
        }
        if (old.radios == 0 && current.radios == 1)
        {
           return true;
        }
        if (old.radios == 1 && current.radios == 2)
        {
           return true;
        }
        if (current.radios == 3)
        {
           return true;
        }
    }
}

reset
{
    if (vars.gameRestart)
    {
        vars.gameRestart = false;
        return true;
    }
}