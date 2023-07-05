state("ValleyPeaks")
{
    int yaxis: "UnityPlayer.dll", 0x01A664D0, 0xA8, 0x0, 0x20, 0x28, 0x154;
    int radios: "mono-2.0-bdwgc.dll", 0x7280F8, 0x90, 0xA20, 0x90, 0x64, 0x18;
    int stamps: "mono-2.0-bdwgc.dll", 0x728078, 0x440, 0x3C0, 0x7E0, 0x0, 0x0, 0xD4C;
}

init
{
    vars.fst = true;
    vars.sst = true;
    vars.gameRestart = true;
    vars.load = false;
}

startup
{
    settings.Add("splitStamps", true, "Split on Stamp Cards");
    settings.Add("splitRadio", false, "Split on radios");
}

start
{
    if (old.yaxis > current.yaxis)
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
       
        if (old.stamps == 2 && current.stamps == 3 && vars.fst)
        {
            vars.fst = false;
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
        if (old.radios == 0 && current.radios == 1 && vars.sst)
        {
            vars.sst = false;
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
        if (old.radios == 2 && current.radios == 3)
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