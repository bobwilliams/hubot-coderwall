# Uses the coderwall profile api for the given coderwall user
#
# coderwall for <username> - Retrieves the coderwall badges for the given user.
module.exports = (robot) ->
  robot.respond /coderwall (?:for )?(.*)/i, (msg) ->
    username = msg.match[1]

    msg.http("http://coderwall.com/#{username}.json").get() (err, res, body) ->
      if res.statusCode is 404
        msg.send "I could not find #{username} on coderwall."
      else
        json = JSON.parse(body)
        response = "http://coderwall.com/#{username}\n";
        json.badges.forEach (badge) ->
          response += badge["badge"] + " " + badge.name + " - " + badge.description + "\n"
        msg.send response
