#/bin/bash


ip_address="$(ip a | grep -i "inet.*wan.*" | cut -d " " -f 6)"

#check to see if the last_ip file exists; if not, create it; 
if [[ -e last_ip.txt ]]; then
  :
else
  touch last_ip.txt
fi

current_ip=$(cat last_ip.txt)


if [[ $ip_address != $current_ip ]]; then
  printf "Subject: IP address notification\n\nNew IP address is:\n\n$ip_address\n" | ssmtp your_email_address
  printf "%(%D)T\t%(%H:%M)T\n\n\n\n" >> /root/bin/logfile  # write the ip and the time to a file that you can check for logging purporses.
  echo $ip_address > last_ip.txt
else: 
fi  


