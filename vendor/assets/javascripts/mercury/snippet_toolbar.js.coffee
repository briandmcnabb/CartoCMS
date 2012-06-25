class @Mercury.SnippetToolbar extends Mercury.Toolbar

  constructor: (@document, @options = {}) ->
    @_boundEvents = []
    super(@options)


  build: ->
    @element = jQuery('<div>', {class: 'mercury-toolbar mercury-snippet-toolbar', style: 'display:none'})
    @element.appendTo(jQuery(@options.appendTo).get(0) ? 'body')

    for own buttonName, options of Mercury.config.toolbars.snippets
      button = @buildButton(buttonName, options)
      button.appendTo(@element) if button


  bindEvents: ->
    @bindReleasableEvent Mercury, 'show:toolbar', (event, options) =>
      return unless options.snippet
      options.snippet.mouseout => @hide()
      @show(options.snippet)

    @bindReleasableEvent Mercury, 'hide:toolbar', (event, options) =>
      return unless options.type && options.type == 'snippet'
      @hide(options.immediately)

    @bindReleasableEvent jQuery(@document), 'scroll', =>
      @position() if @visible

    @element.mousemove =>
      clearTimeout(@hideTimeout)

    @element.mouseout =>
      @hide()


  bindReleasableEvent: (target, eventName, handler)->
    target.on eventName, handler
    @_boundEvents.push [target, eventName, handler]


  show: (@snippet) ->
    Mercury.tooltip.hide()
    @position()
    @appear()


  position: ->
    offset = @snippet.offset()

    top = offset.top + Mercury.displayRect.top - jQuery(@document).scrollTop() - @height() + 10
    left = offset.left - jQuery(@document).scrollLeft()

    @element.css {
      top: top
      left: left
    }


  appear: ->
    clearTimeout(@hideTimeout)
    return if @visible
    @visible = true
    @element.css({display: 'block', opacity: 0})
    @element.stop().animate({opacity: 1}, 200, 'easeInOutSine')


  hide: (immediately = false) ->
    clearTimeout(@hideTimeout)
    if immediately
      @element.hide()
      @visible = false
    else
      @hideTimeout = setTimeout =>
        @element.stop().animate {opacity: 0}, 300, 'easeInOutSine', =>
          @element.hide()
        @visible = false
      , 500

  release: ->
    @element.off()
    @element.remove()
    target.off(eventName, handler) for [target, eventName, handler] in @_boundEvents
    @_boundEvents = []

