- This Ansible Playbook will help you create a `AWS EC2 Infrastructure` and setup `Hadoop Cluster` with open source versin avalaible on Apache Software Foundation
- The AWS EC2 instances are in Ubuntu 18.04 

# 1. Create a AWS Infrastructure

This role setups the following:

* VPC
* Two networks(private and public)
* Create 1 public instance that will take as Bastion host, create 4 private instances for the cluster
* Assign public IP for public instance
* Adds internet gateway and NAT gateway to allow communication between networks and internet
* General new hosts group to the `path_hosts_group`, the path to hosts group file must created
* Allows to cleanup VPC and all created AWS resources

### a. Require

- Create ssh keys pair and paste the content of the public key into `roles/create_ec2_vpc/files/aws.pub`
- Set absolute path of your private key in `group_vars/all.yaml` at row `private_key` 
- create a credential file `cred.yml` for aws access and secret key. Open `cred.yml.RENAME` and follow instrctions
- Copy generated `privatekey` in `roles/common/files`
- Set a `internal_public_key_hadoop` in `group_vars/all.yaml`  (this is the keypair of `privatekey` on before instruction) 


### b. Prepare
##### Change the parameters match with your requirement!

- Edit `group_vars/all.yaml` file

##### Choose the mode for your system: 

Does EC2 instance need Avaibility Zone or NOT?

- Edit the file `create_hadoop_infrastructure.yml`

* Multi AZ: 
```
roles:
    - { role: create_ec2_vpc, mutiAZ: "yes", tags: [ "create" ] }
    - { role: clean-ec2-vpc, mutiAZ: "yes", tags: [ "clean" ] }
```
* Single AZ:
```
roles:
    - { role: create_ec2_vpc, mutiAZ: "no", tags: [ "create" ] }
    - { role: clean-ec2-vpc, mutiAZ: "no", tags: [ "clean" ] }
```


### c. Run
##### Create AWS VPC and Instances

```
sudo ansible-playbook create_hadoop_infrastructure.yml --tags="create" --ask-vault-pass
```

##### Clean AWS VPC and Instances

```
sudo ansible-playbook create_hadoop_infrastructure.yml --tags="clean" --ask-vault-pass
```

# 2. Install hadoop cluster 


### a. host checking false

- Export `ANSIBLE_HOST_KEY_CHECKING`

Run:

```
export ANSIBLE_HOST_KEY_CHECKING=False
```

### b. Deploy Hadoop
```
ansible-playbook --key-file /home/user/mykeypair.pem -i inventories/staging/hosts install_hadoop.yaml
```

### Proxy to monitor cluster by web

#### namenode
```
ssh -i /path/to/private/key -L 9870:master_host_address:9870 bastion_host_address
```
then check in your browser `localhost:9870`

#### resourcemanager
```
ssh -i /path/to/private/key -L 8088:master_host_address:8088 bastion_host_address
```
then check in your browser `localhost:8088/cluster`

#### oozie

```
ssh -i /path/to/private/key -L 11000:oozie_host_address:11000 bastion_host_address
```
then check in your browser `localhost:11000/oozie`

##### command line to check oozie status 
```
oozie admin -oozie http://localhost:11000/oozie -status
```


### c. Stop Cluster

To stop instances (UNDER CONSTRUCTION):

```
$ ansible-playbook --private-key .ssh/mykey stopagents.yaml
```

