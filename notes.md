
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
