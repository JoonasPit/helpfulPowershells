Periaatteessa tuo metodi toimii, mutta jos siitä haluteaan eroon voidaan ottaa käyttöön tämä

Invoke-Cmd-metodi, joka sitten vaatii tämän Enter-PSSessionin

Jotta tämä toimisi täytyisi jokaiselle skriptille erikseen kirjoittaa 9-ympäristössä ajettava skripti, jota
sitten kutsuttaisiin ensin 9-ympäristön cmd:llä.

Oma kone ei ainakaan ole ns trustedhost listalla, mitä tulee ympäristöön, ja
pitäisi lisätä toisen palvelimen:in TrustedHost listaan, jotta tämä onnistuisi.

Jotta skriptin suoritus toimisi ilman passwordpromptia, tässä PS-versiossa pitäisi mielestäni käyttää
-CertificateThumbprintiä, joka vaatii annetun certifikaatin. Linkki alla. Tai vaihtoehtoisesti skriptata
koko autentikaatioprosessi, johon on myöskin linkki alla.

Päivittämällä PS-versioon 6.0 (Nykyinen 5.1) tämä voidaan skipata ja autentikaatio voidaan suoraan suorittaa
ssh:lla, jossa voi sitten antaa passun filessä, joka sitten skippaa koko autentikaatioprosessin.

Saattaa toimia myös ilman autentikaatiota, jos yhteys on vain sallituissa yhteyksissä. Tätä täytyisi testata
enabloimalla wman:i

wmanin on enabloitu og-palvelimella:lla, mutta sen trusted hosts listaan pitäisi lisätä koneita, jotta ps-skriptejä voi
ajaa. komento alla
set-item wsman:\localhost\Client\Trustedhosts -value "komentaja-ip"



Peruskamaa ps-
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/enter-pssession?view=powershell-6

Autentikaation syöttöskripti || https://powershell.org/forums/topic/is-it-possible-to-pass-credentials-to-a-new-ps-session/
Autentikaatio sertifikaatilla || https://devblogs.microsoft.com/scripting/getting-started-with-powershell-the-certificate-provider/
Remotekomennot PS:llä https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_remote_jobs?view=powershell-6
