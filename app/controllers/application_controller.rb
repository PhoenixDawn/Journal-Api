class ApplicationController < ActionController::API
  @@jwt_secret = "mySecretKey"

  def authenticate
    begin
      token = request.headers["Authorization"]&.split(" ")[1]
      payload = JWT.decode(token, @@jwt_secret, true, { algorithm: "HS512" })[0]
      @email = payload["email"]
    rescue
      render json: { error: "Invalid Token" }
    end
  end
end
