default_topics = [
  "Javascript",
  "Ruby",
  "HTML",
  "CSS",
  "Bootstrap",
  "Rails",
  "Sinatra"
]

default_topics.each do |topic|
  t = Topic.new
  t.name = topic
  t.save
end