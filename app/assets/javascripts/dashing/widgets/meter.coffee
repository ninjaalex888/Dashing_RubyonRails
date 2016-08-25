class Dashing.Meter extends Dashing.Widget

  @accessor 'value', Dashing.AnimatedValue

  constructor: ->
    super
    @observe 'value', (value) ->
      $(@node).find(".meter").val(value).trigger('change')

  ready: ->
    `this.node.querySelector("#mylink")['href'] = this.node.getAttribute("urlLink")` 
    meter = $(@node).find(".meter")
    meter.attr("data-bgcolor", meter.css("background-color"))
    meter.attr("data-fgcolor", meter.css("color"))
    meter.knob()
    `this.node.querySelector("#updated").textContent = this.node.getAttribute("updated")`
    `value=this.node.getAttribute("value")`
    $(@node).find(".meter").val(value).trigger('change')
