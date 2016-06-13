window.App ||= {}

class App.ImageCroper
  api: null
  selector: '.crop-box .image_main:first'
  minSize: 150
  defaultMinSize: 150

  constructor: ->
    setTimeout((=> @create()), 1000)

  create: ->
    return unless $(@selector).length && $(@selector).attr('src')
    console.log('create')
    @minSize = @build_demensions()
    @updatePreviewBlock()
    @api = $.Jcrop @selector, {
      aspectRatio: 1
      setSelect: [0, 0, @minSize, @minSize]
      minSize: [@minSize, @minSize]
      maxSize: [500, 500]
      allowSelect: false
      onSelect: @update
      onUpdate: @update
      onRelease: @releaseCheck
    }

  build_demensions: ->
    elm = $(@selector)
    width = parseInt(elm.attr('width'))
    height = parseInt(elm.attr('height'))
    if width < @defaultMinSize || height < @defaultMinSize
      return width if width < @defaultMinSize
      return height
    @defaultMinSize

  updatePreviewBlock: ->
    $('.crop-preview').css
      width: @minSize
      height: @minSize

  setMinSize: (width, height)->
    if width < height && width < @defaultMinSize
      @minSize = width
    else if height < width && height < @defaultMinSize
      @minSize = height
    else
      @minSize = @defaultMinSize

    @updatePreviewBlock()


  recreate: ->
    if @api
      @api.destroy()
    @create()

  update: (coords) =>
    $('.crop_x').val(coords.x)
    $('.crop_y').val(coords.y)
    $('.crop_h').val(coords.h)
    $('.crop_w').val(coords.w)
    @updatePreview(coords)

  updatePreview: (coords) =>
    main_img = $('.crop-box .image_main')
    $('.crop-preview img').css
      width: Math.round(@minSize/coords.w * main_img.width()) + 'px'
      heigth: Math.round(@minSize/coords.h * main_img.height()) + 'px'
      marginLeft: '-' + Math.round(@minSize/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(@minSize/coords.h * coords.y) + 'px'

  releaseCheck: ->
    this.setOptions
      setSelect: [0, 0, @minSize, @minSize]
      minSize: [@minSize, @minSize]


