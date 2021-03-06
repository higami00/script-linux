# C'est la première ligne de mon code
# il indique quel shell j'utilise
#!/bin/bash
#
# script conenant un menu qui vas permettre les actions suivantes
# 
#
#
#
# - faire apparaitre les interface réseau
# - changement d'addrese ip
# - configuration du dns
# - activation des services réseau 
# - desactivation des services réseau
# - redémarrage des services réseau
#
#
#
#
# - chaque choix qui seront fait sera inscrit dans un fichier de log
#  
# - clear du log qui sera une fonction caché??
#
clear
echo "================================================================"
echo "=  Menu qui vous autorise à faire les choses suivantes :       ="
echo "=                                                              ="
echo "=  1 - Faire apparaitre les caractèristques réseau             ="
echo "=  2 - Changement d'adresse ip fixe avec masque sous réseau    ="
echo "=  3 - Parametrage en ip dynamique                             ="
echo "=  4 - Activation de la carte réseau                           ="
echo "=  5 - Descativation de la carte réseau                        ="
echo "=  6 - Redémarrage de la carte réseau                          ="
echo "=  7 - Faire une copie des fichiers de config                  ="
echo "=      interfaces & resolv.conf                                ="
echo "=  8 - Quitter le programme                                    ="
echo "=                                                              ="
echo "=  Note : Toutes vos actions seront enregistré dans un log     ="
echo "=           pour qui se trouve dans fichier se trouvant        ="
echo "=       au même endroit que ce fichier nommé scriptlog.txt     ="
echo "=      pour le supprimer taper "clean" dans les choix            ="
echo "=                                                              ="
echo "=                                                              ="
echo "=  ATTENTION : POUR LE CHANGEMENT D'ADRESSE IL EST RECOMMENDé  ="
echo "=     DE FAIRE UNE COPIE DES FICHIERS DE CONFIGURATIONS        ="
echo "=     "interfaces" & "resolv.conf" EN FAISANT L'OPTION 6           ="
echo "=         DANS LE SCRIPT OU LE FAIRE MANUELLEMENT              ="
echo "=                                                              ="
echo "================================================================"
#
echo -n "Action à faire : "
#
read choix
#
#
# =============Affichage des interfaces résaeaux==========
#
	if [ $choix = "1" ]
	then
		ip -c a >> scriptlog.txt 
		cat scriptlog.txt >> showipa.txt
		cat showipa.txt >> scriptlog.txt
		
		echo "=======================================" >> scriptlog.txt
		echo "========== Action of user : 1 =========" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		
		date >> scriptlog.txt
		cat showipa.txt 							   >> scriptlog.txt
	
		echo "=======================================" >> scriptlog.txt
		echo "============ End of action ============" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		chmod 777 showipa.txt
		rm ./showipa.txt
		echo "Appuyer sur une touche pour continuer..."
		read pop
		./ipperso.sh
	else
#
# ==============changement d'ip réseau====================
# dans cette partie l'utilisateur donnera les information
# suivantes : - adresse ip --> sous la variable "ipaddr"
#			  - masque réseau --> sous la variable "msk"
#			  - passerelle --> sous la valriable "gtw"
#			  - le dns --> sous la varianble "dns"
	if [ $choix = "2" ]
	then
		echo -n "Entrer le nom de votre carte réseau : "
		read interfacename
		echo -n "Entrer votre adresse ip : "
		read ipaddr
		echo -n "Entrer votre masque réseau : "
		read msk
		echo -n "Entrer votre passerelle : "
		read gtw
		echo -n "Entrer votre dns : "
		read dns
# a cet instant on édite un nouveau fichier interface
# on aura fait une copie de l'original au préalable ^^		
#
		rm /etc/network/interfaces
		rm /etc/resolv.conf
		echo "# This file describes the network interfaces available on your system" >> /etc/network/interfaces
		echo "# and how to activate them. For more infomation, see interfaces(5)." >> /etc/network/interfaces
		echo "" >> /etc/network/interfaces
		echo "source /etc/network/interfaces.d" >> /etc/network/interfaces
		echo "# The loopback network interface" >> /etc/network/interfaces
		echo "auto lo" >> /etc/network/interfaces
		echo "iface lo inet loopback" >> /etc/network/interfaces
		echo "# param. interface ethernet" >> /etc/network/interfaces
		echo "auto $interfacename" >> /etc/network/interfaces
		echo "	iface $interfacename inet static" >> /etc/network/interfaces
		echo "	address $ipaddr" >> /etc/network/interfaces
		echo "	net mask $msk" >> /etc/network/interfaces
		echo "	gateway $gtw" >> /etc/network/interfaces
		echo "# Generated by NetworkManager">> /etc/resolv.conf
		echo "search home" >> /etc/resolv.conf
		echo "nameserver 192.168.1.1" >> /etc/resolv.conf
		echo "nameserver $dns" >> /etc/resolv.conf
		echo "les changements sont fait veuillez redémarrer le service réseau"
		echo "Appuyer sur une touche pour continuer ..."
		read pop
