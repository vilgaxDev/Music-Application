## Install Muzzie on CPanel

We recommend using a VPS machine. It is much better than shared hosting since it improves the performance of your app.


To upload Muzzie to CPanel you need to:

## 1. Upload Muzzie

Using CPanel file manager, go to your public_html make a new folder called muzzie and upload the content of your zip file there.

<img src="/assets/img/cpanel-file-manager.png">

## 2. Configure .htaccess

Go back to public_html, and create the following <code>.htaccess</code> file. Replace yourdomain with your actual domain.

        RewriteEngine on
        RewriteCond %{HTTP_HOST} ^yourdomain$ [NC,OR]
        RewriteCond %{HTTP_HOST} ^yourdomain$
        RewriteCond %{REQUEST_URI} !muzzie/public/
        RewriteRule (.*) muzzie/public/$1 [L]

## 3. Setup your domain

In your server panel, go to domains and create a new domain. In this case, we used muzzie.webkunft.com.

<img src="/assets/img/cpanel_add_domain.png">

## 3. Update Permissions

Now go inside the folder and change the permissions of the following folders to 777:

        /(root)
        storage
        resources/lang
        bootstrap/cache

by right-clicking on them and choosing "change permissions"

<img src="/assets/img/cpanel-folder-permission.png">

## 4. Check your domain

Now your app should be running at your domain. You should get an installer to help you configure your app and lunch it.


<img src="/assets/img/muzzie_installer.png">