#!/bin/bash


i=0
while [ $i -le 10 ];
do

        echo "Cycle number: $i"
        state=$(aws ec2 describe-instances --instance-id i-0c88908dcc921268d | jq '.Reservations[0].Instances[0].State.Name' | tr -d '"')

        if [[ $state == *"running"* ]]; then
          date
          sleep 20
          echo "Stopping the instance"
          aws ec2 stop-instances --instance-ids i-0c88908dcc921268d
          i=$(($i+1))

        elif [[ $state == *"stopped"* ]]; then
          date
          echo "Starting the instance"
          aws ec2 start-instances --instance-ids i-0c88908dcc921268d
          i=$(($i+1))

        else
         echo "Instance current state: $state"
          sleep 5

        fi

done
