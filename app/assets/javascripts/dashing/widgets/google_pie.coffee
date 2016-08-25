class Dashing.GooglePie extends Dashing.Widget

  ready: ->
    if `this.node.getAttribute("urlLink").length>2`
      `this.node.querySelector("#mylink")['href'] = this.node.getAttribute("urlLink")` 
    container = $(@node).parent()
  # Gross hacks. Let's fix this.
    width = (Dashing.widget_base_dimensions[0] * container.data("sizex")) + Dashing.widget_margins[0] * 2 * (container.data("sizex") - 1)
    height = (Dashing.widget_base_dimensions[1] * container.data("sizey"))

    colors = null
    if @get('colors')
      colors = @get('colors').split(/\s*,\s*/)

    @chart = new google.visualization.PieChart($(@node).find(".chart")[0])
    @options =
      height: height
      width: width
      sliceVisibilityThreshold: 0
      colors: colors
      is3D: @get('is_3d')
      pieHole: 0.4
      pieStartAngle: @get('pie_start_angle')
      backgroundColor: 'transparent'
      pieSliceText: 'value'
      legend: {
        color: 'black'
        position: @get('legend_position')
        position: 'labeled'
        labeledValueText: 'value',
        textStyle: {
            color: 'black', 
            fontSize: 16
        }
      }
        # labeledValueText: 'both'


    `var slices=this.node.getAttribute("slices")`
    @data = google.visualization.arrayToDataTable eval(slices)
    @chart.draw @data, @options

  onData: (data) ->
    if @chart
      @data = google.visualization.arrayToDataTable data.slices
      @chart.draw @data, @options
