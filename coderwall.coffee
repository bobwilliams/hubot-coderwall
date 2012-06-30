# Uses the coderwall profile api for the given coderwall username
#
# coderwall for <username> - Retrieves the coderwall badges for the given user.
module.exports = (robot) ->
  robot.respond /coderwall (?:for )?(.*)/i, (msg) ->
    username = msg.match[1]
    msg.http("http://coderwall.com/" + username + ".json").get() (err, res, body) ->
      if res.statusCode is 404
        msg.send "I could not find " + username + " on coderwall."
      else
        profile = JSON.parse(body)
        response = profile.name + " from " + profile.location + " \n" 
        response += "github: https://github.com/" + profile.accounts.github + "\n"
        response += "Has " + profile.endorsements + " endorsements and " + profile.badges.length + " badges\n"
        profile.badges.forEach (badge) ->
          response += badge.name + " - " + badge.description + "\n"

        msg.send response
