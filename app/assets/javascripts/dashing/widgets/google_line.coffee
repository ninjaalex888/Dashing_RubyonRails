class Dashing.GoogleLine extends Dashing.Widget

  @accessor 'current', ->
    return @get('displayedValue') if @get('displayedValue')
    points = @get('points')
    if points
      points[points.length - 1].y

  ready: ->
    `this.node.querySelector("#mylink")['href'] = this.node.getAttribute("urlLink")` 
    container = $(@node).parent()
  # Gross hacks. Let's fix this.
    width = (Dashing.widget_base_dimensions[0] * container.data("sizex")) + Dashing.widget_margins[0] * 2 * (container.data("sizex") - 1)
    height = (Dashing.widget_base_dimensions[1] * container.data("sizey"))

    colors = null
    if @get('colors')
      colors = @get('colors').split(/\s*,\s*/)

    @chart = new google.visualization.LineChart($(@node).find(".chart")[0])
    @options =
      height: height
      width: width
      colors: colors
      backgroundColor:
        fill:'transparent'
      legend:
        position: @get('legend_position')
      animation:
        duration: 500,
        easing: 'out'
      vAxis:
       format: @get('vaxis_format')
      curveType: @get('curve_type')

    if @get('points')
      @data = google.visualization.arrayToDataTable @get('points')
    else
      `var points=this.node.getAttribute("points")`
      points=points.replace(/nil/g, 'null')
      @data = google.visualization.arrayToDataTable eval(points)

    @chart.draw @data, @options

  onData: (data) ->
    if @chart
      @data = google.visualization.arrayToDataTable data.points
      @chart.draw @data, @options