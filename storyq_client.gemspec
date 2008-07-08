Gem::Specification.new do |s|
  s.name = "storyq_client"
  s.version = "0.0.2"
  s.date = "2008-07-09"
  s.summary = "StoryQ client Library"
  s.email = "aproxacs@gmail.com"
  s.homepage = "http://www.aproxacs.com/166"
  s.description = "This library makes it easy to use storyq's Open API. 
    You can easily upload documents and photos to the storyq and convert them to the flash slide with this library. 
    This follows the restful style but not use active_resource."
  s.has_rdoc = true
  s.authors = ["aproxacs"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "lib/storyq_client.rb", "lib/storyq_client/base.rb", 
    "lib/storyq_client/box.rb", "lib/storyq_client/photo.rb", "lib/storyq_client/resource.rb", 
    "lib/storyq_client/token.rb", "lib/storyq_client/upload.rb"]
  s.test_files = ["test/base_spec.rb"]
  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency("activesupport", ["> 2.0.2"])
  s.add_dependency("oauth", ["> 0.2.4"])
end
