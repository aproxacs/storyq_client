= storyq_client

* Homepage: http://www.aproxacs.com/166
* Author: aproxacs

== DESCRIPTION:
StoryQ client Library
This library makes it easy to use storyq's Open API. 
You can easily upload documents and photos to the storyq and convert them to the flash slide with this library. 
This follows the restful style but not uses active_resource.

This is mainly refered to the active_resource and springnote_client gem.
Specially thanks to the springnote_client.

== FEATURES/PROBLEMS:


== SYNOPSIS:

# create a storyq instance
storyq = Storyq(
  :consumer_token => "CONSUMER_TOKEN",
  :consumer_secret => "CONSUMER_SECRET",
  :access_key => "ACCESS_TOKEN",
  :access_secret => "ACCESS_SECRET")

# Get all boxes
boxes = storyq.boxes.find :all                          # returns 20 recent boxes
boxes = storyq.boxes.find :all :page => 2               # returns 21-40 boxes 
boxes = storyq.boxes.find :all :page => 2, :per_page=>3 # returns 21-23 boxes 
boxes = storyq.slide_boxes.find :all                    # returns 20 recent slide boxes
boxes = storyq.photo_boxes.find :all                    # returns 20 recent photo boxes

# Get my boxes
boxes = storyq.boxes.find :mine     # returns 5 boxes belongs to the current authenticated user.
boxes = storyq.slide_boxes.find :mine

# Get a box
box = storyq.boxes.find 1234    # returns a box whose id is 1234
puts box.title

# Update a box
box.title = "my world"
box.tags = "some, tags"
box.save

# Destory a box
box.destory

# Create a slide box
storyq.slide_boxes.create(
    "filename" => "A_FILE.ppt", 
    "title" => "TITLE", 
    "description" => "DESCRIPTION", 
    "tags" => "SOME, TAGS", 
    "category" => "여행", 
    "permission" => "public")

# Create a photo box
pbox = storyq.photo_boxes.create( 
    "title" => "TITLE", 
    "description" => "DESCRIPTION", 
    "tags" => "SOME, TAGS", 
    "category" => "여행", 
    "permission" => "public")

# Add a photo to photo box 
photo = pbox.add_photo( 
        "filename" => "A_IMAGE.jpg",
        "title" => "TITLE",
        "note" => "SOME NOTES FOR THE PICTURE")

# get photo box's photos
photos = pbox.photos

# update a photo
photo.title = "NEW TITLE"
photo.note = "NEW NOTE"
photo.save

# delete a photo
photo.destory

== REQUIREMENTS:
* active_support
* oauth

== INSTALL:

* sudo gem install storyq_client

== LICENSE:

(The MIT License)

Copyright (c) 2008 Bryan Kang

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.