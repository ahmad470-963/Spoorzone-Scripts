
# Spoorzone Bibliotheek - Netwerk & Security Validatie

Welkom bij de repository voor het netwerkvalidatie-script van De Spoorzone Bibliotheek. Dit PowerShell-script is ontworpen om werkplekken geautomatiseerd te testen op correcte netwerksegmentatie (VLAN's), DHCP-toewijzingen en Zero Trust firewall-regels (pfSense).

## 🎯 Doel van het script
Binnen dit project scheiden we beheerders, medewerkers en gasten via VLAN's. Om de veiligheid te garanderen, mag regulier verkeer niet bij de beheerinterface van de pfSense-router komen. Dit script automatiseert de controle hiervan, wat tijd bespaart en menselijke fouten (zoals typefouten in IP-adressen) voorkomt.

## ⚙️ Functionaliteiten
Wanneer het script wordt uitgevoerd, controleert het autonoom de volgende zaken:
1. **Netwerkconfiguratie:** Detecteert de actieve netwerkadapter en haalt IP-adres, Default Gateway en DNS-server op (bewijs van werkende DHCP).
2. **DNS Firewall Test:** Controleert of TCP-poort 53 naar de gateway openstaat voor noodzakelijk naamsresolutie-verkeer.
3. **Zero Trust Validatie (HTTPS):** Verifieert of TCP-poort 443 richting de gateway *geblokkeerd* is, zodat gebruikers niet op de router-interface kunnen inloggen.
4. **Praktijktest DNS:** Test via `Resolve-DnsName` of externe websites (zoals www.google.com) succesvol vertaald worden.

## 🚀 Hoe te gebruiken
Het script is geschreven in native PowerShell en vereist geen externe modules (zoals Nmap). 

1. Zorg dat de client-pc verbonden is met een VLAN (bijv. VLAN 20 of 30) in de GNS3-omgeving.
2. Open **PowerShell ISE** (aanbevolen voor kleurweergave) of een standaard PowerShell-terminal.
3. Kopieer de code uit `VLAN-Scanner.ps1` of voer het bestand direct uit:
   ```powershell
   .\VLAN-Scanner.ps1
