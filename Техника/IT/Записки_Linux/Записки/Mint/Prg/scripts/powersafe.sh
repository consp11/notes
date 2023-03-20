GOVERNOR='powersave'
for CPUFREQ in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
do
        [ -f $CPUFREQ ] || continue
        #echo $CPUFREQ
        sudo echo -n $GOVERNOR > $CPUFREQ
done

for CPUFREQ in /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
do
        [ -f $CPUFREQ ] || continue
        # echo $CPUFREQ
        sudo echo -n 1600000 > $CPUFREQ
done
