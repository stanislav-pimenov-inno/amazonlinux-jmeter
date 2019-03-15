# amazonlinux-jmeter

## Install jmeter

To install JDK8 and Jmeter 5.1 with plugins on the Amazon Linux instance execute: `sudo install-jmeter.sh`

## Execute JMX test plan

### Preconditions:
1. Amazon Linux EC2 instance with preinstalled jmeter (like described in the `install-jmeter.sh`)
2. You have SSH key file (.pem) was that was used for EC2 instance creation

### Upload test plan

Upload JMX test plan to home directory on EC2 instance

`scp -i /path/to/pem-file /path/to/jmx-file ec2-user@<ec2-instance-internal-ip>:~` 

### Execute test plan

1. Connect by SSH
`ssh -i /path/to/pem-file ec2-user@<ec2-instance-internal-ip>`

2. Start test execution

`jmeter -n -t [jmx_path] -l results/results.jtl -e -o results`

example

nohup jmeter -n -t servicename.jmx -l results/servicename/summary.jtl -e -o results/servicename &

-n flag means “run JMeter in Non-GUI mode”
-t is used to specify path to jmx file
-l name of JTL file to log sample results to
-e generate report dashboard after load test
-o output folder where to generate the report dashboard after load test. Folder must not exist or be empty

3. Download test execution results

Archive the results to decrease data size to transder:

`zip -r servicename.zip results/servicename`

Download to you local machine:

`scp -i /path/to/pem-file -r ec2-user@<ec2-instance-internal-ip>:~/servicename.zip ~/path/to/save/results`
