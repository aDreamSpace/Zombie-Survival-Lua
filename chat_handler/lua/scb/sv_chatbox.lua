if SERVER and not __invokephysgunscript__ then
    ErrorNoHalt("Physgun Utils not detected. This addon will only run on Physgun servers. If you think this is a error, please contact support.")
    return
end

__invokephysgunscript__("scb-sv_chatbox")