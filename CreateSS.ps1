Function CreateSnapshot($Drive)
    {
        Get-ExecutionPolicy
        echo $Drive
         (Get-WmiObject -list win32_shadowcopy).create($Drive,"ClientAccessible")    
    }

    if ($args.Length -eq 0)
    {
        echo "Usage: CreateSnapshot <Drive Letter:\>"
    }
    else
    {
        CreateSnapshot([string[]]$args)
        echo "Creation successful"
    }
   
