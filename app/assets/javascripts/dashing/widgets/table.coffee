class Dashing.Table extends Dashing.Widget
  ready: ->
    if `this.node.getAttribute("urlLink").length>2`
      `this.node.querySelector("#mylink")['href'] = this.node.getAttribute("urlLink")` 
  onData: (data) ->
    `id="table"+this.node.getAttribute("id").slice(8)`
    if `document.getElementById(id)`!=null
      `document.getElementById(id).parentNode.removeChild(document.getElementById(id))`


    
    

  



