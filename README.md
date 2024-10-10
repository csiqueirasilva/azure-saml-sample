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