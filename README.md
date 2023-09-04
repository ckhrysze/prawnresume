# Prawn Resume
Prawn based pdf resume generator

Simple script to generate a pdf resume. My information is hard coded within, but it would be easy to replace as the text is separate from the layout and generation.

There is no Gemfile or anything as I use prawn often enough to just have it globally, but at initial creation I used ruby 2.3 and prawn 2.1.

### Update 2023
Added icons via Prawn Icon `gem install prawn-icon`

Also, command I use, in case it ever leaves my history:

`ruby generator.rb && open resume.pdf`
