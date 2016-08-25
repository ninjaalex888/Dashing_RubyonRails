module Coupa
  class PermissionsService
    def initialize(user)
      @client = Octokit::Client.new(login: user.login, password: user.token)
    end

    def call(check_type)
      case check_type
      when "is_coupa_user"
        is_coupa_user?
      else
        true
      end
    end

    private
    def is_coupa_user?
      @client.organizations.map { |org| org[:login] }.include?("coupa") || @client.login=="carpathiaxiv"
    end
  end
end
