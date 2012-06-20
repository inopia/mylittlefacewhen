window.FeedbackView = Backbone.View.extend
  # Feedback submission form

  el: "#content"

  initialize: ->
    @template = tpl.get("feedback")

  events:
    "click #feedbackSubmit": "submit"
    
  render: ->
    @updateMeta()
    @$el.html Mustache.render(@template, {"message":"Submit feedback"})
    return @

  updateMeta: ->
    $("title").html "Feedback - MyLittleFaceWhen"
    $("meta[name=description]").attr "content", "Any suggestions or other feedback is more than welcome."
    $("#og-image").attr "content", "http://mylittlefacewhen.com/static/cheerilee-square-300.png"
    $("#cd-layout").remove()
    $("link[rel=image_src]").remove()

  submit: (event) ->
    # submit feedback through backbone model
    event.preventDefault()
    $(event.currentTarget).attr("disabled", "true")
    fb = new Feedback
      contact: $("#id_contact").val()
      feedback: $("#id_feedback").val()


    response = (model, response) ->
      $(event.currentTarget).removeAttr("disabled")
      $("#dialog form").hide("fast")
      $("#dialog h2")
        .html("Thanks for your feedback!")
        .after($("<h4>").html("You will be redirected to complimentary poni!").css("text-align","center"))
      setTimeout 'app.random();', 4000


    fb.save undefined,
      success: response
      error: response
        
    return undefined
