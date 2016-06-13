window.App ||= {}

class App.Loader
  constructor: ->
    @loader = $('.loading-img')

  build: (selector)->
    @container = $(selector)
    unless $(selector).find('.loading-img').length
      @container.addClass('position-relative')
      @container.append(@loader.clone().removeClass('hide'))

  destroy: ->
    if @container && @container.length
      @container.find('.loading-img').remove()
      @container.removeClass('position-relative')
      @container = null