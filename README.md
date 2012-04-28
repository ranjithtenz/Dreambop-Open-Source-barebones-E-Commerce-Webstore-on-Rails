Dreambop-Open-Source-barebones-E-Commerce-Webstore-on-Rails
===========================================================

E-Commerce Webstore using rails 3.0.3 (upgrade to come soon)

This store is mainly a barebones kind of set up for the basic things you need when making a store such as, products, images, related products, categories, shopping cart, checkout, credit card validation, and about us pages... with some facebook and javascript integration for fun things like values and stuff.  

The site this project is live on is at Dreambop.com  - Using NgninX and passenger
You can basically see how this store looks with more than a few products in the DB but without being able to start the checkout process. 

To get this site up and running - make sure you have ruby, and ruby gem package management, and rake installed.  
download/or clone this project from github

Then:

1) Set up your database info in ./config/database.yml


2)
Make sure you have the required gems:

rake gems:install


3)
There is a product_snapshot.sql file in ./ that you can import into your database so that when you run this code you will see example products being displayed. 
e.g.

mysql db_name -u user -p < product_snapshot.sql

//make sure the db_name is the same one as what you set up in ./config/database.yml


3b)
Alternative you can have a vanilla database with 

rake db:migrate


NOTES:

./script/xml   has scripts to create an upload feed to google products (froogle)


please contact me or donate to

matt@dreambop.com


Thanks, enjoy responsibly. One thing to note is that if you are planning on selling things online, be sure only to ship to billing addressees matched on the credit card when doing your verification. Otherwise you risk losing that product to chargebacks, and not getting to keep the money charged to the credit card.  Email me for more info on that if you need help or advice. Always happy to help. Have fun. 
