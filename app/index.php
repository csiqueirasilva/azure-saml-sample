<?php
require_once('saml/_toolkit_loader.php'); // Adjust path to the OneLogin SAML toolkit

$settings = require('settings.php');  // Load your SAML settings

$auth = new OneLogin_Saml2_Auth($settings);

if (!isset($_SESSION)) {
    session_start();
}

if (isset($_GET['sso'])) {
    $auth->login();  // Redirect to Azure for SSO
} else if (isset($_GET['acs'])) {
    $auth->processResponse();
    $errors = $auth->getErrors();
    if (!empty($errors)) {
        echo "<pre>Errors occurred: ";
        print_r($errors);
        echo "</pre><br><pre>";
        echo "error: ".openssl_error_string() . "\n\n";
        echo $auth->getLastErrorReason();
        echo "</pre>";
    } else if (!$auth->isAuthenticated()) {
        echo "Authentication failed.";
    } else {
        echo "Welcome!";
        echo "<pre>";
        print_r($auth->getAttributes());
        echo "</pre>";
        echo '<div><a href="?slo">Logout</a></div>';
    }
} else if (isset($_GET['slo'])) {
    // Start the Single Logout process
    $auth->logout('http://localhost'); // You can specify the URL to redirect to after logout
} else {
    echo '<a href="?sso">Login with SSO</a>';
}
