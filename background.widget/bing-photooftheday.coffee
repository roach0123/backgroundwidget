# Created by Sam Roach
# Bing's photo of the day backgroud with a fade to black at the bottom of the screen to make a more usable space for other widgets.

command: """
curl -s 'http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=en-US'
"""
# 
# Set the refresh frequency.
refreshFrequency: '12h'

style: """

  .wrapper
    width: 100%
    display: block
    text-align: center
  
  .wallpaper
    position: absolute
    text-align: center
    z-index: -999
    

  .wallpaper img 
    width: auto
    z-index: -1000

  .darker 
    background: linear-gradient(to top, #000000, rgba(0,0,0,0) 500px)
    position: absolute
    top: 0
    bottom: 0
    left: 0
    right: 0
    

"""

render: (output) -> """
<div id='background'></div>
"""

# Update the rendered output.
update: (output, domEl) ->
  mydiv = $(domEl).find('#background')
  html = ''
  xmlDoc = $.parseXML( output )
  xml = $( xmlDoc )
  width = $(window).width()
  imgsrc = 'http://www.bing.com/' + xml.find('url').text()
  html += "<div class='wrapper'><div class='wallpaper'><img src='" + imgsrc + "' height='" + $(window).height() + "px' /><div class='darker'></div></div>"
  html += "</div>"

  # Set the output
  mydiv.html(html)
