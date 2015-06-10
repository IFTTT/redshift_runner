require "redshift_runner/version"
require "redshift_runner/connection"
require "redshift_runner/result"
require "pg"

module RedshiftRunner

  # def self.exec_query(query_str, readonly=false)
  def self.exec_query(query_str, connection=:default)    
    start_time = DateTime.now    
    begin
      Connection.send(connection).send(:exec_params, query_str)
    rescue PG::Error => err
      err.result
    end
    RedshiftRunner::Result.new(result, query_str, start_time)
  end

end