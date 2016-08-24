default_topics = [
  "javascript",
  "ruby",
  "html",
  "css",
  "bootstrap",
  "rails",
  "sinatra"
]

default_topics.each do |topic|
  t = Topic.new
  t.name = topic
  t.save
end