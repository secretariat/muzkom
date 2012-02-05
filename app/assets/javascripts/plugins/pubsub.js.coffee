window.Pubsub=
  events: ["click", "dblclick", "mouseover", "mouseout", "change", "blur", "focus", "submit", "keydown", "keyup", "keypress"]
  init: ->
    @.watch(action) for action in @.events

  watch: (action)->
    self = @
    $(document).on action, '['+action+']', ->
      data = $(@).data()
      data.publisher = $(@)
      self.publish($(@).attr(action), data)

  publish: (name, data)->
    $(document).trigger(name, data)

  subscribe: (name, callback)->
    $(document).bind name, (event, data)->
      callback(data)
      true