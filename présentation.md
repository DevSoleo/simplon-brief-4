---
marp: true
theme: yeti
markdown.marp.enableHtml: true
paginate: true
---
<!-- backgroundImage: "linear-gradient(to bottom,aqua, #1100)" -->

<!--
_color: black
-->

# Présentation Brief 4
#### Déploiement d'un service applicatif n8n via Ansible sur Azure
Groupe 1
*Noa, Thomas, Nicolas*  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![](https://i.imgur.com/mwPaEBL.png)


<!-- paginate: false -->

---
# SOMMAIRE  
1 - Objectif demandé
2 - Ce que l'on a réalisé
3 - Plan du projet prévu VS plan du projet effectué
4 - Test de charge/monitoring/autoscale Terraform
5 - Script de monitoring de la montée en charge du service applicatif
6 - Compréhension globale de Ansible et Terraform

<!-- paginate: true -->
<!--
_color: black
-->
---
## 1 - Objectif demandé

* Déploiement d’une infrastructure minimale avec une base de donnée
* Programmer des scripts Ansible et Cloud-init
* Déployement d'une application gateway
* Mise en place de TLS
* Monitoring de l’application
* Script de test de montée en charge
* Backup
* Scale out de l'application

---
![width:950px height:650px](https://i.imgur.com/Bjll6gz.png)



<!--
_color: black
-->
---
### - Ressources utilisées  
* La documentation AZCollection pour Ansible
* AZURE
* Google / les formateurs / les apprenants
* Visual Studio Code
* Github
* HackMD
* Ansible / Terraform / Cloud-init / Docker

<!--
_color: black
-->
---
###  - Choix du groupe et individuel
* Ansible pour déployer l'infrastructure
* L'application N8N
* L'utilisation du script Terraform d'Alfred pour la montée en charge et le scale out
* Utilisation du service PAAS AZURE InfluxDB pour réaliser le monitoring

<!--
_color: black
-->
--- 
N8N permet l'automatisation et l'interconnection d'un grand nombre de web services
![](https://i.imgur.com/PsJAzA4.png) 


<!--

_color: black
-->
--- 
## 3 - Plan projet prévu VS plan projet exécuté 
|  | *Plan projet prévu* | *Plan projet exécuté* |
|-----------|:----------:|:------------:|
| Création des ressources principales|&#9745;|&#9745;|
| Bastion |&#9745;|&#9745;|
| Service PAAS Azure Database for Postrgresql |&#9745;|&#9745;|
| Script Cloud-Init |&#9745;|&#9745;|
| Application Gateway  |&#9745;|&#9745;|
| Mise en place TLS|&#9745;|&#9744;| 

<!--
_color: black
-->

---
## 4 - Test de charge/monitoring/autoscale Terraform
Nous avons poursuivi sur le brief sur le script Terraform d'Alfred.
|  | *Plan projet prévu* | *Plan projet exécuté* |
|-----------|:----------:|:------------:|
| Monitoring de l'Application |&#9745;|&#9745;|
| Script de montée en charge |&#9745;|&#9745;|
| Stratégie de Backup|&#9745;|&#9745;|
| Autoscale|&#9745;|&#9745;|
<!--
_color: black
-->
---
## 5 - Monitoring de la montée en charge du service applicatif
![width:1050px height:600px](https://i.imgur.com/xuCA6Te.png)
<!--
_color: black
-->

---
## 6 - Compréhension globale de Ansible et Terraform
| *Terraform* | *Ansible* |
|----------------|----------|
| Orchestration | Gestion de la configuration|
| Déclaratif | Procédurale|
| Infrastructure inmutable|Infrastructure mutable |
| Pas de système maître séparé|Machine maître chargée de stocker l'état complet de l'infrastructure|

<!--
_color: black
-->

---
### Difficultés et solutions
Nous avons rencontré des difficultés avec l'AZCollection d'Ansible qui est parfois inexacte ou peu documenté, nous avons pu sependant progressivement mettre en place l'infrastructure demandé jusqu'au déployment fonctionel de l'application gateway.

Pour la partie monté en charge et scale d'une application, nous avons utilisé le script terraform de l'application de vote d'Alfred pour réaliser en suite la monté en charge avec un script Python.

Pour la partie monitoring j'ai fais le choix d'utiliser le service PAAS Azure InfluxDB. Je fais appel à la base de donnée InfluxDB dans le script python pour collecter les données et pour afficher les données résultant de la monté en charge avec le script. 


<!--
_color: black
-->
---
### Ce que j'ai appris :
J'ai devellopé de nouvelles compétences concernant : 
* Le déploiment des infrastructures via Ansible et Terraform
* A utiliser un conteneur Docker pour l'application N8N
* A réaliser une montée en charge et faire du scale out avec Terraform
* A faire du monitoring avec InfluxDB en utilisant le service PAAS AZURE
