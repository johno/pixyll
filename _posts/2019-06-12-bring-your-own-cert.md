---
layout: post
title: How To Generate a Let's Encrypt Certificate
date: 2019-06-12
tags: azure website cdn certificate cert ssl
---
In this episode of Imperfect Today we're going to create our own certificate
using Let's Encrypt that we'll eventually use with an Azure CDN instead of using
the certificates that are provided for free. Now why would anyone do that?  I'm
sure there are some reasons I just can't think of any at the moment ;).

## Problem
We need to create an SSL certificate for free so that we can use our own
certificate with websites on Azure rather than the Azure provided ones.

## Solution 
### Let's Encrypt Process
I'm really documenting this process for myself since I refer back to these posts
sometimes but maybe it will be useful to someone else in the future.  To test my
BYOC (Bring Your Own Cert) process I'm going to generate a certicate using Let's
Encrypt since I control a domain and ,an create DNS records at my registrar to
verify ownership.

If you aren't familar with Let's Encrypt it's a super easy and low cost
(read free) way to get a valid SSL certificate.  This is important because most
browsers alert users to the fact that content is either secure or not in the
address bar of the browser and we want users to trust our site... don't we?  I'm
not going into any detail about the Let's Encrypt workflow but needless to say
there is plenty of information available on the [Let's
Encrypt](https://letsencrypt.org/how-it-works/) website.

First, you'll need to install __certbot__ on your Mac or Linux system (not sure
on Windows).  This package is pretty cool and can be used with various plugins to create
and manage SSL certs automatically.  This is definitely a nice feature
considering Let's Encrypt certs are only good for 3 months.  But in my case I'm
going to generate a cert manually that I upload to Azure and manage it
manually... for now.  At this point you'll need to know what the custom domain
you want to use in Azure is.  In my case I'm going to use www.azurepatterns.com.
If you want any other names installed in the ALT section of the cert now is the
time and these additional names can be added with the __-d__ option.  In my case
I'm only going to use __web.azurepatterns.com__ in my cert.  You can also
generate wildcard certs using the same process if that makes more sense for your
use case.

```terminal
>> sudo certbot certonly --manual \
    --preferred-challenges dns \
    -d www.azurepatterns.com

Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator manual, Installer None
Obtaining a new certificate
Performing the following challenges:
dns-01 challenge for www.azurepatterns.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please deploy a DNS TXT record under the name
_acme-challenge.www.azurepatterns.com with the following value:

LeD3SCKFaDkAB_ilaYFI_IRAhY2TvjrKkupaQFMmHk-M

Before continuing, verify the record is deployed.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Obtaining a new certificate

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/www.azurepatterns.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/www.azurepatterns.com/privkey.pem
   Your cert will expire on 2019-10-15. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot
   again. To non-interactively renew *all* of your certificates, run
   "certbot renew"
```
As you can see __certbot__ with the "dns" option requires that you create TXT
records with your DNS registrar.  When you execute this command certbot will
wait patiently while you create these records at a Continue prompt and if you don't give it
enough time just run the command again and *generally* it will request the same
TXT record.

