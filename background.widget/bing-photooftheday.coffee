# Created by Sam Roach 1/21/2016
# Bing's photo of the day backgroud with a fade to black at the bottom of the screen to make a more usable space for other widgets.

command: """
curl -s 'http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=en-US'
"""

# Set the refresh frequency.
refreshFrequency: '1h'

style: """
  top: 0%
  left: 0%
  color: #fff
  
  .wrapper
    width: 100%
    display: block
    text-align: center
  
  .wallpaper
    position: absolute
    width: 150%
    text-align: center
    z-index: -1000

  .wallpaper img 
    width: auto
    z-index: -10000
    box-shadow: inset 0 0 10px #000000;

  .darker
    width: 1920px
    height: 300px
    color: green
    top: 900px
    position: absolute
    z-index: -9998
    background: linear-gradient(0deg, black, rgba(0, 0, 0, 0));

"""

render: -> """
<div id='background'></div>
<div class='darker'></div>

"""

# Update the rendered output.
update: (output, domEl) ->
  mydiv = $(domEl).find('#background')
  html = ''
  xmlDoc = $.parseXML( output )
  xml = $( xmlDoc )
  imgsrc = xml.find('url').text()
  html += "<div class='wrapper'><div class='wallpaper'><img src='http://www.bing.com/" + imgsrc + "' height='" + $(window).height() + "' /></div>"
  html += "</div>"
  
  # Set the output
  mydiv.html(html)
