# Created by Sam Roach 1/21/2016
# Bing's photo of the day backgroud with a fade to black at the bottom of the screen to make a more usable space for other widgets.

command: """
curl -s 'http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=en-US' | grep -E -m 1 -o '<url>(.*)</url>' | sed -e 's,.*<url>\([^<]*\)</url>.*,\1,g'
"""

# Set the refresh frequency.
refreshFrequency: '1h'

style: """
  top: 0%
  left: 0%
  color: #fff
  
  .wallpaper
    position: absolute
    z-index: -10000
    width: 100%

  .background
    width: 100%
    position: absolute
    z-index: -10000

  .myimage
    width: 2096px
    position: absolute
    z-index: -10000

  .darker
    width: 2096px
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
  outputhtml = output.replace("<url>", "").replace("</url>", "").replace(/(?:\r\n|\r|\n)/g, '').trim()
  html += "<div class='wallpaper'> "
  html += "<img src='http://www.bing.com" +outputhtml+ "' class='myimage' >"
  html += "</div>"
  
  # Set the output
  mydiv.html(html)