#
		echo "=======================================" >> scriptlog.txt
		echo "========== Action of user : 2 =========" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		date >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		echo "============= Changement ==============" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		cat /etc/network/interfaces >> scriptlog.txt
		cat /etc/resolv.conf >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		echo "============ End of action ============" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		./ipperso.sh
#
	else
#============= Parametre en ip dynamique ==============
	if [ $choix = "3" ]
	then
		echo -n "Nom de l'interface réseau : "
		read interfacename
# on éfface le fichier de configuraiton "interfaces" et on en refait un autre
		rm /etc/network/interfaces
		echo "# This file describes the network interfaces available on your system" >> /etc/network/interfaces
		echo "# and how to activate them. For more infomation, see interfaces(5)." >> /etc/network/interfaces
		echo "" >> /etc/network/interfaces
		echo "source /etc/network/interfaces.d" >> /etc/network/interfaces
		echo "# The loopback network interface" >> /etc/network/interfaces
		echo "auto lo" >> /etc/network/interfaces
		echo "iface lo inet loopback" >> /etc/network/interfaces
		echo "# param. interface ethernet" >> /etc/network/interfaces
		echo "auto $interfacename" >> /etc/network/interfaces
		echo "	iface $interfacename inet dhcp" >> /etc/network/interfaces
		echo "les changements sont fait veuillez redémarrer le service réseau"
		echo "Appuyer sur une touche pour continuer ..."
		read pop
#
#
		echo "=======================================" >> scriptlog.txt
		echo "========== Action of user : 3 =========" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		date >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		echo "============= Changement ==============" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		cat /etc/network/interfaces >> scriptlog.txt
		cat /etc/resolv.conf >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		echo "============ End of action ============" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		./ipperso.sh
	else
#
#
#
#
# ============activation de la carte réseau==========
	if [ $choix = "4" ]
	then
		echo -n "Nom de l'interface réseau : "
		read interfacename
		ip link set $interfacename up
		echo "=======================================" >> scriptlog.txt
		echo "========== Action of user : 4 =========" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		date										   >> scriptlog.txt
		echo "ip link set $interfacename up" 		   >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		echo "============ End of action ============" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt

		echo "$interfacename est maintenant activé"
		read pop
		./ipperso.sh
	else
# ============desactivation de la carte réseau=======
#
	if [ $choix = "5" ]
	then
		echo -n "Nom de l'interface réseau : "
		read interfacename
		ip link set $interfacename down
		echo "=======================================" >> scriptlog.txt
		echo "========== Action of user : 5 =========" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		date 								    	   >> scriptlog.txt
		echo "ip link set $interfacename down"		   >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		echo "============ End of action ============" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt

		echo "$interfacename est maintenant desactivé"
		read pop
		./ipperso.sh
	else
#
# ============Redémarrage des services================
	if [ $choix = "6" ]
	then
		systemctl restart networking.service
		echo "=======================================" >> scriptlog.txt
		echo "========== Action of user : 6 =========" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		date 										   >> scriptlog.txt
		echo "systemctl restart networking.service"	   >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		echo "============ End of action ============" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		echo "Service redémarrer !!"
		echo "Appuyer sur une touche pour continuer"
		read pop
		./ipperso.sh
	else
#
#
# =================Copie des fichiers interfaces et resolv.conf=========
	if [ $choix = "7" ]
	then
	cp /etc/network/interfaces /etc/network/interfaces.O
	cp /etc/resolv.conf /etc/resolv.conf.O
		echo "fichiers de configuration copiés !!!"
	read pop
		echo "=======================================" >> scriptlog.txt
		echo "========== Action of user : 7 =========" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		date										   >> scriptlog.txt
		echo "cp /etc/network/interfaces /etc/network/interfaces.O" >> scriptlog.txt
		echo "cp /etc/resolv.conf /etc/resolv.conf.O"  >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
		echo "============ End of action ============" >> scriptlog.txt
		echo "=======================================" >> scriptlog.txt
	./ipperso.sh
	else	
# =======================on quitte le programme=========================
	if [ $choix = "8" ]

	then exit
	else
#
# ==============on supprime le fichier de log============
#
	if [ $choix = "clean" ]
	then
		rm scriptlog.txt
		echo "le fichier scriptlog.txt est supprimé"
		read pop
		./ipperso.sh
	else
		./ipperso.sh
#
#
#
#
# =============fermeture des conditions=============
fi
fi
fi
fi
fi
fi
fi
fi
fi
