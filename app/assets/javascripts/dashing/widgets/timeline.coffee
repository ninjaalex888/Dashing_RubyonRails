class Dashing.Timeline extends Dashing.Widget

  ready: ->
    if `this.node.getAttribute("events").length>2`
        `events=this.node.getAttribute("events")`
        `events0=events.replace(/\s\s+/g, '')`
        events1=events.replace(/{"events":/i,'')
        events2=events1.replace(/"name"/g,'name')
        events3=events2.replace(/"date"/g,'date')
        events4=events3.replace(/"background"/g, 'background')
        events5=events4.replace(/}$/,"" )
        `event=eval(events5)`
        @renderTimeline(event)


  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node` E8F770 616161
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.
    if data.events
        @renderTimeline(data.events)

  renderTimeline: (events) ->
    TimeKnots.draw(".timeline", events, {horizontalLayout: false, color: "#222222", height: 550, width:340, showLabels: true, labelFormat:"%H:%M"});
    


 