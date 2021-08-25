#!/usr/bin/env bash
sinks=($(pacmd list-sinks | grep index | \
    awk '{ if ($1 == "*") print "1"; else print "0" }'))
inputs=($(pacmd list-sink-inputs | grep index | awk '{print $2}'))

echo ${sinks[*]}
#find active sink
active=0
for i in ${sinks[*]}
do
    if [ $i -eq 0 ]
        then active=$((active+1))
        else break
    fi
done

#switch to next sink
swap=$(((active+1)%${#sinks[@]}))

pacmd set-default-sink $swap &> /dev/null
for i in ${inputs[*]}; do pacmd move-sink-input $i $swap &> /dev/null; done