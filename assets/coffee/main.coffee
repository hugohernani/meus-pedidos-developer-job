ContactMVC = {}
class ContactMVC.Gui
  constructor: (@app, nav_index) ->
    @nav = $(nav_index)

  activate_current_link: ()=>
    for li in @nav.find("li")
      if (li.children[0]['href'] == location.href)
        $(li).addClass("active")
      else
        $(li).removeClass("active")

class ContactMVC.App
  constructor: (nav_index) ->
    @gui = new ContactMVC.Gui(this, nav_index)

  start: =>
    @gui.activate_current_link()

$(document).ready =>
  app = new ContactMVC.App("#main_index")
  app.start()
