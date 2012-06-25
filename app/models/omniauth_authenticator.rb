class OmniauthAuthenticator
  class << self

    def create_authentication(storage_object, auth_hash)
      storage_object.create do |c|
        c.provider = auth_hash.provider
        c.uid      = auth_hash.uid.to_s
        c.token    = auth_hash.credentials.token
        c.secret   = auth_hash.credentials.secret
        c.url      = auth_hash.info.urls.select { |k,v| v if v && v.include?(auth_hash.provider) }.values[0]
        c.username = auth_hash.info.nickname
      end
    end

    def find_authentication(storage_object, auth_hash)
      storage_object.where(provider: auth_hash.provider, uid: auth_hash.uid.to_s).first
    end

    def find_or_create_authentication(storage_object, auth_hash)
      find_authentication(storage_object, auth_hash) || create_authentication(storage_object, auth_hash)
    end
  end
end