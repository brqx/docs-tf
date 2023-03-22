# Get CPU Stats
# Hace un muestreo desde el principio al final
# Y va cogiendo datos cada XX segundos ( que es el periodo)
startTime="2023-03-13T08:00:00"
endTime="$(date '+%Y-%m-%dT%H:%M:%S')"
echo "Chequeo instancias - EC2 ${startTime} --> ${endTime} "
echo "-----------------------------------------------------"
if [ "${instancias}" == "" ] ; then
instancias=$(aw2l | grep running | cut -d ":" -f1 | tr "\n" " ")
fi

for instancia in ${instancias} ; do 
echo "Lanzamiento - Instancia ${instancia}"
aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization  --period 60  \
--statistics Average \
--dimensions Name=InstanceId,Value=${instancia} \
--start-time ${startTime} --end-time  ${endTime}
done


# Refs: 
# https://stackoverflow.com/questions/51645329/aws-get-metric-statistic-datapoint-is-null