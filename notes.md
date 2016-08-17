
models

* user
    * has-many notes
* topics/categories
    * has_many: :note_topics
    * has_many: :notes, through: :note_topics
* note
    * has-many: :topics
    * has_many: :topics, through: :note_topics
note_topics(JOIN TABLE)
    * belongs to note
    * belongs to topic


Create migrations
Migrate to create tables and columns
Use tux to seed the DB and play around to make sure things are working



make database postgres (NOT sqlite)

https://samuelstern.wordpress.com/2012/11/28/making-a-simple-database-driven-website-with-sinatra-and-heroku/