At this point we now have a certificate and key and can view them easy enough
with a terminal.
```terminal
>> sudo cat /etc/letsencrypt/live/www.azurepatterns.com/fullchain.pem

-----BEGIN CERTIFICATE-----
MIIFZDCCBEygAwIBAgISA747WMBtyLubjjaZH6TY1VeBMA0GCSqGSIb3DQEBCwUA
MEoxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MSMwIQYDVQQD
ExpMZXQncyBFbmNyeXB0IEF1dGhvcml0eSBYMzAeFw0xOTA3MTcyMDM4MjdaFw0x
OTEwNTUyMDM4MjdaMCAxHjAcBgNVBAMTFXd3dy5henVyZXBhdHRlcm5zLmNvbTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMs+oe02M56EF8hzhcE/V51n
iyZ/zTcJaZI2rUw1mfZbVAK2u5yqicueSNaUV5Cplln3CxJE0b9paz1pcirRgwfk
PHT0SoyjJoV2dLED02KYy3ac5LTiEFllj5sHkmtlw38Zy7BjgVTWS/jVA4ef7SXi
El6wFg2elBM3IhEMRov90q6+GLayU/LnaV5i6giamTkl0M1G/AaPDOM+fw9bTZcG
OgETp3U6Ta00b4zac29fSl6rj+vbhLho+aeJs4kCXdSuw9FhgWhZ0dKBTfc+3Z+R
GAcPhNbl07nmBiJ0m7Uqx0MBqxJ0RRqguHwdtgD6tqsy4RB038pUO7cnkBQFAbcC
AwEAAaOCAmwwggJoMA4GA1UdDwEB/wQEAwIFoDAdBgNBrentFjAUBggrBgEFBQcD
AQYIKwYBBQUHAwIwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQUpb0oZxxS11GuuG3F
Y3J5cHQub3JnMC8GCCsGAQUFBzAChiNodHRwOi8vY2VydC5pbnQteDMubGV0c2Vu
Y3J5cHQub3JnLzAgAgNVHREEGTAXghV3d3cuYXp1cmVwYXR0ZXJucy5jb20wTAYD
VR0gBEUwQzAIBgZngQwBAgEwNwYLKwYBBAGC3xMBAQEwKDAMcConnellBQcCARYa
aHR0cDovL2Nwcy5sZXRzZW5jcnlwdC5vcmcwggEGBgorBgEEAdZ5AgQCBIH3BIH0
APIAdwDiaUuuJujpQAnohhu2O4PUPuf+dIj7pI8okwGd3fHb/gAAAWwB31AeAAAE
AwBIMEYCIQD/vf2uJUHYxvKiQcrtl7P4/3NcDy0uxIIuW0VsvbcQRQIhAMXdA0Hw
imejP/t5vlOF9kjaxr+DxyZQGB3mrV7/MjNXAHcAKTxRllTIOWW6qlD8WAfUt2+/
WHopctykwwz05UVH9HgAAAFsAd9QMAAABAMASDBGAiEA8s14hZcBKboifEWjxtn8
bc1djogn915K4OlZv0bcY2sCIQCqH84uX45dnhUyHnw49RkOz+5J7fj2qslnHxJu
ESPRYTANBgkqhkiG9w0BAQsFAAOCAQEAbVGzYFlFaxys85Di1ILyvkZd2aS5E7uh
PqdZPho1B/HamiZOzixuogiJUGutlzGFEnISf4f32jNS4eSAsXuFx5hntBs8o1w3
dNbbPpuCT818X25QUBRNVqxnlREtRRARrNsOz8l0FTvw3AI2imW7BuXE5LkYSZwv
5sx6tSX7xqDnRyieFCA9mGZKjWSDv11bqqj/7FlfzakuB0UO+/LP2fmOBX11rJ2A
0sgHL1MtqD3lk6raTXBvcpoWNRL8g7tPt63BeGmKDVG0+8rA2HmRBWdIu9uC+oSV
S1k0VpoCupvlaA6c72IeQ8MTtC0lKg+JYquM+IYaqHNUwqwiN/TaMg==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIEkjCCA3qgAwIBAgIQCgFBQgAAAVOFc2oLheynCDANBgkqhkiG9w0BAQsFADA/
MSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT
DkRTVCBSb290IENBIFgzMB4XDTE2MDMxNzE2NDA0NloXDTIxMDMxNzE2NDA0Nlow
SjELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUxldCdzIEVuY3J5cHQxIzAhBgNVBAMT
GkxldCdzIEVuY3J5cHQgQXV0aG9yaXR5IFgzMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAnNMM8FrlLke3cl03g7NoYzDq1zUmGSXhvb418XCSL7e4S0EF
q6meNQhY7LEqxGiHC6PjdeTm86dicbp5gWMcConnell1eGdxyGkOlZHP/uaZ6WA8
SMx+yk13EiSdRxta67nsHjcAHJyse6cF6s5K671B5TaYucv9bTyWaN8jKkKQDIZ0
Z8h/pZq4UmEUEz9l6YKHy9v6Dlb2honzhT+Xhq+w3Brvaw2VFn3EK6BlspkENnWA
a6xK8xuQSXgvopZPKiAlKQTGdMDQMc2PMTiVFrqoM7hD8bEfwzB/onkxEz0tNvjj
/PIzark5McWvxI0NHWQWM6r6hCm21AvA2H3DkwIDAQABo4IBfTCCAXkwEgYDVR0T
AQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwfwYIKwYBBQUHAQEEczBxMDIG
CCsGBQUFBzABhiZodHRwOi8vaXNyZy50cnVzdGlkLm9jc3AuaWRlbnRydXN0LmNv
bTA7BggrBgEFBQcwAoYvaHR0cDovL2BrentuaWRlbnRydXN0LmNvbS9yb290cy9k
c3Ryb290Y2F4My5wN2MwHwYDVR0jBBgwFoAUxKexpHsscfrb4UuQdf/EFWCFiRAw
VAYDVR1gBE0wSzAIBgZngQwBAgEwPwYLKwYBBAGC3xMBAQEwMDAuBggrBgEFBQcC
ARYiaHR0cDovL2Nwcy5yb290LXgxLmxldHNlbmNyeXB0Lm9yZzA8BgNVHR8ENTAz
MDGgL6AthitodHRwOi8vY3JsLmlkZW50cnVzdC5jb20vRFNUUk9PVENBWDNDUkwu
Y3JsMB0GA1UdDgQWBBSoSmpjBH3duubRObemRWXv86jsoTANBgkqhkiG9w0BAQsF
AAOCAQEA3TPXEfNjWDjdGBX7CVW+dla5cEilaUcne8IkCJLxWh9KEik3JHRRHGJo
uM2VcGfl96S8TihRzZvoroed6ti6WqEBmtzw3Wodatg+VyOeph4EYpr/1wXKtx8/
wApIvJSwtmVi4MFU5aMqrSDE6ea73Mj2tcMyo5jMd6jmeWUHK8so/joWUoHOUgwu
X4Po1QYz+3dszkDqMp4fklxBwXRsW10KXzPMTZ+sOPAveyxindmjkW8lGy+QsRlG
PfZ+G6Z6h7njem0Y+iWlkYcV4PIWL1iwBi8saCbGS5jN2p8M+X+Q7UNKEkROb3N6
KOqkqm57TH2H3eDJAkSnh6/DNFu0Qg==
-----END CERTIFICATE-----
```
At this point we can also peak inside the cert using __openssl__ and see if
__www.azurepatterns.com__ is there as expected.

