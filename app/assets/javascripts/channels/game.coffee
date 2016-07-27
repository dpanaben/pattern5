App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    @printMessage("Waiting for opponent...")

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    switch data.action
      when "game_start"
        App.board.position("start")
        App.board.orientation(data.msg)
        @printMessage("Game started! You play as #{data.msg}.")
      when "make_move"
        [source, target] = data.msg.split("-")
        App.chess.move
          from: source
          to: target
          promotion: "q"
        App.board.position(App.chess.fen())
      when "opponent_forfeits"
        @printMessage("Opponent forfeits. You win!")

  printMessage: (message) ->
    $("#messages").append("<div>#{message}</div>")
