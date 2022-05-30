- Este script de Ansible Playbook lo ayudará a crear un `AWS EC2 Infrastructure` y configurar un `Hadoop Cluster` con versión de código abierto disponible en Apache Software Foundation
- Las instancias de AWS EC2 están en Ubuntu 20.04

# 1. Crear una infraestructura de AWS

Este rol configura lo siguiente:

* VPC
* Dos redes (privada y pública)
* Crea 1 instancia pública que tomará como host Bastion, crea 8 instancias privadas para el clúster
* Asignaciónn de IP pública para instancia pública
* Agrega puerta de enlace de Internet y puerta de enlace NAT para permitir la comunicación entre redes e Internet
* General nuevo grupo de hosts a `path_hosts_group`, se debe crear la ruta al archivo de grupo de hosts
* Permite limpiar VPC y todos los recursos de AWS creados

### a. Requerido

- Cree un par de claves ssh y pegue el contenido de la clave pública en `roles/create_ec2_vpc/files/aws.pub`
- Establezca la ruta absoluta de su clave privada en `group_vars/all.yaml` en fila `private_key` 
- crear un archivo de credenciales `cred.yml` para acceso aws y clave secreta. Abra `cred.yml.RENAME` y siga las instrucciones
- Copie la `private key` generada en `roles/common/files`
- Establezca un `internal_public_key_hadoop` en `group_vars/all.yaml` (este es el par de claves de `privatekey` en la instrucción anterior)


### b. Preparar
##### ¡Cambie los parámetros  de acuerdo con los requerimientos!

- Edite el archivo `group_vars/all.yaml`

##### Choose the mode for your system: 

¿La instancia EC2 necesita una zona de disponibilidad o NO?

- Edite el archivo `create_hadoop_infrastructure.yml`

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


### c. Ejecutar
##### Crear instancias y VPC de AWS

```
sudo ansible-playbook create_hadoop_infrastructure.yml --tags="create" --ask-vault-pass
```

##### Limpiar instancias y VPC de AWS

```
sudo ansible-playbook create_hadoop_infrastructure.yml --tags="clean" --ask-vault-pass
```

# 2. instalar el clúster de hadoop


### a. Configuració de Ansible (host checking false)

- Export `ANSIBLE_HOST_KEY_CHECKING`

Ejecutar:

```
export ANSIBLE_HOST_KEY_CHECKING=False
```

### b. Implementar Hadoop, datos B2B (opcional), datos B2C (opcional)
```
ansible-playbook --key-file /home/user/mykeypair.pem -i inventories/staging/hosts install_hadoop.yaml
```
```
ansible-playbook --key-file /home/user/mykeypair.pem -i inventories/staging/hosts install_datasource.yaml --ask-vault-pass
```


### Ejemplos de proxy para monitorear clúster por web 

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
```
NOTE: Ver "inventories/staging/proxies" para obtener más detalles y verifique su configuración ssh local "~/.ssh/config" 
```
### c. StopCluster

To stop instances (UNDER CONSTRUCTION):

```
$ ansible-playbook --private-key .ssh/mykey stopagents.yaml
```