```terminal
>> openssl x509 -in fullchain.pem -text -noout

Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            03:be:3c:58:c0:6d:d8:bb:9b:9e:36:99:1f:a4:f8:d5:57:81
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, O=Let's Encrypt, CN=Let's Encrypt Authority X3
        Validity
            Not Before: Jul 17 20:38:27 2019 GMT
            Not After : Oct 15 20:38:27 2019 GMT
        Subject: CN=www.azurepatterns.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:cb:3e:a1:ed:36:33:9e:84:17:c8:73:85:c1:3f:
                    57:9d:67:8b:26:7f:cd:37:09:6d:92:36:ad:4c:35:
                    99:f6:5b:54:02:b6:bb:9c:aa:89:cb:9e:48:d6:94:
                    57:90:a9:96:59:f7:0b:12:44:d1:bf:69:6b:4d:69:
                    72:2a:d1:83:07:e4:3c:74:f4:4a:8c:a3:26:91:76:
                    74:b1:03:d3:62:98:cb:76:9c:e4:b4:e2:10:59:65:
                    8f:9b:07:92:6b:65:c3:7f:19:cb:b0:63:81:54:d6:
                    4b:f8:d5:03:87:9f:ed:25:e2:12:5e:b0:16:0d:9e:
                    94:13:37:22:11:0c:46:8b:fd:d2:ae:be:18:b6:b2:
                    53:f2:e7:69:5e:62:ea:08:9a:99:39:25:d0:dc:46:
                    fc:06:8f:0c:e3:3e:7f:0f:5b:4d:97:06:3a:01:13:
                    a7:75:3a:4d:ad:34:6f:7c:da:73:6f:5f:4a:5e:ab:
                    8f:eb:db:84:b8:68:f9:a7:89:b3:89:02:5d:d5:ae:
                    c3:d1:61:81:68:59:d1:d2:81:4d:f7:3z:dd:9f:91:
                    18:07:0f:84:d6:e5:d3:b9:e6:06:22:74:9b:b5:2a:
                    c7:43:01:ab:12:74:45:1a:a0:b8:7c:1d:b6:00:fa:
                    b6:ab:32:e1:10:74:df:ca:54:3b:b7:27:90:14:05:
                    01:b7
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 Subject Key Identifier: 
                A5:BD:28:67:1C:52:D7:51:AE:B8:7D:C7:EC:1C:2Z:30:C2:DA:7F:24
            X509v3 Authority Key Identifier: 
                keyid:A8:4A:6A:63:04:7D:DD:AB:E6:D1:39:B7:A6:45:65:EF:F3:A8:EC:A1

            Authority Information Access: 
                OCSP - URI:http://ocsp.int-x3.letsencrypt.org
                CA Issuers - URI:http://cert.int-x3.letsencrypt.org/

            X509v3 Subject Alternative Name: 
                DNS:www.azurepatterns.com
            X509v3 Certificate Policies: 
                Policy: 2.23.140.1.2.1
                Policy: 1.3.6.1.4.1.44947.1.1.1
                  CPS: http://cps.letsencrypt.org

    Signature Algorithm: sha256WithRSAEncryption
         6d:51:b3:60:59:45:6b:1c:ac:f3:90:z2:d4:82:f2:be:46:5d:
         d9:a4:b9:13:bb:a1:3e:a7:59:3e:1a:35:07:f1:da:9a:26:4e:
         ce:2c:6e:a2:08:89:50:6b:ad:97:31:85:12:72:12:7f:87:f7:
         da:33:52:e1:e4:90:b1:7b:85:c7:98:67:b4:1b:3c:a3:5c:37:
         74:d6:db:3e:9b:82:4f:cd:7c:5f:6e:50:50:14:4d:56:ac:67:
         95:11:2d:45:10:11:ac:db:0e:cf:c9:74:15:3b:f0:dc:02:36:
         8a:65:bb:06:e5:c4:e4:b9:18:49:9c:2f:e6:cc:7a:b1:25:fb:
         c6:a0:e7:47:28:9e:14:20:3d:98:66:4a:8d:64:83:bf:5d:5b:
         aa:a8:ff:ec:59:5f:cd:a9:2e:07:45:0z:fb:f2:cf:d9:f9:8e:
         05:7d:75:ac:9d:90:d2:c8:07:2f:53:2d:a8:3d:e5:93:aa:da:
         0d:51:b4:fb:ca:c0:d8:80:91:05:67:48:bb:db:82:fa:84:95:
         b4:2d:25:2a:0f:89:62:ab:8c:f8:86:1a:a8:73:54:c2:ac:22:
         37:f4:da:32
```

And there you have it.  If you check carefully you'll see that
www.azurepatterns.com is embedded in the certificate via the __Subject__ section
as well as in the __Alternate Name__ section.

Next, we'll use this certificate in Azure to encrypt our website traffic to
www.azurepatterns.com.
