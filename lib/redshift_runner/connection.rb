module RedshiftRunner
  class Connection   

    def self.establish_readonly
      @readonly ||= new(*args)
    end

    def self.establish_readwrite
      @readwrite ||= new(*args)
    end

    def self.readonly
      @readonly
    end

    def self.readwrite
      @readwrite
    end

    def initialize(host, port, user, password, dbname)
      PG::Connection.new(
        :host => host,
        :port => port,
        :user => user,
        :password => password,
        :dbname => dbname,
      )
    end
  end
end