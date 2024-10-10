on azure create an enterprise application under microsoft entra id

add the basic saml configuration
![image](https://github.com/user-attachments/assets/2c17557f-ee2a-40ca-a5ea-17ed6cf6e9f2)


unzip app/php-saml-2.20.0.zip to app/saml

![image](https://github.com/user-attachments/assets/43d243d7-475b-4425-8893-45b00f527756)

create app/settings.php with the below content

```
<?php

return array(
    'strict' => true,
    'debug' => true,
    'sp' => array(
        'entityId' => 'localhost-sso',  // The Identifier (Entity ID) from Azure
        'assertionConsumerService' => array(
            'url' => 'http://localhost/?acs',  // The ACS URL from Azure
        ),
        'singleLogoutService' => array(
            'url' => 'http://localhost/?slo',
        ),
    ),
    'idp' => array(
        'entityId' => '( ... url1 )',  // Replace with your Azure AD tenant's metadata entity ID
        'singleSignOnService' => array(
            'url' => '( ... url2 )',  // Azure Entra SAML login URL
        ),
        'x509cert' =>
"-----BEGIN CERTIFICATE-----
( ... certificate content .... )
-----END CERTIFICATE-----", 
    ),
);

```

The certificate content can be downloaded from the SAML page of the application (**Certificate (Base64)**).

entityId is the **Microsoft Entra Identifier URL**

url for isngleSignOnService is **Login URL**

## docker

run with **docker compose up -d**

## running the application

go to http://localhost

![image](https://github.com/user-attachments/assets/c6ce78c7-6926-4d69-9bc8-9d0ad61807fa)

click the link and go through authentication (need to be authorized in azure)

after logging in, the sample displays some information (attributes)

an example:

![image](https://github.com/user-attachments/assets/9d728763-9e83-4c2e-ad2b-04365b6da100)
